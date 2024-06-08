#!/bin/bash
sudo yum update -y
sudo yum install -y httpd

export TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"`
export META_INST_ID=`curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/instance-id`
export META_INST_TYPE=`curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/instance-type`
export META_INST_AZ=`curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/placement/availability-zone`

systemctl start httpd
systemctl enable httpd
echo "<h1>Welcome to the Three Tier Application v0.0.2!</h1>" > /var/www/html/index.html
echo "<p>Instance ID: $META_INST_ID</p>" >> /var/www/html/index.html
echo "<p>Instance Type: $META_INST_TYPE</p>" >> /var/www/html/index.html
echo "<p>Availability Zone: $META_INST_AZ</p>" >> /var/www/html/index.html
