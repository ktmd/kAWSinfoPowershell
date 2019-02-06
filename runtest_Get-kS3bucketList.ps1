#import-module -Name AWSPowerShell
import-module -Name AWSPowerShell.NetCore

import-module .\kAWSinfo -force
get-command -module kAWSinfo  

$profile_name='test1'

write-host "Test AWS commercial"
Get-kS3bucketList -ProfileName $profile_name | select-object -First 1

