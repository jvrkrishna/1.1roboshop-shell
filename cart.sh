echo -e '\e[33mDownloading Nodejs\e[30m'
curl -sL https://rpm.nodesource.com/setup_lts.x | bash  &>> /tmp/roboshop.log
echo -e '\e[33mInstalling Nodejs\e[30m'
yum install nodejs -y &>> /tmp/roboshop.log
useradd roboshop
mkdir /app
echo -e '\e[33mAdding and unzipping new app content\e[30m'
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip &>>/tmp/roboshop.log
cd /app
unzip /tmp/cart.zip &>>/tmp/roboshop.log
cd /app
echo -e '\e[33mInstalling dependencies\e[30m'
npm install
echo -e '\e[33mcreating service file\e[30m'
cp cart.service /etc/systemd/system/cart.service &>>/tmp/roboshop.log
systemctl daemon-reload
echo -e '\e[33mEnabling and restarting nodejs\e[30m'
systemctl enable cart &>>/tmp/roboshop.log
systemctl restart cart &>>/tmp/roboshop.log