#!/bin/bash
if [ -z "$env_name" ]; then 
    env_name='env'
fi
echo $env_name
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
echo $(pipenv --version)