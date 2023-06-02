source common.sh

echo -e "${color}Installing Nginx Server${nocolor}"
cp mongo.repo /etc/yum.repos.d/mongo.repo &>>${logfile}
status $?
echo -e "${color}Installing Nginx Server${nocolor}"
yum install mongodb-org -y &>>${logfile}
status $?
echo -e "${color}Installing Nginx Server${nocolor}"
sed 's/127.0.0.1/0.0.0.0' /etc/mongod.conf &>>${logfile}
status $?
echo -e "${color}Installing Nginx Server${nocolor}"
systemctl enable mongod &>>${logfile}
status $?
systemctl start mongod