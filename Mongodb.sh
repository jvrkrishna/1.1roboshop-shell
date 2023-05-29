echo -e "\e[33mCopying yum repo file\e[0m"
cp Mongo.repo  /etc/yum.repos.d/mongodb.repo &>>/tmp/roboshop.log
echo -e "\e[33mInstalling Mongodb Server\e[0m"
yum install mongodb-org -y  &>>/tmp/roboshop.log
echo -e "\e[33mUpdate Listen address\e[0m"
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
echo -e "\e[33mEnabling and starting Mongodb server\e[0m"
systemctl enable mongod
systemctl restart mongod

