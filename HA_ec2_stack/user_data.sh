#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd

TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
INSTANCE_ID=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/instance-id)
AZ=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/placement/availability-zone)

echo "<h1>Highly Available Web Cluster</h1>" > /var/www/html/index.html
echo "<p><b>Instance ID:</b> $INSTANCE_ID</p>" >> /var/www/html/index.html
echo "<p><b>Availability Zone:</b> $AZ</p>" >> /var/www/html/index.html
