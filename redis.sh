component=redis
source common.sh

echo -e "${color}Creating ${component} repo${nocolor}"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>${logfile}
status $?
yum module enable ${component}:remi-6.2 -y &>>${logfile}
echo -e "${color}Installing ${component} Server${nocolor}"
yum install ${component} -y &>>${logfile}
status $?
echo -e "${color}Editing localhost file${nocolor}"
sed -i 's/127.0.0.1/0.0.0.0/' /etc/${component}.conf &>>${logfile}
status $?
sed -i 's/127.0.0.1/0.0.0.0/' /etc/${component}/${component}.conf &>>${logfile}
status $?
service_start