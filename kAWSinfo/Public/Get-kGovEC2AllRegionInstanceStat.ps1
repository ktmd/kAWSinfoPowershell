function Get-kGovEC2AllRegionInstanceStat {
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
        [Parameter(Mandatory=$True,HelpMessage="Error: Please Enter A Profile Name")]$ProfileName,
        [Parameter(Mandatory=$False,HelpMessage="Error: Please Enter Start Time")]$UTCStartDateTime,
        [Parameter(Mandatory=$False,HelpMessage="Error: Please Enter End Time")]$UTCEndDateTime
    ) 
  
    $regions=Get-AWSRegion -GovCloudOnly
    $regions | ForEach-Object {
      $region = $_.Region
      Get-kEC2InstanceStat -ProfileName $ProfileName -RegionName $region 
    }
}

