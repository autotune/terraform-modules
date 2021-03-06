#!/bin/bash
yum install docker -y 
service docker start
docker run -d -p 80:80 tutum/hello-world

printf '
REGION=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone  | sed -e "s/.$//")

PERFTEST="$(aws ec2 describe-tags --filters "Name=resource-id,Values=$(curl http://169.254.169.254/latest/meta-data/instance-id)" --region $REGION |jq -r ".Tags[]|select(.Key == \\"PerfTest\\").Value")"

if [[ $PERFTEST == "CPU" ]];
then
    printf "$(stress --cpu 8)"

else
    pkill stress
fi

' > /root/failwhale.sh

crontab -l | { cat; echo "*/1 * * * * bash /root/failwhale.sh"; } | crontab -
