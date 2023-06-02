color="\e[36m"
nocolor="\e[0m"
logfile="/tmp/roboshop.log"
app_path="/app"

status(){
  if [ $1 -eq 0 ];then
    echo SUCCESS
  else
    echo Failure
  fi
}

service_start(){
  echo -e "${color}Enabling and restarting ${component} Server${nocolor}"
  systemctl enable ${component} &>>${logfile}
  status $?
  systemctl restart ${component}
}

nodejs(){
  echo -e "${color}Installing Nodejs Server${nocolor}"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${logfile}
  yum install nodejs -y &>>${logfile}
  status $?
  echo -e "${color}Adding User${nocolor}"
  useradd roboshop
  status $?
  echo -e "${color}Downloading new app Content${nocolor}"
  mkdir ${app_path}
  cd ${app_path}
  curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${logfile}
  status $?
  echo -e "${color}Extracting the app Content${nocolor}"
  unzip /tmp/${component}.zip &>>${logfile}
  status $?
  echo -e "${color}Installing Dependencies${nocolor}"
  cd ${app_path}
  npm install
   status $?
  echo -e "${color}Copying Service File and starting the service${nocolor}"
  cp /home/centos/roboshop-shell/${component}.service  /etc/systemd/system/${component}.service &>>${logfile}
  systemctl daemon-reload &>>${logfile}
   status $?
  service_start
}

mongo_schema(){
  echo -e "${color}Copying mongo repo${nocolor}"
  cp /home/centos/roboshop-shell/mongo.repo  /etc/yum.repos.d/mongo.repo &>>${logfile}
  status $?
  echo -e "${color}Installing mongo schema${nocolor}"
  yum install mongodb-org-shell -y &>>${logfile}
  mongo --host mongodb-dev.rkdevops.store </app/schema/${component}.js &>>${logfile}
  status $?
}