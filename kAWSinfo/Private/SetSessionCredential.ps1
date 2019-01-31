function SetSessionCredential {
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
    [CmdletBinding(SupportsShouldProcess)]
    Param(
       [String] $ProfileName='default',
       [Switch]$GovCloudOnly
    ) 


    If ($PSCmdlet.ShouldProcess($ProfileName, "Set session credential to ProfileName")) {
        try{
           if ($GovCloudOnly) {
                Set-DefaultAWSRegion -Region 'us-gov-west-1'
            }
           else {
                Set-DefaultAWSRegion -Region 'us-east-1'
           }
           Set-AWSCredential -ProfileName $ProfileName -ErrorAction Stop
           $postCredential=$(Get-AWSCredential).GetCredentials()
           $user=Get-IAMUser
           $accountalias=Get-IAMAccountAlias 
           
           $cred=[PsCustomObject]@{
             AccountAlias=$accountalias
             UserName=$user.UserName
             UserArn=$user.Arn
             AccessKey=$postCredential.AccessKey
             SecretKeyPrefix=$postCredential.SecretKey.Substring(0,10)
             Token=$postCredential.Token
             UseToken=$postCredential.UseToken
           }
           Write-Verbose $cred
        }    
        Catch {
            $error="ERROR01:Set-AWSCredential has issue with credential profile"
            throw $error
        }
        finally {
            Write-Verbose "**Be sure to use -GovCloudOnly switch for accessing Government cloud"
        }
    }
}

