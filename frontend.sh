source common.sh

echo -e "${color}Installing Nginx Server${nocolor}"
yum install nginx -y &>>${logfile}
status $?
echo -e "${color}Removing old content${nocolor}"
rm -rf /usr/share/nginx/html/* &>>${logfile}
status $?
echo -e "${color}Downloading new app content${nocolor}"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${logfile}
cd /usr/share/nginx/html &>>${logfile}
unzip /tmp/frontend.zip &>>${logfile}
status $?
echo -e "${color}Configuring Reverse proxy seerver${nocolor}"
cp /home/centos/roboshop-shell/roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${logfile}
status $?
echo -e "${color}Enabling and restarting Nginx Server${nocolor}"
systemctl enable nginx &>>${logfile}
systemctl start nginx
status $?