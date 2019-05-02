#!/bin/bash

scripts_dir=./bin/start-scripts/
get_console_emulator_name (){
        sid=$(ps -o sid= -p "$$")
        sid_as_integer=$((sid)) # strips blanks if any
        session_leader_parent=$(ps -o ppid= -p "$sid_as_integer")
        session_leader_parent_as_integer=$((session_leader_parent))
        emulator=$(ps -o comm= -p "$session_leader_parent_as_integer")
        echo $emulator
}
emulator=$(get_console_emulator_name)
get_command_prefix () {
        if [ $emulator == 'konsole' ] 
        then
                echo konsole --hold -e
        elif  [ $emulator == 'gnome-terminal' ] || [ $emulator == 'gnome-terminal-' ] ;  # ubuntu gnome terminal return the name gnome-terminal-
        then
                echo gnome-terminal   -e
        elif [ $emulator == 'xterm' ] 
        then
                echo xterm --hold -e
        else 
                echo 1
        fi
}
command_prefix=$(get_command_prefix)
if [[ $command_prefix  == 1 ]];
then
        echo "Terminal '$(get_console_emulator_name)'no soportada"
        exit 1
fi



echo $command_prefix "$scripts_dirstart-orchrestator.sh" & \
$command_prefix "$scripts_dir'start-task-assign.sh'" & \
#$command_prefix npm start --prefix software-project-management-frontend & \
#$command_prefix npm run watch  --prefix project-managers-interface & \
#$command_preifx npm run watch  --prefix user-stories-assignment-service & \
