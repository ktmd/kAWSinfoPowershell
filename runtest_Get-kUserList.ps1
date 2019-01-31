import-module .\kAWSinfo -force
get-command -module kAWSinfo  

$profile_name='test1'

write-host "Test AWS commercial"
Get-kUserList -ProfileName $profile_name | select -First 1

