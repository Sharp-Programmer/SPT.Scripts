Param(
    [string] [Parameter(Mandatory=$true)] $location,
    [string] [Parameter(Mandatory=$true)] $resourceGroupName,
    [object] $tags
)

try {
    [Microsoft.Azure.Common.Authentication.AzureSession]::ClientFactory.AddUserAgent("VSAzureTools-$UI$($host.name)".replace(' ','_'), '3.0.0')
} catch { }


Set-StrictMode -Version 3

$rg = Get-AzResourceGroup -Name $resourceGroupName -Location $location -ErrorVariable notExist -ErrorAction SilentlyContinue;

if($notExist){
    try{
        $rg = New-AzResourceGroup -Name $resourceGroupName -Location $location -Tag $tags -Verbose -Force -ErrorVariable createError -ErrorAction Stop;
    }
    catch{
        Write-Output "An error occured while creating resource group";
        "Error:  '$createError'";
    }
}
else {
    "Resource group '$resourceGroupName' already exist";
}    
