echo -e "\e[33mInstalling python\e[0m"
yum install python36 gcc python3-devel -y &>> /tmp/roboshop.log
useradd roboshop
mkdir /app
echo -e "\e[33mAdding new app content\e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip &>> /tmp/roboshop.log
cd /app
echo -e "\e[33mUnzip the new app content\e[0m"
unzip /tmp/payment.zip &>> /tmp/roboshop.log
cd /app
echo -e "\e[33mInstalling dependencies\e[0m"
pip3.6 install -r requirements.txt &>> /tmp/roboshop.log
echo -e "\e[33mconfiguring service file\e[0m"
cp /home/centos/roboshop-shell/payment.service /etc/systemd/system/payment.service &>> /tmp/roboshop.log
systemctl daemon-reload &>> /tmp/roboshop.log
echo -e "\e[33mEnabling and restarting the payment service\e[0m"
systemctl enable payment
systemctl restart payment