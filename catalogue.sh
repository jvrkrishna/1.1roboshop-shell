component=catalogue
color="\e[36m"
nocolor="\e[0m"

echo -e "${color}Configuring Nodejs Server${nocolor}"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash  &>> /tmp/roboshop.log
echo -e "${color}Installing  Nodejs Server${nocolor}"
yum install nodejs -y &>> /tmp/roboshop.log
echo -e "${color}Adding user${nocolor}"
useradd roboshop
echo -e "${color}Make directory${nocolor}"
mkdir /app &>> /tmp/roboshop.log
echo -e "${color}Changing code Server${nocolor}"
curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip &>> /tmp/roboshop.log
echo -e "${color}Unzipping code${nocolor}"
cd /app
unzip /tmp/$component.zip &>> /tmp/roboshop.log
cd /app
echo -e "${color}Installing Dependencies${nocolor}"
npm install &>> /tmp/roboshop.log
echo -e "${color}Configuring Service file${nocolor}"
cp /home/centos/roboshop-shell/$component.service /etc/systemd/system/$component.service &>> /tmp/roboshop.log
systemctl daemon-reload
echo -e "${color}Installing repo file${nocolor}"
cp /home/centos/roboshop-shell/Mongo.repo /etc/yum.repos.d/mongodb.repo &>> /tmp/roboshop.log
yum install mongodb-org-shell -y &>> /tmp/roboshop.log
echo -e "${color}Configuring host${nocolor}"
mongo --host mongodb-dev.rkdevops.store </app/schema/$component.js &>> /tmp/roboshop.log
echo -e "${color}Enabling and restarting Server${nocolor}"
systemctl enable $component &>> /tmp/roboshop.log
systemctl restart $component