echo -e "\e[33mInstalling Nginx Server\e[0m"
yum install nginx -y
echo -e "\e[33mRemoving old app content\e[0m"
rm -rf /usr/share/nginx/html/*
echo -e "\e[33mDownloading new app content\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
cd /usr/share/nginx/html
echo -e "\e[33mUnzipping the new app content\e[0m"
unzip /tmp/frontend.zip
#we have to configure roboshop.conf file
echo -e "\e[33mEnabling and restarting nginx server\e[0m"
systemctl enable nginx
systemctl restart nginx
echo -e "\e[33mSuccessfully started\e[0m"