#!/bin/bash
set -x

echo "creating custom Bigtop repository"
sudo aws s3 cp s3://<your-bucket>/bigtop/repos/Bigtop_custom.repo  /etc/yum.repos.d/Bigtop_custom.repo
echo "creating application module and manifest directory"
sudo mkdir -p /home/hadoop/bigtop/bigtop-deploy/puppet/modules/elasticsearch/manifests/
echo "changing directory"
cd /home/hadoop/bigtop/bigtop-deploy/puppet/modules/elasticsearch/manifests/
echo "getting puppet recipe"
sudo  wget https://raw.githubusercontent.com/hvivani/aws-big-data-blog/patch-1/aws-blog-bigtop-application-emr/bigtop-deploy/puppet/modules/elasticsearch/manifests/init.pp
echo "creating application template directory"
sudo mkdir -p /home/hadoop/bigtop/bigtop-deploy/puppet/modules/elasticsearch/templates/
echo "changing directory"
cd /home/hadoop/bigtop/bigtop-deploy/puppet/modules/elasticsearch/templates/
echo "getting puppet template"
sudo wget https://raw.githubusercontent.com/hvivani/aws-big-data-blog/patch-1/aws-blog-bigtop-application-emr/bigtop-deploy/puppet/modules/elasticsearch/templates/elasticsearch.yml

echo "running puppet apply"
sudo puppet apply --verbose -d --modulepath=/home/hadoop/bigtop/bigtop-deploy/puppet/modules:/etc/puppet/modules  -e 'include elasticsearch::client'
