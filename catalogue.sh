source common.sh
component=catalogue

nodejs
echo -e "${color}Installing repo file${nocolor}"
cp /home/centos/roboshop-shell/Mongo.repo /etc/yum.repos.d/mongodb.repo &>> ${logfile}
yum install mongodb-org-shell -y &>> ${logfile}
echo -e "${color}Configuring host${nocolor}"
mongo --host mongodb-dev.rkdevops.store <${app_path}/schema/$component.js &>> ${logfile}
