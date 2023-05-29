echo -e '\e[33mDownloading Nodejs\e[30m'
curl -sL https://rpm.nodesource.com/setup_18.x | sudo -E bash - &>>/tmp/roboshop.log
echo -e '\e[33mInstalling Nodejs\e[30m'
yum install nodejs -y &>>/tmp/roboshop.log
echo -e '\e[33mCreating user\e[30m'
useradd roboshop
mkdir /app
cd /app
echo -e '\e[33mDownloading and unzipping the new app content\e[30m'
curl -L -o user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip &>>/tmp/roboshop.log
unzip user.zip &>>/tmp/roboshop.log
echo -e '\e[33mInstalling dependencies\e[30m'
npm install &>>/tmp/roboshop.log
echo -e '\e[33mCreating service file\e[30m'
cp /home/centos/roboshop-shell/user.service /etc/systemd/system/user.service &>>/tmp/roboshop.log
systemctl daemon-reload &>>/tmp/roboshop.log
echo -e '\e[33mDownloading mongodb\e[30m'
cp /home/centos/roboshop-shell/Mongo.repo /etc/yum.repos.d/mogo.repo &>>/tmp/roboshop.log
echo -e '\e[33mInstalling mongodb\e[30m'
yum install mongodb-org -y &>>/tmp/roboshop.log
echo -e '\e[33mLoading schema\e[30m'
mongo --host mongodb-dev.rkdevops.store </app/schema/user.js &>>/tmp/roboshop.log
echo -e '\e[33mEnabling and restarting server\e[30m'
systemctl enable user &>>/tmp/roboshop.log
systemctl restart user &>>/tmp/roboshop.log



