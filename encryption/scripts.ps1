. .\connect-azure.ps1

Connect-Azure

Set-AzureRmKeyVaultAccessPolicy -VaultName 'DotnetKeyVault' `
  -ServicePrincipalName c2d36441-34ac-4240-b631-3ecd128a29e4 `
  -PermissionsToKeys decrypt, sign

# Key vault
Add-AzureKeyVaultKey -VaultName 'DotnetKeyVault' -Name 'FirstKey' -Destination 'Software'
$secretvalue = ConvertTo-SecureString 'Pa$$w0rd' -AsPlainText -Force
$secret = Set-AzureKeyVaultSecret -VaultName 'DotnetKeyVault' -Name 'SQLPassword' -SecretValue $secretvalue
Write-Host (Get-AzureKeyVaultSecret -vaultName "DotnetKeyVault" -name "SQLPassword").SecretValueText