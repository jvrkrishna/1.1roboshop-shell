source common.sh

echo -e "\e[31mInstalling Nginx Server\e[0m"
yum install nginx -y &>>/tmp/roboshop.log
echo -e "\e[31mRemoving old content\e[0m"
rm -rf /usr/share/nginx/html/* &>>/tmp/roboshop.log
echo -e "\e[31mDownloading new app content\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>/tmp/roboshop.log
cd /usr/share/nginx/html &>>/tmp/roboshop.log
unzip /tmp/frontend.zip &>>/tmp/roboshop.log
echo -e "\e[31mConfiguring Reverse proxy seerver\e[0m"
cp roboshop.conf /etc/nginx/default.d/roboshop.conf &>>/tmp/roboshop.log
echo -e "\e[31mInstalling Nginx Server\e[0m"
systemctl enable nginx &>>/tmp/roboshop.log
systemctl restart nginx