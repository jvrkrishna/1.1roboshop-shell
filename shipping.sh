echo -e "\e[33mInstalling maven\e[0m"
yum install maven -y &>>/tmp/roboshop.log
echo -e "\e[33mCreating user\e[0m"
useradd roboshop
echo -e "\e[33mCopying New app content\e[0m"
mkdir /app
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip
cd /app
unzip /tmp/shipping.zip
cd /app
echo -e "\e[33mcleaning maven package\e[0m"
mvn clean package
mv target/shipping-1.0.jar shipping.jar
echo -e "\e[33mCopying service file\e[0m"
cp Shipping.Service /etc/systemd/system/shipping.service
systemctl daemon-reload
echo -e "\e[33mEnabling and restating the service\e[0m"
systemctl enable shipping
systemctl restart shipping
echo -e "\e[33mLoading mysql schema\e[0m"
yum install mysql -y
mysql -h mysql-dev.rkdevops.store -uroot -pRoboShop@1 < /app/schema/shipping.sql
systemctl restart shipping