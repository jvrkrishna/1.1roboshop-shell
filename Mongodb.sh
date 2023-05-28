echo -e "\e[33mCopying yum repo file\e[0m"
cp Mongo.repo  /etc/yum.repos.d/mongodb.repo &>>/tmp/roboshop.log
echo -e "\e[33mInstalling Mongodb Server\e[0m"
yum install mongodb-org -y  &>>/tmp/roboshop.log
#Edit Mogod.conf file
echo -e "\e[33mEnabling and starting Mongodb server\e[0m"
systemctl enable mongod
systemctl start mongod

