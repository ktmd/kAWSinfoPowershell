function Get-kS3BucketStat {
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
        [Parameter(Mandatory=$True,HelpMessage="Error: Please Enter A RegionName")]$RegionName,
        [Parameter(Mandatory=$True,HelpMessage="Error: Please Enter A Bucket Name")]$BucketName,
        [Parameter(Mandatory=$False,HelpMessage="Error: Please Enter Start Time")]$StartDateTime,
        [Parameter(Mandatory=$False,HelpMessage="Error: Please Enter End Time")]$EndDateTime
    )

    $Now=Get-Date
    $UTCStartTime=$Now.AddDays(-2).ToUniversalTime()
    $UTCEndTime=$Now.ToUniversalTime()

    $NO=Get-CWMetricStatistics -ProfileName $ProfileName -Region $RegionName -MetricName NumberOfObjects  `
        -Namespace "AWS/S3" -Period 3600 -Statistics Maximum `
        -utcStartTime $UTCStartTime -utcEndTime $UTCEndTime `
        -Dimension @(@{Name = "BucketName"; Value = $BucketName},@{Name = "StorageType"; Value = "AllStorageTypes"})
    
    $CN=Get-CWMetricStatistics -ProfileName $ProfileName -Region $RegionName -MetricName BucketSizeBytes  `
         -Namespace "AWS/S3"     -Period 3600 -Statistics Maximum `
         -utcStartTime $UTCStartTime -utcEndTime $UTCEndTime `
         -Dimension @(@{Name = "BucketName"; Value = $BucketName},@{Name = "StorageType"; Value = "StandardStorage"})
    
    $output=[PSCustomObject]@{
        Profile=$ProfileName;
        Region=$RegionName;
        Bucket=$BucketName;
        NumberofObjects=$NO.Datapoints[0].Maximum;
        Size=$CN.Datapoints[0].Maximum;
        UTCStartime=$UTCStartTime.DateTime;
        UTCEndTime=$UTCEndTime.DateTime
        }

    write-output $output
}

