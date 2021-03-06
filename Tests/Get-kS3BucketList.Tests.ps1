$profile_name='test1'
$parentPath=Split-Path  -Path $(Get-Variable -Name PSScriptRoot -ValueOnly)
import-module $parentPath\kAWSinfo -Force

Describe "Get-kS3BucketList" {
    Context "No parameter is provided" {
     It "Got Exception ERROR01" {
        {Get-kS3BucketList} | Should -Throw -ErrorId "ERROR01:Set-AWSCredential has issue with credential profile"
     }
    }
    Context "Parameter is provided" {
     $result=Get-kS3BucketList -ProfileName $profile_name
     It "with a profile name return something" {
        $result | Should Not BeNullOrEmpty
     }
     It "with a profile name return 3 or more lines" {
        ($result).count | Should -not -BeLessThan 1
     }
    }
}
