#!/bin/bash

ENDPOINT_HEALTH=$(curl -s http://127.0.0.1:8080/health)
LOG_FILE=/var/log/http-server-deploy.log

if (id web-user) ; then
  echo "Пользователь найден" | tee -a $LOG_FILE
else
  echo "Пользователь не найден" | tee -a $LOG_FILE 
  sudo adduser web-user
fi

echo

if [ -d "/data/http_app/" ]; then
  echo "Дирeктория существует" 
  echo "$(tree /data)" | tee -a $LOG_FILE
else
  echo "Директории не существует"
  echo "Директория будет создана"
  sudo  mkdir -p /data/http_app 
  echo "$(tree /data)" | tee -a $LOG_FILE
fi


echo "$ENDPOINT_HEALTH" | tee -a $LOG_FILE
