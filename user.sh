source common.sh
component=user

echo -e '${color}Downloading Nodejs${nocolor}'
curl -sL https://rpm.nodesource.com/setup_18.x | sudo -E bash - &>>${logfile}
echo -e '${color}Installing Nodejs${nocolor}'
yum install nodejs -y &>>${logfile}
echo -e '${color}Creating oneuser${nocolor}'
${component}add roboshop
mkdir ${app_path}
cd ${app_path}
echo -e '${color}Downloading and unzipping the new app content${nocolor}'
curl -L -o ${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${logfile}
unzip ${component}.zip &>>${logfile}
echo -e '${color}Installing dependencies${nocolor}'
npm install &>>${logfile}
echo -e '${color}Creating service file${nocolor}'
cp /home/centos/roboshop-shell/${component}.service /etc/systemd/system/${component}.service &>>${logfile}
systemctl daemon-reload &>>${logfile}
echo -e '${color}Downloading mongodb${nocolor}'
cp /home/centos/roboshop-shell/Mongo.repo /etc/yum.repos.d/mogo.repo &>>${logfile}
echo -e '${color}Installing mongodb${nocolor}'
yum install mongodb-org -y &>>${logfile}
echo -e '${color}Loading schema${nocolor}'
mongo --host mongodb-dev.rkdevops.store <${app_path}/schema/${component}.js &>>${logfile}
echo -e '${color}Enabling and restarting server${nocolor}'
systemctl enable ${component} &>>${logfile}
systemctl restart ${component} &>>${logfile}



