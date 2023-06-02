source common.sh
echo -e "${color}Installing Nginx Server${nocolor}"
yum install nginx -y &>>${logfile}
if [ $1 -eq 0 ];then
  echo SUCCESS
else
  echo Failure
fi
echo -e "${color}Removing old content${nocolor}"
rm -rf /usr/share/nginx/html/* &>>${logfile}
echo -e "${color}Downloading new app content${nocolor}"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${logfile}
cd /usr/share/nginx/html &>>${logfile}
unzip /tmp/frontend.zip &>>${logfile}
echo -e "${color}Configuring Reverse proxy seerver${nocolor}"
cp roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${logfile}
echo -e "${color}Installing Nginx Server${nocolor}"
systemctl enable nginx &>>${logfile}
systemctl restart nginx