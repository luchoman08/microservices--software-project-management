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
                if [ -z $(whereis xterm | cut -d' ' -f2)]; then 
                    echo xterm -hold -e
                else 
                    echo 1
                fi
        elif [ $emulator == 'xterm' ] 
        then
                echo xterm -hold -e
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

echo $command_prefix