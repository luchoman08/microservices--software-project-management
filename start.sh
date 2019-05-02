#!/bin/bash
env_name='env'
start_general_env () {
        if [ -d $env_name ]; then
                echo 'Activando el ambiente'
                source $env_name/bin/activate
        else
                echo 'Ambiente virtual no existe, creandolo bajo el nombre ' $env_name
                virtualenv --python=python3 $env_name
                echo 'Activando el ambiente recien creado'
                source $env_name/bin/activate
                pip install pipenv
        fi

}
get_console_emulator_name (){
        sid=$(ps -o sid= -p "$$")
        sid_as_integer=$((sid)) # strips blanks if any
        session_leader_parent=$(ps -o ppid= -p "$sid_as_integer")
        session_leader_parent_as_integer=$((session_leader_parent))
        emulator=$(ps -o comm= -p "$session_leader_parent_as_integer")
        echo $emulator
}

get_command_prefix () {
        emulator=$(get_console_emulator_name)
        if [ $emulator == 'konsole' ] 
        then
                echo konsole --hold -e
        elif  [ $emulator == 'gnome-terminal' ] || [ $emulator == 'gnome-terminal-' ] ;  # ubuntu gnome terminal return the name gnome-terminal-
        then
                echo xterm -hold -e
        elif [ $emulator == 'xterm' ] 
        then
                echo xterm -hold -e
        else 
                echo 1
        fi
}

scripts_dir=./bin/start-scripts/
command_prefix=$(get_command_prefix)

start_general_env

if [[ $command_prefix  == 1 ]];
then
        echo "Terminal '$(get_console_emulator_name)'no soportada"
        exit 1
fi



$command_prefix $scripts_dir'start-orchrestator.sh' & \
$command_prefix $scripts_dir'start-task-assign.sh' & \
$command_prefix npm run start --prefix software-project-management-frontend & \
$command_prefix npm run watch  --prefix project-managers-interface & \
$command_preifx npm run watch  --prefix user-stories-assignment-service
