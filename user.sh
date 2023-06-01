source common.sh
component=user

echo -e '${color}Downloading Nodejs${nocolor}'
curl -sL https://rpm.nodesource.com/setup_18.x | sudo -E bash - &>>${logfile}
echo -e '${color}Installing Nodejs${nocolor}'
yum install nodejs -y &>>${logfile}
echo -e '${color}Creating user${nocolor}'
useradd roboshop
mkdir ${app_path}
cd ${app_path}
echo -e '${color}Downloading and unzipping the new app content${nocolor}'
curl -L -o user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip &>>${logfile}
unzip user.zip &>>${logfile}
echo -e '${color}Installing dependencies${nocolor}'
npm install &>>${logfile}
echo -e '${color}Creating service file${nocolor}'
cp /home/centos/roboshop-shell/user.service /etc/systemd/system/user.service &>>${logfile}
systemctl daemon-reload &>>${logfile}
echo -e '${color}Downloading mongodb${nocolor}'
cp /home/centos/roboshop-shell/Mongo.repo /etc/yum.repos.d/mogo.repo &>>${logfile}
echo -e '${color}Installing mongodb${nocolor}'
yum install mongodb-org -y &>>${logfile}
echo -e '${color}Loading schema${nocolor}'
mongo --host mongodb-dev.rkdevops.store <${app_path}/schema/user.js &>>${logfile}
echo -e '${color}Enabling and restarting server${nocolor}'
systemctl enable user &>>${logfile}
systemctl restart user &>>${logfile}



