#Get Secrets from Keyvault
$secret1 = Get-AzKeyVaultSecret -VaultName "fmz-n-kv-secretrotate-01" -Name "secret1" -AsPlainText
$secret2 = Get-AzKeyVaultSecret -VaultName "fmz-n-kv-secretrotate-01" -Name "secret2" -AsPlainText

#Authentication to TFC from Powershell
$tfctoken = ""
$TfcAuthenticationHeader = @{Authorization = 'Basic ' + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$($tfctoken)")) }

#Rest APIs to update variable set 1
$updatevar1 = "https://app.terraform.io/api/v2/varsets/varset-WTNyC9Mxawiw2QWu/relationships/vars/var-vKJtaBxvnnBrakQ8"
$updatevar2 = "https://app.terraform.io/api/v2/varsets/varset-WTNyC9Mxawiw2QWu/relationships/vars/var-Ho9KvaejS8niqWZ4"

#Request Body

$body1 = @'
{
  "data": {
    "type": "vars",
    "attributes": {
      "key": "secret1",
      "value": $secret1, 
      "description": "",
      "sensitive": false,
      "category": "terraform",
      "hcl": false
    }
  }
}
'@ 

$body2 = @'
{
  "data": {
    "type": "vars",
    "attributes": {
      "key": "secret2",
      "value": $secret2,
      "description": "",
      "sensitive": false,
      "category": "terraform",
      "hcl": false
    }
  }
}
'@ 
	

#Invoke Restapi
Invoke-RestMethod -Uri $updatevar1 -Body $body1 -Method PATCH -ContentType 'application/vnd.api+json' -headers $headers

#Invoke Restapi
#Invoke-RestMethod -Uri $updatevar2 -Body $body2 -Method PATCH -ContentType 'application/vnd.api+json' -headers $headers

