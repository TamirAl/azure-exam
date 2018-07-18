. ..\connect-azure.ps1

Connect-Azure

$vmName = "windows"
$storageName = "dotnetdemostorage"

Publish-AzureRmVMDscConfiguration `
  -ConfigurationPath ..\iisInstall.ps1 `
  -ResourceGroupName storage -StorageAccountName $storageName

Set-AzureRmVmDscExtension -Version 2.21 `
  -ResourceGroupName VMs -VMName $vmName `
  -ArchiveStorageAccountName $storageName `
  -ArchiveBlobName iisInstall.ps1.zip -AutoUpdate:$true `
  -ConfigurationName "IISInstall"
