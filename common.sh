color="\e[36m"
nocolor="\e[0m"
logfile="/tmp/roboshop.log"
app_path="/app"

status(){
  if [ $1 -eq 0 ];then
    echo SUCCESS
  else
    echo Failure
  fi
}