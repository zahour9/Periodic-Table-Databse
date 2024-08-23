#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
if [[ -z $1 ]]
then 
  echo Please provide an element as an argument.
fi
if [[ $1 =~ ^[0-9]+$ ]]
then
SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$1")
if [[ -z $SYMBOL ]] 
then
echo I could not find that element in the database.
else 
NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$1")
TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number=$1")
TYPE=$($PSQL "SELECT type FROM types WHERE type_id=$TYPE_ID")
MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$1")
MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$1")
BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$1")
echo -e "The element with atomic number $1 is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
fi
fi
if [[ $1 =~ ^[a-zA-Z]{1,2}$ ]] 
then 
NAME=$($PSQL "SELECT name FROM elements WHERE symbol='$1'")
if [[ -z $NAME ]] 
then
echo I could not find that element in the database.
else 
ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$1'")
TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
TYPE=$($PSQL "SELECT type FROM types WHERE type_id=$TYPE_ID")
MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
echo -e "The element with atomic number $ATOMIC_NUMBER is $NAME ($1). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
fi
fi
if [[ $1 =~ ^[a-zA-Z]{3,}$ ]]
then
SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE name='$1'")
if [[ -z $SYMBOL ]] 
then
echo I could not find that element in the database.
else 
ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name='$1'")
TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
TYPE=$($PSQL "SELECT type FROM types WHERE type_id=$TYPE_ID")
MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
echo -e "The element with atomic number $ATOMIC_NUMBER is $1 ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $1 has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
fi
fi