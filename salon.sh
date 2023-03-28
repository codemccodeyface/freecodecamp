#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e '\nWelcome to My Salon, how can I help you?\n'


MAIN_MENU() {
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi

  SERVICE_LIST=$($PSQL "SELECT service_id, name FROM services")
  
  echo "$SERVICE_LIST" | while read SERVICE_ID BAR SERVICE_NAME
  do
    echo "$SERVICE_ID) $SERVICE_NAME"
  done
  
  read SERVICE_ID_SELECTED
  if [[ $SERVICE_ID_SELECTED =~ ^[0-9]+$ ]] && [[ $SERVICE_ID_SELECTED -le 5 ]] && [[ $SERVICE_ID_SELECTED -gt 0 ]];
  then
  SERVICE=$($PSQL "select name from services where service_id=$SERVICE_ID_SELECTED;")

    #get phone number
    echo -e "\nWhat's your phone number?"
    read CUSTOMER_PHONE
    CUSTOMER_ID=$($PSQL "select customer_id from customers where phone='$CUSTOMER_PHONE';")
      #if not found
      if [[ -z $CUSTOMER_ID ]]
      then

        #get customer info
        echo -e "\nI don't have a record for that phone number, what's your name?"
        read CUSTOMER_NAME
        NAME_INSERT=$($PSQL "insert into customers(name,phone) values('$CUSTOMER_NAME','$CUSTOMER_PHONE');")
        CUSTOMER_ID=$($PSQL "select customer_id from customers where phone='$CUSTOMER_PHONE';")
        echo -e "\nWhat time would you like your $(echo $SERVICE  | sed -r 's/^ *| *$//g'), $(echo $CUSTOMER_NAME | sed -r 's/^ *| *$//g')?"
        read SERVICE_TIME
          TIME_INSERT=$($PSQL "insert into appointments(customer_id, service_id, time) values('$CUSTOMER_ID','$SERVICE_ID_SELECTED','$SERVICE_TIME');")
        echo -e "\nI have put you down for a $(echo $SERVICE  | sed -r 's/^ *| *$//g') at $(echo $SERVICE_TIME | sed -r 's/^ *| *$//g'), $(echo $CUSTOMER_NAME | sed -r 's/^ *| *$//g')."
      else
        echo -e "\nWhat time would you like your $(echo $SERVICE  | sed -r 's/^ *| *$//g'), $(echo $CUSTOMER_NAME | sed -r 's/^ *| *$//g')?"
        read SERVICE_TIME
          TIME_INSERT=$($PSQL "insert into appointments(customer_id, service_id, time) values('$CUSTOMER_ID','$SERVICE_ID_SELECTED','$SERVICE_TIME');")
        echo -e "\nI have put you down for a $(echo $SERVICE  | sed -r 's/^ *| *$//g') at $(echo $SERVICE_TIME | sed -r 's/^ *| *$//g'), $(echo $CUSTOMER_NAME | sed -r 's/^ *| *$//g')."
      fi
  else
  MAIN_MENU "I could not find that service. What would you like today?"
fi
}

MAIN_MENU
