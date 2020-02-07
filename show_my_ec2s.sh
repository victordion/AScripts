#!/bin/bash

region_arg=$1
regions=`aws ec2 describe-regions --region us-west-2 --output text | cut -f3`

for region in $regions
do
    if test -z "$region_arg" || [ $region_arg = $region ]
    then
        echo -e "\nListing Instances in region: $region..."
        aws ec2 describe-instances --region $region | \
            jq '.Reservations[] | ( .Instances[] | {ID: .InstanceId, PublicIpAddress: .PublicIpAddress, KeyName: .KeyName, type: .InstanceType, LaunchTime: .LaunchTime, Tags: .Tags})'
    fi
done
