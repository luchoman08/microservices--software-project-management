#!/bin/bash
bin/./start-general-env.sh



scripts_dir=./bin/start-scripts/
command_prefix=$(./bin/./get-command-prefix.sh)


echo "Comando seleccionado" $command_prefix

$command_prefix $scripts_dir'start-orchrestator.sh' & \
$command_prefix $scripts_dir'start-task-assign.sh' & \
if [ -z "$only_python" & $only_python=true]; then
        exit 1
fi
$command_prefix npm run start --prefix software-project-management-frontend & \
$command_prefix npm run watch  --prefix project-managers-interface & \
$command_preifx npm run watch  --prefix user-stories-assignment-service
