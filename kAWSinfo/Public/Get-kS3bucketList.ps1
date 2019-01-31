function Get-kS3bucketList {
<#
.SYNOPSIS
    Short description
.DESCRIPTION
    Long description
.EXAMPLE
    PS C:\> <example usage>
    Explanation of what the example does
.INPUTS
    Inputs (if any)
.OUTPUTS
    Output (if any)
.NOTES
    General notes
#>
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$False,HelpMessage="Error: Please Enter A Profile Name")][String]$ProfileName,
        [Switch]$GovCloudOnly
    )
    if($GovCloudOnly.IsPresent){
        SetSessionCredential -ProfileName $ProfileName -GovCloudOnly
    }
    else {
        SetSessionCredential -ProfileName $ProfileName 
    }
    Get-S3Bucket -ProfileName $ProfileName
}