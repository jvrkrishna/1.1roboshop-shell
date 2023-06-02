component=shipping
source common.sh

echo -e "${color}Installing ${component} server${nocolor}"
yum install maven -y
status $?

app_presetup

echo -e "${color}Cleaning ${component} package${nocolor}"
cd /app
mvn clean package
mv target/${component}-1.0.jar ${component}.jar
status $?
echo -e "${color}copying ${component} service${nocolor}"
cp /home/centos/roboshop-shell/${component}.service /etc/systemd/system/${component}.service
systemctl daemon-reload
status $?
echo -e "${color}Installing mysql${nocolor}"
yum install mysql -
status $?
echo -e "${color}Setting mysql schema${nocolor}"
mysql -h mysql-dev.rkdevops.store -uroot -pRoboShop@1 < /app/schema/${component}.sql
status $?

service_start