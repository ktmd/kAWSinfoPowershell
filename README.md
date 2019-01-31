# kAWSinfoPowershell
A simple Powershell module to do some basic AWS tassks

# Sample tests
```
PowerShell Integrated Console
PS C:\Projects\kAWSinfoPowershell> .\runtest_Get-kEC2AllRegionInstanceStat.ps1
Test AWS commercial

Profile            : test1
Region             : us-east-1
InstanceID         : i-0b9b9f71bddfee49
LastLaunchTime     : 1/28/2019 8:31:21 AM
CPUmetricAvg       :
CPUmetricStartTime :
State              : stopped

```
######
```
PS C:\Projects\kAWSinfoPowershell> .\runtest_Get-kS3bucketList.ps1

Test AWS commercial

CreationDate : 1/25/2019 2:10:08 PM
BucketName   : cf-templates-1vwwjztlz5ihr-us-east-1

```
#####
```
PS C:\Projects\kAWSinfoPowershell> .\runtest_Get-kUserList.ps1

Test AWS commercial

UserName         : Administrator
CreateDate       : 11/26/2018 2:05:26 PM
PasswordLastUsed : 1/28/2019 4:51:27 PM
```
#####
```
PS C:\Projects\kAWSinfoPowershell> cd .\Tests
PS C:\Code\Projects\kAWSinfoPowershell\Tests> Invoke-Pester
Executing all tests in '.'

Executing script C:\Projects\kAWSinfoPowershell\Tests\Get-kS3BucketList.Tests.ps1

  Describing Get-kS3BucketList

    Context No parameter is provided
      [+] Got Exception ERROR01 133ms

    Context Parameter is provided
      [+] with a profile name return something 260ms
      [+] with a profile name return 3 or more lines 17ms

Executing script C:\Projects\kAWSinfoPowershell\Tests\Get-kUserList.Tests.ps1

  Describing Get-kUserlist

    Context No parameter is provided
      [+] Got Exception ERROR01 13ms

    Context Parameter is provided
      [+] with a profile name return something 8ms
      [+] with a profile name return 3 or more lines 4ms
Tests completed in 17.06s
Tests Passed: 6, Failed: 0, Skipped: 0, Pending: 0, Inconclusive: 0

```
