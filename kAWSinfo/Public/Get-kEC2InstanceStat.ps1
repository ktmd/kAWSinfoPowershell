function Get-kEC2InstanceStat {
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
        [Parameter(Mandatory=$False,HelpMessage="Error: Please Enter Start Time")]$UTCStartDateTime,
        [Parameter(Mandatory=$False,HelpMessage="Error: Please Enter End Time")]$UTCEndDateTime
    ) 
  $Now=Get-Date
  $UTCStartDateTime=$Now.AddDays(-8).ToUniversalTime()
  $UTCEndDateTime=$Now.AddDays(-1).ToUniversalTime()
    
  Write-Information "Region=",$RegionName
  $ec2reservation=Get-EC2Instance -ProfileName $ProfileName -Region $RegionName
  $ec2reservation | ForEach-Object {
     $ec2instances=$_.Instances
     $ec2instances | foreach-object {
        $ec2instance = $_
        $CPUavg=$null
        if ($ec2instance.State.Name -eq 'running') {
          $Params = @{
               Namespace = 'AWS/EC2' 
               MetricName = 'CPUUtilization' 
               Dimension = @(
                   @{"Name"="InstanceId";Value=$ec2instance.InstanceId} 
               )
               #Region = $RegionName
               UTCStartTime = $UTCStartDateTime
               UTCEndTime = $UTCEndDateTime
               Period = 60*60*24*7  #one week
               Statistic = 'Average'
          }
          $ec2metrics=Get-CWMetricStatistics @Params -ProfileName $ProfileName -Region $RegionName 
          $CPUavg=$ec2metrics.Datapoints[0].Average
        }

        $output=[PSCustomObject]@{
               Profile=$ProfileName;
               Region=$RegionName;
               InstanceID=$ec2instance.InstanceId;
               LastLaunchTime=$ec2instance.LaunchTime;
               CPUmetricAvg=$CPUavg
               CPUmetricStartTime=$UTCStartTime
               State=$ec2instance.State.Name;
               #StateReason=$ec2instance.StateReason.Message
               }
        write-output $output
     }
  }   
}

