#import-module -Name AWSPowerShell
import-module -Name AWSPowerShell.NetCore

import-module .\kAWSinfo -force
 
$profile_name='test1'
Initialize-AWSDefaultConfiguration -ProfileName $profile_name -Region us-east-1

write-host "Test AWS commercial"


# Windows EC2 instance was created with private key pem file 'C:\Users\a468718\.ssh\a468718_khatran_atos_net'

#Windows_Server-2019-English-Full-Base-2019.03.13 (ami-02d43577e47e684d9)
#New-EC2Instance -ImageId ami-02d43577e47e684d9 -MinCount 1 -MaxCount 1 -KeyName 'C:\Users\a468718\.ssh\a468718_khatran_atos_net' -InstanceType t2.micro -Tag 

#https://chinnychukwudozie.com/2018/01/25/powershell-function-to-provision-a-windows-server-2016-ec2-instance-in-aws-cloud/
# https://docs.aws.amazon.com/powershell/latest/userguide/pstools-ec2-launch.html
#get instance info

$ec2instances=Get-EC2Instance 

$ec2reservations= $ec2instances | Select-Object ReservationId

foreach ($r_id in $ec2reservations) {
   write-host "*****EC2Instance Id=" $r_id.ReservationId
   (Get-EC2Instance -Filter @{Name="reservation-id";Value=$r_id.ReservationId}).Instances | Format-List *
}




ReservationId   : r-b70a0ef1
OwnerId         : 123456789012
RequesterId     :
Groups          : {myPSSecurityGroup}
GroupName       : {myPSSecurityGroup}
Instances       : {}
#
$ec2instanceid="i-0caf5479efec60a50"
$ec2dns="ec2-54-85-220-190.compute-1.amazonaws.com"
$ec2user="Administrator"
$ec2pwd='am7D)hwCQz9Kdu&o(DgFLaI9dCN(aqkz'
$ec2pem='C:\Users\a468718\.ssh\a468718_khatran_atos_net'

#https://docs.aws.amazon.com/cli/latest/reference/ec2/get-password-data.html#examples
#cli
aws ec2 get-password-data --instance-id $ec2instanceid

#
aws ec2 get-password-data --instance-id $ec2instanceid --priv-launch-key $ec2pem 

