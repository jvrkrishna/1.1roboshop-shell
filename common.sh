color="\e[35m"
nocolor="\e[0m"
logfile="/tmp/roboshop.log"
app_path="/app"

nodejs() {
  echo -e "${color}Configuring Nodejs Server${nocolor}"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash  &>> ${logfile}
  echo -e "${color}Installing  Nodejs Server${nocolor}"
  yum install nodejs -y &>> ${logfile}
  echo -e "${color}Adding user${nocolor}"
  useradd roboshop
  echo -e "${color}Make directory${nocolor}"
  mkdir ${app_path} &>> ${logfile}
  echo -e "${color}Changing code Server${nocolor}"
  curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip &>> ${logfile}
  echo -e "${color}Unzipping code${nocolor}"
  cd ${app_path}
  unzip /tmp/$component.zip &>> ${logfile}
  cd ${app_path}
  echo -e "${color}Installing Dependencies${nocolor}"
  npm install &>> ${logfile}
  echo -e "${color}Configuring Service file${nocolor}"
  cp /home/centos/roboshop-shell/$component.service /etc/systemd/system/$component.service &>> ${logfile}
  systemctl daemon-reload
  echo -e "${color}Enabling and restarting Server${nocolor}"
  systemctl enable $component &>> ${logfile}
  systemctl restart $component
}

mongo_schema_setup(){
echo -e "${color}Downloading mongodb${nocolor}"
cp /home/centos/roboshop-shell/Mongo.repo /etc/yum.repos.d/mogo.repo &>>${logfile}
echo -e "${color}Installing mongodb${nocolor}"
yum install mongodb-org -y &>>${logfile}
echo -e "${color}Loading schema${nocolor}"
mongo --host mongodb-dev.rkdevops.store <${app_path}/schema/${component}.js &>>${logfile}
}

maven() {
  echo -e "${color}Installing Maven${nocolor}"
  yum install maven -y &>> ${logfile}
  echo -e "${color}Adding User${nocolor}"
  useradd roboshop
  echo -e "${color}Creating app directory${nocolor}"
  mkdir ${app_path}
  echo -e "${color}Downloading new app content${nocolor}"
  curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>> ${logfile}
  cd ${app_path}
  echo -e "${color}Unzipping new app content${nocolor}"
  unzip /tmp/${component}.zip &>> ${logfile}
  cd ${app_path}
  echo -e "${color}Cleaning packages${nocolor}"
  mvn clean package &>> ${logfile}
  mv target/${component}-1.0.jar ${component}.jar &>> ${logfile}
  echo -e "${color}Creating service file${nocolor}"
  cp /home/centos/roboshop-shell/${component}.service /etc/systemd/system/${component}.service &>> ${logfile}
  systemctl daemon-reload
  echo -e "${color}Enabling and restaring the service${nocolor}"
  systemctl enable ${component} &>> ${logfile}
  systemctl start ${component}
  echo -e "${color}Installing mysql${nocolor}"
  yum install mysql -y &>> ${logfile}
  mysql -h mysql-dev.rkdevops.store -uroot -pRoboShop@1 < ${app_path}/schema/${component}.sql &>> ${logfile}
  echo -e "${color}restaring the shippping service${nocolor}"
  systemctl restart ${component} &>> ${logfile}
}