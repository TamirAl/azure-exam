. ..\connect-azure.ps1
# Login to your subscription
Connect-Azure

# Identify the VM you want to encrypt by name and resource group name
$rgName = 'storage';
$vmName = 'windows';
 
# Provide the Client ID and Client Secret
$aadClientID = 'c2d36441-34ac-4240-b631-3ecd128a29e4';
$aadClientSecret = '7QpVEJadK2ilqgMoVgLJGFp7RGE9sH2vq7khN8fAKnQ=';
# Get a reference to your Key Vault and capture its URL and Resource ID
$KeyVaultName = 'DotnetKeyVault';

$KeyVault = Get-AzureRmKeyVault -VaultName $KeyVaultName -ResourceGroupName $rgname;

$diskEncryptionKeyVaultUrl = $KeyVault.VaultUri;
$KeyVaultResourceId = $KeyVault.ResourceId;
# Enable Azure to access the secrets in your Key Vault to boot the encrypted VM.
Set-AzureRmKeyVaultAccessPolicy -VaultName $KeyVaultName -ResourceGroupName $rgname -EnabledForDiskEncryption
# Encrypt the VM
Set-AzureRmVMDiskEncryptionExtension -ResourceGroupName 'VMs' -VMName $vmName `
  -AadClientID $aadClientID -AadClientSecret $aadClientSecret `
  -DiskEncryptionKeyVaultUrl $diskEncryptionKeyVaultUrl -DiskEncryptionKeyVaultId $KeyVaultResourceId;