curl -sL https://rpm.nodesource.com/setup_lts.x | bash
yum install nodejs -y
useradd roboshop
mkdir /app
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app
unzip /tmp/catalogue.zip
cd /app
npm install
cp catalogue.service /etc/systemd/system/catalogue.service
systemctl daemon-reload
cp Mongo.repo /etc/yum.repos.d/mongodb.repo
yum install mongodb-org-shell -y
mongo --host mongodb-dev.rkdevops.store </app/schema/catalogue.js
systemctl enable catalogue
systemctl restart catalogue