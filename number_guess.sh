#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

echo -e "\nEnter your username:"
read URNAME

#get username
ID=$($PSQL "select user_id from userinfo where username = '$URNAME';")

#if not found 
if [[ -z $ID ]]
then
  $($PSQL "insert into userinfo(username) values('$URNAME');")
  echo -e "\n Welcome, $URNAME! It looks like this is your first time here."
  ID=$($PSQL "select user_id from userinfo where username = '$URNAME';")
else
  GAMES_PLAYED=$($PSQL "select games from userinfo where username = '$URNAME';")
  BEST_GAME=$($PSQL "select best_game from userinfo where username = '$URNAME';")
  echo -e "\nWelcome back, $URNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
fi

  #get random number
  RANDNUM=$((1 + $RANDOM % 1000))
    
  echo -e "\nGuess the secret number between 1 and 1000:"

  #start game
  read GUESS

  if [[  ! $GUESS =~ ^[0-9]+$ ]];
  then 
  echo "That is not an integer, guess again:"
  read GUESS
  fi

  let TRIES=1

    until [ $GUESS -eq $RANDNUM ]; do

      while [ $GUESS -gt $RANDNUM ]; do

      echo "It's lower than that, guess again:"

      read GUESS

      let TRIES++

      done

      while [ $GUESS -lt $RANDNUM ]; do

      echo "It's higher than that, guess again:"

      read GUESS

      let TRIES++

      done
    
    done
  $($PSQL "UPDATE userinfo SET games=$(($GAMES_PLAYED+1)) WHERE username='$URNAME';")
  $($PSQL "UPDATE userinfo SET best_game=$TRIES WHERE username='$URNAME' AND (best_game>$TRIES OR best_game ISNULL)")

echo "You guessed it in $TRIES tries. The secret number was $RANDNUM. Nice job!"