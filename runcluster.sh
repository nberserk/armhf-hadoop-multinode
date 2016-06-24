#!/bin/bash
set -euo pipefail
set -x


function push_images(){    
    docker pull 10.240.70.80:5000/armhf-hadoop-master
    docker pull 10.240.70.80:5000/armhf-hadoop-slave

    echo $(date) ":"
    docker save -o ~/h-m.tar 10.240.70.80:5000/armhf-hadoop-master
    echo $(date) ":"
    docker save -o ~/h-s.tar 10.240.70.80:5000/armhf-hadoop-slave

    echo $(date) ":" 
    adb -s 71DA5F114DF1D15F push ~/h-m.tar /data/project
    echo $(date) ":"
    adb -s 482E3F894D016FC2 push ~/h-s.tar /data/project    
}


DOCKER=docker-1.10.2
function removeContainer(){    
    for device in 482E3F894D016FC2 71DA5F114DF1D15F                  
    do
        # removing container
        id=$(adb -s $device shell docker-1.10.2 ps -a -q)
        id2="$(echo -e "${id}" | sed -e 's/[[:space:]]*$//')"
        if [ -n "$id2" ]; then
            echo "removing container $id2 for $device"
            adb -s $device shell $DOCKER rm -f $id2    
        fi        
    done
}

function removeImage(){    
    for device in 482E3F894D016FC2 71DA5F114DF1D15F                  
    do
        #remove image
        id=$(adb -s $device shell docker-1.10.2 images -a -q)
        id2="$(echo -e "${id}" | sed -e 's/[[:space:]]*$//')"
        if [ -n "$id2" ]; then
            echo "removing image $id2 for $device"
            adb -s $device shell $DOCKER rmi $id2    
        fi
    done
}

function loadImage(){
    echo $(date) ":"
    adb -s 482E3F894D016FC2 shell docker-1.10.2 load -i /data/project/h-s.tar
    echo $(date) ":"
    adb -s 71DA5F114DF1D15F shell docker-1.10.2 load -i /data/project/h-m.tar    
}

echo $(date) ":"

exit

 push_images
removeContainer
 removeImage
 loadImage
adb -s 482E3F894D016FC2 shell docker-1.10.2 run -d -e MASTER=192.168.0.55 -h s1.galup.com --name=s1 -p 2122:2122 -p 9000:9000 -p 50010:50010 -p 50020:50020 -p 50070:50070 -p 50075:50075 -p 50090:50090 -p 50475:50475 10.240.70.80:5000/armhf-hadoop-slave
adb -s 71DA5F114DF1D15F shell docker-1.10.2 run -d -e MASTER=192.168.0.55 -e SLAVES=192.168.0.55,192.168.0.21 --name master --net=host 10.240.70.80:5000/armhf-hadoop-master

# when use --net=host hostname is fixed to localhost for both, so in webui only 1 datanode exists.
# adb -s 482E3F894D016FC2 shell docker-1.10.2 run -d -e MASTER=192.168.0.55 --name s1 --net=host 10.240.70.80:5000/armhf-hadoop-slave
# adb -s 71DA5F114DF1D15F shell docker-1.10.2 run -d -e MASTER=192.168.0.55 -e SLAVES=192.168.0.55,192.168.0.21 --name master --net=host 10.240.70.80:5000/armhf-hadoop-master
