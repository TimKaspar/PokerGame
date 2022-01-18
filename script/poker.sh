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
    height_group_cards[i]="$((random_number % 13))"
  done
}

is_random_number_in_used_card_indexes() {
  for i in "${used_card_indexes[@]}"; do
    if [ "${i}" == "${random_number}" ]; then
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

  used_card_indexes+=("${random_number}")

}
calculate_player_strength() {
  #Stärke der Hand von Spieler wird ermittelt
  current_strength=0
  pair=false
  pair_height=-1
  two_pair=false
  triple=false
  triple_height=-1
  quad=false
  flush=false

  for ((i = 0; i < 6; i++)); do
    founded_height=-1
    same_height=1
    for ((j = i + 1; j < 7; j++)); do
      if [ -$((heights_collection[i])) -eq -$((heights_collection[j])) ]; then
        same_height="$(($same_height + 1))"
        founded_height=$((heights_collection[i]))
      fi
    done
    if [ "$same_height" == "2" ]; then
      if $pair; then
        two_pair=true
      else
        pair=true
        pair_height=$founded_height
      fi
    fi
    if [ "$same_height" == "3" ]; then
      triple=true
      triple_height=$founded_height
    fi
    if [ "$same_height" == "4" ]; then
      quad=true
    fi
  done

  #Nach Flush suchen
  for ((i = 0; i < 6; i++)); do
    same_color=1
    for ((j = i + 1; j < 7; j++)); do
      if [ -$((color_collection[i])) -eq -$((color_collection[j])) ]; then
        same_color="$(($same_color + 1))"
      fi
    done
    if [ $same_color -ge "5" ]; then
      flush=true
    fi
  done

  #Stärke der Hand wird zugestellt
  #Schauen ob quads vorhanden sind:
  if $quad; then
    current_strength=7
    return
  fi
  #Schauen ob Full House vorhanden ist:
  if $triple && $pair; then
    if [ $pair_height -ne $triple_height ]; then
      current_strength=6
      return
    fi
  fi
  #Schauen ob Flush vorhanden ist:
  if $flush; then
    current_strength=5
    return
  fi
  #Schauen ob triple vorhanden sind:
  if $triple; then
    current_strength=3
    return
  fi
  #Schauen ob Two Pairs vorhanden sind:
  if $two_pair; then
    current_strength=2
    return
  fi

  #Schauen ob Pairs vorhanden sind:
  if $pair; then
    current_strength=1
    return
  fi
}

find_strongest_hand() {
  heights_collection=("${height_player_1[@]}" "${height_group_cards[@]}")
  color_collection=("${color_player_1[@]}" "${color_group_cards[@]}")
  calculate_player_strength
  strength_player_1=$current_strength

  heights_collection=("${height_player_2[@]}" "${height_group_cards[@]}")
  color_collection=("${color_player_2[@]}" "${color_group_cards[@]}")
  calculate_player_strength
  strength_player_2=$current_strength

  heights_collection=("${height_player_3[@]}" "${height_group_cards[@]}")
  color_collection=("${color_player_3[@]}" "${color_group_cards[@]}")
  calculate_player_strength
  strength_player_3=$current_strength

  heights_collection=("${height_player_4[@]}" "${height_group_cards[@]}")
  color_collection=("${color_player_4[@]}" "${color_group_cards[@]}")
  calculate_player_strength
  strength_player_4=$current_strength

  echo "Player One's Hand is ${strength_player_1}."
  echo "Player Two's Hand is ${strength_player_2}."
  echo "Player Three's Hand is ${strength_player_3}."
  echo "Player Four's Hand is ${strength_player_4}."

  return
}

generate_player_cards() {
  #Generete Player One
  for i in {0..1}; do
    generate_random_card
    hand_player_1[i]="${cards[random_number]}"
    color_player_1[i]="$((random_number / 13))"
    height_player_1[i]="$((random_number % 13))"
  done

  #Generete Player Two
  for i in {0..1}; do
    generate_random_card
    hand_player_2[i]="${cards[random_number]}"
    color_player_2[i]="$((random_number / 13))"
    height_player_2[i]="$((random_number % 13))"
  done
  #Generete Player Three
  for i in {0..1}; do
    generate_random_card
    hand_player_3[i]="${cards[random_number]}"
    color_player_3[i]="$((random_number / 13))"
    height_player_3[i]="$((random_number % 13))"
  done
  #Generete Player Four
  for i in {0..1}; do
    generate_random_card
    hand_player_4[i]="${cards[random_number]}"
    color_player_4[i]="$((random_number / 13))"
    height_player_4[i]="$((random_number % 13))"
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
declare -a height_player_1
declare -a height_player_2
declare -a height_player_3
declare -a height_player_4
declare -a height_group_cards

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
