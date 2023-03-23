#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
echo $($PSQL "truncate games,teams;") 
cat games.csv | while IFS="," read year round winner opponent winner_goals opponent_goals
do
if [[ $year != "year" ]]
  then
  #add team
    #find winner team_name
    team_name=$($PSQL "select name from teams where name='$winner';")
    #if no team_name
    if [[ -z $team_name ]]
      then
      #add team
      insert_team=$($PSQL "insert into teams(name) values('$winner');")
      #check team insert
      if [[ $insert_team == "INSERT 0 1" ]]
        then
        echo inserted $winner
      fi
    fi
    #find opponent team_name
    team_name=$($PSQL "select name from teams where name='$opponent';")
    #if no team_name
    if [[ -z $team_name ]] && [[ $team_name != $winner ]]
      then
      #add team
      insert_team=$($PSQL "insert into teams(name) values('$opponent');")
      #check team insert
      if [[ $insert_team == "INSERT 0 1" ]]
        then
        echo inserted $winner
      fi
    fi
    team_name=$($PSQL "select name from teams where name='$winner' or name='$opponent';")
  #add game
    winner_id=$($PSQL "select team_id from teams where name ='$winner';")
    opponent_id=$($PSQL "select team_id from teams where name ='$opponent';")
    #find game_id
    game_id=$($PSQL "select game_id from games where year='$year' and winner_id='$winner_id' and opponent_id='$opponent_id';")
    #if no game_id
    if [[ -z $game_id ]]
      then
      insert_game=$($PSQL "insert into games(year,winner_id,opponent_id,winner_goals,opponent_goals,round) 
      values(
        '$year',
        '$winner_id',
        '$opponent_id',
        '$winner_goals',
        '$opponent_goals',
        '$round');")
    #check game insert
      if [[ $insert_game == "INSERT 0 1" ]]
        then
        echo inserted $year $winner_id $opponent_id $winner_goals $opponent_goals $round
      fi
    fi
    game_id=$($PSQL "select game_id from games where year='$year' and winner_id='$winner_id' and opponent_id='$opponent_id';")
fi
done