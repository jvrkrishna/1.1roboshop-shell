component=rabbitmq-server
source common.sh

echo -e "${color}Creating ${component} repo${nocolor}"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>>${logfile}
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash &>>${logfile}
status $?
echo -e "${color}Installing ${component} Server${nocolor}"
yum install ${component} -y &>>${logfile}
status $?
service_start
echo -e "${color}Adding ${component} Application user${nocolor}"
rabbitmqctl add_user roboshop roboshop123 &>>${logfile}
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>${logfile}

