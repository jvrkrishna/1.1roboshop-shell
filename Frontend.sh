echo -e "\e[33mInstalling Nginx Server\e[0m"
yum install nginx -y &>>/tmp/roboshop.log
echo -e "\e[33mRemoving old app content\e[0m"
rm -rf /usr/share/nginx/html/* &>>/tmp/roboshop.log
echo -e "\e[33mDownloading new app content\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>/tmp/roboshop.log
cd /usr/share/nginx/html
echo -e "\e[33mUnzipping the new app content\e[0m"
unzip /tmp/frontend.zip &>>/tmp/roboshop.log
echo -e "\e[33mMaking roboshop.conf\e[0m"
cp roboshop.conf  /etc/nginx/default.d/roboshop.conf
echo -e "\e[33mEnabling and restarting nginx server\e[0m"
systemctl enable nginx &>>/tmp/roboshop.log
systemctl restart nginx &>>/tmp/roboshop.log
echo -e "\e[33mSuccessfully started\e[0m"