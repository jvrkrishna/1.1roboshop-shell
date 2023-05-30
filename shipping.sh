echo -e "\e[33mInstalling maven\e[0m"
yum install maven -y &>>/tmp/roboshop.log
echo -e "\e[33mCreating user\e[0m"
useradd roboshop
echo -e "\e[33mCopying New app content\e[0m"
mkdir /app
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip &>>/tmp/roboshop.log
cd /app
unzip /tmp/shipping.zip
cd /app
echo -e "\e[33mcleaning maven package\e[0m"
mvn clean package &>>/tmp/roboshop.log
mv target/shipping-1.0.jar shipping.jar &>>/tmp/roboshop.log
echo -e "\e[33mCopying service file\e[0m"
cp shipping.service /etc/systemd/system/shipping.service &>>/tmp/roboshop.log
systemctl daemon-reload &>>/tmp/roboshop.log
echo -e "\e[33mEnabling and restating the service\e[0m"
systemctl enable shipping &>>/tmp/roboshop.log
systemctl restart shipping
echo -e "\e[33mLoading mysql schema\e[0m"
yum install mysql -y &>>/tmp/roboshop.log
mysql -h mysql-dev.rkdevops.store -uroot -pRoboShop@1 < /app/schema/shipping.sql &>>/tmp/roboshop.log
systemctl restart shipping