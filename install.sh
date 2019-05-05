#!/bin/bash
bin/./start-general-env.sh

command_prefix=$(./bin/./get-command-prefix.sh)
scripts_dir=./bin/install-scripts/

$command_prefix $scripts_dir'install-orchrestator.sh' & \
$command_prefix $scripts_dir'install-task-assign.sh' & \
$command_prefix npm install --prefix project-managers-interface/ && npm run build --prefix project-managers-interface&
$command_prefix npm install --prefix software-project-management-frontend/ &
$command_prefix npm install --prefix user-stories-assignment-service/ && npm run build --prefix user-stories-assignment-service
