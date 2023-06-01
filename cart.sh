source common.sh
component=cart

echo -e "${color}Downloading Nodejs${nocolor}"
curl -sL https://rpm.nodesource.com/setup_18.x | sudo -E bash - &>>${logfile}
echo -e "${color}Installing Nodejs${nocolor}"
yum install nodejs -y &>>${logfile}
echo -e "${color}Creating user${nocolor}"
useradd roboshop
mkdir ${app_path}
cd ${app_path}
echo -e "${color}Downloading and unzipping the new app content${nocolor}"
curl -L -o ${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${logfile}
unzip ${component}.zip &>>${logfile}
echo -e "${color}Installing dependencies${nocolor}"
npm install &>>${logfile}
echo -e "${color}Creating service file${nocolor}"
cp /home/centos/roboshop-shell/${component}.service /etc/systemd/system/${component}.service &>>${logfile}
systemctl daemon-reload &>>${logfile}
echo -e "${color}Enabling and restarting server${nocolor}"
systemctl enable ${component} &>>${logfile}
systemctl restart ${component} &>>${logfile}



