#!/bin/bash
#
# Name: poker.sh - Ausgabe der Groesse aller Verzeichnissen und Dateien.
# -----------------
# SYNOPSIS: poker.sh [OPTION]
# Description: Ausgabe der Groesse aller Verzeichnissen und Dateien.
#
# Autoren: R. Stalder and T. Kaspar
# Version: 1.0.0
# Datum: 14.9.2021
#
#

generate_group_cards() {
  used_card_indexes[3]='bar'
}
is_random_number_in_used_card_indexes() {
  echo "robbery"
  for i in "${used_card_indexes[@]}"
do
  if [ i == random_nummber ]; then
      return 1
  fi
done
return 0
}

generate_player_cards() {
  random_number= jot -r 1 1 81
  echo ${random_number}
  while is_random_number_in_used_card_indexes -eq 1
   do

    echo $(is_random_number_in_used_card_indexes)
  random_number= jot -r 1 1 81
  done
  echo "random_number: ${random_number}"
}



cards=(Ah Kh Qh Jh 10h 9h 8h 7h 6h 5h 4h 3h 2h As Ks Qs Js 10s 9s 8s 7s 6s 5s 4s 3s 2s Ad Kd Qd Jd 10d 9d 8d 7d 6d 5d 4d 3d 2d Ac Kc Qc Jc 10c 9c 8c 7c 6c 5c 4c 3c 2c)
declare -a used_card_indexes

declare -a hand_player_1
declare -a hand_player_2
declare -a hand_player_3
declare -a hand_player_4
generate_player_cards


used_card_indexes[0]='foo'
used_card_indexes[1]='bar'


for i in "${cards[@]}"
do
  echo "$i";
done

echo ${players_hands[0][0]}

generate_group_cards


exit