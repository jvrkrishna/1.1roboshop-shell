source common.sh
component=user

nodejs

echo -e "${color}Downloading mongodb${nocolor}"
cp /home/centos/roboshop-shell/Mongo.repo /etc/yum.repos.d/mogo.repo &>>${logfile}
echo -e "${color}Installing mongodb${nocolor}"
yum install mongodb-org -y &>>${logfile}
echo -e "${color}Loading schema${nocolor}"
mongo --host mongodb-dev.rkdevops.store <${app_path}/schema/${component}.js &>>${logfile}




