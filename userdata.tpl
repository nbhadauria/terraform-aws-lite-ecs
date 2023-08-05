#! /bin/bash

set -eux

echo "### HARDENING DOCKER"
sed -i "s/1024:4096/65535:65535/g" "/etc/sysconfig/docker"

echo "### HARDENING EC2 INSTACE"
echo "ulimit -u unlimited" >> /etc/rc.local
echo "ulimit -n 1048576" >> /etc/rc.local
echo "vm.max_map_count=262144" >> /etc/sysctl.conf
echo "fs.file-max=65536" >> /etc/sysctl.conf
/sbin/sysctl -p /etc/sysctl.conf


echo "### INSTALL PACKAGES"
yum update -y
yum install -y amazon-efs-utils aws-cli

echo "### SETUP EFS"
EFS_DIR=/mnt/efs
EFS_ID=${tf_efs_id}

mkdir -p $${EFS_DIR}
echo "$${EFS_ID}:/ $${EFS_DIR} efs tls,_netdev" >> /etc/fstab

for i in $(seq 1 20); do mount -a -t efs defaults && break || sleep 60; done

mkdir /mnt/efs/${tf_cluster_name} && chmod 777 /mnt/efs/${tf_cluster_name}

echo "### SETUP AGENT"

echo "ECS_CLUSTER=${tf_cluster_name}" >> /etc/ecs/ecs.config
echo "ECS_ENABLE_SPOT_INSTANCE_DRAINING=true" >> /etc/ecs/ecs.config

echo "### Check and Update EIP"
INSTANCE_ID=`curl -w '\n' -s http://169.254.169.254/latest/meta-data/instance-id`

ALLOCATION_ID=`aws --region ${tf_aws_region} ec2 describe-addresses --allocation-ids ${tf_aws_eip} --query 'Addresses[0].AssociationId' --output text`
aws --region ${tf_aws_region} ec2 disassociate-address --allocation-id $${ALLOCATION_ID} || true
sleep 30
aws --region ${tf_aws_region} ec2 associate-address --allocation-id ${tf_aws_eip} --instance-id $${INSTANCE_ID}

echo "### EXTRA USERDATA"
${userdata_extra}
