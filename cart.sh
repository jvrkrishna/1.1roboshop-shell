echo -e '\e[33mDownloading Nodejs\e[30m'
curl -sL https://rpm.nodesource.com/setup_18.x | sudo -E bash - &>>/tmp/roboshop.log
echo -e '\e[33mInstalling Nodejs\e[30m'
yum install nodejs -y &>>/tmp/roboshop.log
echo -e '\e[33mCreating user\e[30m'
useradd roboshop
mkdir /app
cd /app
echo -e '\e[33mDownloading and unzipping the new app content\e[30m'
curl -L -o cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip &>>/tmp/roboshop.log
unzip cart.zip &>>/tmp/roboshop.log
echo -e '\e[33mInstalling dependencies\e[30m'
npm install &>>/tmp/roboshop.log
echo -e '\e[33mCreating service file\e[30m'
cp /home/centos/roboshop-shell/cart.service /etc/systemd/system/cart.service &>>/tmp/roboshop.log
systemctl daemon-reload &>>/tmp/roboshop.log
echo -e '\e[33mEnabling and restarting server\e[30m'
systemctl enable cart &>>/tmp/roboshop.log
systemctl restart cart &>>/tmp/roboshop.log



