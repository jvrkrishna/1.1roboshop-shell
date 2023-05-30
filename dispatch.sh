echo -e "\e[33mInstalling golang\e[0m"
yum install golang -y &>>/tmp/roboshop.log
echo -e "\e[33mAdding user\e[0m"
useradd roboshop
mkdir /app
echo -e "\e[33mCopying new app content\e[0m"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip &>>/tmp/roboshop.log
cd /app
echo -e "\e[33mUnzipping the content\e[0m"
unzip /tmp/dispatch.zip &>>/tmp/roboshop.log
cd /app
echo -e "\e[33mInstalling dependencies\e[0m"
go mod init dispatch &>>/tmp/roboshop.log
go get
go build
echo -e "\e[33mCopying Service filee\e[0m"
cp /home/centos/roboshop-shell/dispatch.service /etc/systemd/system/dispatch.service &>>/tmp/roboshop.log
echo -e "\e[33mEnabling and restarting the dispatch service\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable dispatch  &>>/tmp/roboshop.log
systemctl restart dispatch &>>/tmp/roboshop.log