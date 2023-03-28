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
  
  read SELECTED_ID
  if [[ $SELECTED_ID =~ ^[0-9]+$ ]] && [[ $SELECTED_ID -le 5 ]];
  then
  SERVICE=$($PSQL "select name from services where service_id=$SELECTED_ID;")

    #get phone number
    echo -e "\nWhat's your phone number?"
    read PHONE
    CUSTOMER_ID=$($PSQL "select customer_id from customers where phone='$PHONE';")
      #if not found
      if [[ -z $CUSTOMER_ID ]]
      then

        #get customer info
        echo -e "\nI don't have a record for that phone number, what's your name?"
        read NAME
        NAME_INSERT=$($PSQL "insert into customers(name,phone) values('$NAME','$PHONE');")
        CUSTOMER_ID=$($PSQL "select customer_id from customers where phone='$PHONE';")
      
      else
        echo -e "\nWhat time would you like your $(echo $SERVICE  | sed -r 's/^ *| *$//g'), $(echo $NAME | sed -r 's/^ *| *$//g')?"
        read TIME
          TIME_INSERT=$($PSQL "insert into appointments(customer_id, service_id, time) values('$CUSTOMER_ID','$SELECTED_ID','$TIME');")
        echo -e "\nI have put you down for a $(echo $SERVICE  | sed -r 's/^ *| *$//g') at $(echo $TIME | sed -r 's/^ *| *$//g'), $(echo $NAME | sed -r 's/^ *| *$//g')."
      fi
  else
  MAIN_MENU "I could not find that service. What would you like today?"
fi
}

MAIN_MENU