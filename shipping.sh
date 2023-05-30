echo -e "\e[33mInstalling Maven\e[0m"
yum install maven -y &>> /tmp/roboshop.log
echo -e "\e[33mAdding User\e[0m"
useradd roboshop
echo -e "\e[33mCreating app directory\e[0m"
mkdir /app
echo -e "\e[33mDownloading new app content\e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip &>> /tmp/roboshop.log
cd /app
echo -e "\e[33mUnzipping new app content\e[0m"
unzip /tmp/shipping.zip &>> /tmp/roboshop.log
cd /app
echo -e "\e[33mCleaning packages\e[0m"
mvn clean package
mv target/shipping-1.0.jar shipping.jar &>> /tmp/roboshop.log
echo -e "\e[33mCreating service file\e[0m"
cp /home/centos/roboshop-shell/shipping.service /etc/systemd/system/shipping.service &>> /tmp/roboshop.log
systemctl daemon-reload
echo -e "\e[33mEnabling and restaring the service\e[0m"
systemctl enable shipping &>> /tmp/roboshop.log
systemctl start shipping
echo -e "\e[33mInstalling mysql\e[0m"
yum install mysql -y &>> /tmp/roboshop.log
mysql -h mysql-dev.rkdevops.store -uroot -pRoboShop@1 < /app/schema/shipping.sql &>> /tmp/roboshop.log
echo -e "\e[33mrestaring the shippping service\e[0m"
systemctl restart shipping &>> /tmp/roboshop.log