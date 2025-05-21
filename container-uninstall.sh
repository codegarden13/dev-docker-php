#!/bin/bash
# (chmod 755 remove-all.sh)
source .env 

# Log
current_time=$(date "+%Y%m%d-%H%M%S")
LOCAL_IP=$(ifconfig | awk '/inet /&&!/127.0.0.1/{print $2;exit}')
HOST=$(hostname)

SCRIPTNAME="$(basename "${BASH_SOURCE[0]}" .sh)"
logfile=logs/${current_time}_${SCRIPTNAME}_${HOST}.log

echo "Starting "${SCRIPTNAME} "from " ${LOCAL_IP}> $logfile



#docker stop $(docker ps -a -q)

# Get running container names
names=$(docker ps | awk '{if(NR>1) print $NF}')

for name in ${names}; do 
    docker stop $name
    docker rm -v $name
    echo "removed container inc volume: "$name 
   
done


# Remove all volumes

volumes=$(docker volume ls -qf dangling=true)

for name in ${volumes}; do 
echo "try docker volume rm on "$name
    docker volume rm -v $name
   
done

rm -Rf stg* >> $logfile
rm -Rf prd* >> $logfile
rm -Rf apache* >> $logfile

docker volume rm $(docker volume ls -qf dangling=true) >> $logfile

docker system prune -f

#docker rm $(docker ps -a -q)

rm -Rf ${FILE_PATH_stg} >> $logfile
rm -Rf ${FILE_PATH_prd} >> $logfile

docker container prune --force >> $logfile
docker system prune --force >> $logfile
docker volume prune --force >> $logfile

