echo -e "\e[33mInstalling Redis server\e[0m"
yum install redis -y
echo -e "\e[33mModifying conf file\e[0m"
sed -i's/127.0.0.1/0.0.0.0/'  /etc/redis.conf
echo -e "\e[33mEnabling and restarting redis server\e[0m"
systemctl enable redis
systemcl restart redis
