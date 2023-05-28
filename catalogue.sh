echo -e "\e[33mConfiguring Nodejs Server\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash  &>> /tmp/roboshop.log
echo -e "\e[33mInstalling  Nodejs Server\e[0m"
yum install nodejs -y &>> /tmp/roboshop.log
echo -e "\e[33mAdding user\e[0m"
useradd roboshop
echo -e "\e[33mMake directory\e[0m"
mkdir /app &>> /tmp/roboshop.log
echo -e "\e[33mChanging code Server\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>> /tmp/roboshop.log
echo -e "\e[33mUnzipping code\e[0m"
cd /app
unzip /tmp/catalogue.zip &>> /tmp/roboshop.log
cd /app
echo -e "\e[33mInstalling Dependencies\e[0m"
npm install &>> /tmp/roboshop.log
echo -e "\e[33mConfiguring Service file\e[0m"
cp /home/centos/roboshop-shell/catalogue.service /etc/systemd/system/catalogue.service &>> /tmp/roboshop.log
systemctl daemon-reload
echo -e "\e[33mInstalling repo file\e[0m"
cp /home/centos/roboshop-shell/Mongo.repo /etc/yum.repos.d/mongodb.repo &>> /tmp/roboshop.log
yum install mongodb-org-shell -y &>> /tmp/roboshop.log
echo -e "\e[33mConfiguring host\e[0m"
mongo --host mongodb-dev.rkdevops.store </app/schema/catalogue.js &>> /tmp/roboshop.log
echo -e "\e[33mEnabling and restarting Server\e[0m"
systemctl enable catalogue &>> /tmp/roboshop.log
systemctl restart catalogue