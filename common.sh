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

app_presetup(){
  echo -e "${color}Adding User${nocolor}"
    id roboshop &>>${logfile}
    if [ $? -ne 0 ]; then
      useradd roboshop &>>${logfile}
    fi
    status $?
    echo -e "${color}Downloading new app Content${nocolor}"
    mkdir ${app_path} &>>${logfile}
    cd ${app_path}
    curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${logfile}
    status $?
    echo -e "${color}Extracting the app Content${nocolor}"
    unzip /tmp/${component}.zip &>>${logfile}
    status $?
}

nodejs(){
  echo -e "${color}Installing Nodejs Server${nocolor}"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${logfile}
  yum install nodejs -y &>>${logfile}
  status $?
  app_presetup
  echo -e "${color}Installing Dependencies${nocolor}"
  cd ${app_path}
  npm install &>>${logfile}
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
  yum install mongodb-org -y &>>${logfile}
  mongo --host mongodb-dev.rkdevops.store </app/schema/${component}.js &>>${logfile}
  status $?
}

maven(){
  echo -e "${color}Installing ${component} server${nocolor}"
  yum install maven -y &>>${logfile}
  status $?
  app_presetup
  echo -e "${color}Cleaning ${component} package${nocolor}"
  cd /app
  mvn clean package &>>${logfile}
  mv target/${component}-1.0.jar ${component}.jar &>>${logfile}
  status $?
  echo -e "${color}copying ${component} service${nocolor}"
  cp /home/centos/roboshop-shell/${component}.service /etc/systemd/system/${component}.service &>>${logfile}
  systemctl daemon-reload &>>${logfile}
  status $?
  echo -e "${color}Installing mysql${nocolor}"
  yum install mysql -y &>>${logfile}
  status $?
  echo -e "${color}Setting mysql schema${nocolor}"
  mysql -h mysql-dev.rkdevops.store -uroot -pRoboShop@1 < /app/schema/${component}.sql &>>${logfile}
  status $?
  service_start
}

python(){
  echo -e "${color}Installing Python Server${nocolor}"
  yum install python36 gcc python3-devel -y &>>${logfile}
  status $?
  app_presetup
  echo -e "${color}Installing Dependencies${nocolor}"
  cd /app
  pip3.6 install -r requirements.txt &>>${logfile}
  status $?
  echo -e "${color}Copying service file${nocolor}"
  cp /home/centos/roboshop-shell/${component}.service  /etc/systemd/system/${component}.service &>>${logfile}
  systemctl daemon-reload &>>${logfile}
  status $?
  service_start
}

dispatch(){
  echo -e "${color}Installing golang Server${nocolor}"
  yum install golang -y &>>${logfile}
  status $?
  app_presetup
  echo -e "${color}Installing Dependencies${nocolor}"
  cd /app
  go mod init ${component} &>>${logfile}
  go get &>>${logfile}
  go build &>>${logfile}
  echo -e "${color}creating service file${nocolor}"
  cp /home/centos/roboshop-shell/${component}.service  /etc/systemd/system/${component}.service &>>${logfile}
  systemctl daemon-reload &>>${logfile}
  status $?
  service_start
}