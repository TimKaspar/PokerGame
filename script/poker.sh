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
  for i in {0..4}; do
    generate_random_card
    hand_group_cards[i]="${cards[random_number]}"
    color_group_cards[i]="$((random_number / 13))"
    hight_group_cards[i]="$((random_number % 13))"
  done
}

is_random_number_in_used_card_indexes() {
  for i in "${used_card_indexes[@]}"; do
    if [ i == random_nummber ]; then
      is_number_in_use=true
      return 1
    fi
  done
  is_number_in_use=false
  return 0
}

generate_random_card() {

  random_number=$(jot -r 1 0 51)
  is_number_in_use=true

  is_random_number_in_used_card_indexes

  while $is_number_in_use; do
    random_number=$(jot -r 1 0 51)

    is_random_number_in_used_card_indexes

  done

}
player_1_has_multiple_hights() {

  ##TODO Funktioniert noch nicht
  pair=false
  for i in "${hights_collection_player_1[@]}"; do
    same_hight=0
    for j in "${hights_collection_player_1[@]}"; do
      if [ -$i -eq $j ]; then
          same_hight=$((same_hight + 1))
      fi
    done

  done
}

find_strongest_hand() {
  hights_collection_player_1=("${hight_player_1[@]}" "${hight_group_cards[@]}")
  player_1_has_multiple_hights

  return
}

generate_player_cards() {
  #Generete Player One
  for i in {0..1}; do
    generate_random_card
    hand_player_1[i]="${cards[random_number]}"
    color_player_1[i]="$((random_number / 13))"
    hight_player_1[i]="$((random_number % 13))"
  done

  #Generete Player Two
  for i in {0..1}; do
    generate_random_card
    hand_player_2[i]="${cards[random_number]}"
    color_player_2[i]="$((random_number / 13))"
    hight_player_2[i]="$((random_number % 13))"
  done
  #Generete Player Three
  for i in {0..1}; do
    generate_random_card
    hand_player_3[i]="${cards[random_number]}"
    color_player_3[i]="$((random_number / 13))"
    hight_player_3[i]="$((random_number % 13))"
  done
  #Generete Player Four
  for i in {0..1}; do
    generate_random_card
    hand_player_4[i]="${cards[random_number]}"
    color_player_4[i]="$((random_number / 13))"
    hight_player_4[i]="$((random_number % 13))"
  done
}

cards=(2h 3h 4h 5h 6h 7h 8h 9h 10h Jh Qh Kh Ah 2s 3s 4s 5s 6s 7s 8s 9s 10s Js Qs Ks As 2d 3d 4d 5d 6d 7d 8d 9d 10d Jd Qd Kd Ad 2c 3c 4c 5c 6c 7c 8c 9c 10c Jc Qc Kc Ac)

declare -a used_card_indexes

declare -a hand_player_1
declare -a hand_player_2
declare -a hand_player_3
declare -a hand_player_4
declare -a hand_group_cards
declare -a color_player_1
declare -a color_player_2
declare -a color_player_3
declare -a color_player_4
declare -a color_group_cards
declare -a hight_player_1
declare -a hight_player_2
declare -a hight_player_3
declare -a hight_player_4
declare -a hight_group_cards

strength_player_1=0
strength_player_2=0
strength_player_3=0
strength_player_4=0

generate_player_cards
generate_group_cards

echo "Cards Player One"
for i in "${hand_player_1[@]}"; do
  echo "$i"
done

echo "Cards Player Two"
for i in "${hand_player_2[@]}"; do
  echo "$i"
done

echo "Cards Player Three"
for i in "${hand_player_3[@]}"; do
  echo "$i"
done

echo "Cards Player Four"
for i in "${hand_player_4[@]}"; do
  echo "$i"
done

echo "Comunntiy Cards"
for i in "${hand_group_cards[@]}"; do
  echo "$i"
done

find_strongest_hand

exit
