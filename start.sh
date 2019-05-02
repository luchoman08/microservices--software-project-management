
konsole --noclose -e ./startOrchrestator.sh & \
konsole --noclose -e ./startTaskAssign.sh & \
konsole --noclose -e npm start --prefix software-project-management-frontend & \
konsole --noclose -e npm run watch  --prefix project-managers-interface & \
konsole --noclose -e npm run watch  --prefix user-stories-assignment-service & \
