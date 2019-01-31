import-module .\kAWSinfo -force
 
$profile_name='test1'

write-host "Test AWS commercial"
Get-kEC2AllRegionInstanceStat -ProfileName $profile_name | select -First 1

