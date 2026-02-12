#!/bin/bash

# Show Mac notifications
osascript -e "display notification \"${MESSAGE}\" with title \"Claude Code\" sound name \"Blow\""
# choose messages randomly and use say `command` to speak, choosing different voices dependin gon the language if english or spanis 
ARRAY_EN=("I'm done!" "Yo, task completed!" "Hey, all set here!")
ARRAY_ES=("Listo mi perro" "Tarea completada"
	 "Todo en orden!" "Ya terminé!")
RANDOM_INDEX_EN=$((RANDOM % ${#ARRAY_EN[@]}))
RANDOM_INDEX_ES=$((RANDOM % ${#ARRAY_ES[@]}))

# random language selection
LANGUAGE=$((RANDOM % 2))
if [ $LANGUAGE -eq 0 ]; then
    MESSAGE=${ARRAY_EN[$RANDOM_INDEX_EN]}
    say -v Alex "$MESSAGE"
else
    MESSAGE=${ARRAY_ES[$RANDOM_INDEX_ES]}
    say -v Soledad\ \(Enhanced\) "$MESSAGE"
fi
