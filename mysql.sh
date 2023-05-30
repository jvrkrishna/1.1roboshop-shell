echo -e "\e[33mConfiguring mysql repo\e[0m"
yum module disable mysql -y
cp mysql.repo /etc/yum.repos.d/mysql.repo
echo -e "\e[33mInstalling mysql server\e[0m"
yum install mysql-community-server -y &>> /tmp/roboshop.log
echo -e "\e[33mEnabling restarting mysql server\e[0m"
systemctl enable mysqld  &>> /tmp/roboshop.log
systemctl restart mysqld  &>> /tmp/roboshop.log
echo -e "\e[33mSecuring mysql installation\e[0m"
mysql_secure_installation --set-root-pass RoboShop@1  &>> /tmp/roboshop.log
echo -e "\e[33mconnecting to mysql server\e[0m"
mysql -uroot -pRoboShop@1  &>> /tmp/roboshop.log
