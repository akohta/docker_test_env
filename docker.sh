#!/bin/bash

# akohta 2021/11/10, CentOS 7

image_name=u_testenv
container_hostname=ubuntu_container
network=host
host_display=localhost:0.0
x11_soc=/tmp/.X11-unix
local_share_folder=$PWD
container_share_folder=/home/user/share
docker_command="sudo podman"


if [ "$1" = "build" ]; then
   $docker_command build . -t $image_name
elif [ "$1" = "run" ]; then
   xhost + localhost
   $docker_command run -itd --name $image_name --hostname=$container_hostname --net=$network\
                   -v $local_share_folder:$container_share_folder:Z\
                   -e DISPLAY=$host_display -v $x11_soc:$x11_soc:Z\
                   localhost/$image_name
   $docker_command exec -it $image_name /bin/bash
elif [ "$1" = "login" ]; then
   $docker_command exec -it $image_name /bin/bash
elif [ "$1" = "root_login" ]; then
   $docker_command exec -it -u root $image_name /bin/bash
elif [ "$1" = "stop" ]; then
   xhost - localhost
   $docker_command stop $image_name
elif [ "$1" = "restart" ]; then
   xhost + localhost
   $docker_command start $image_name
elif [ "$1" = "del_cnt" ]; then
   $docker_command rm $image_name
elif [ "$1" = "del_img" ]; then
   $docker_command rmi $image_name
else
   echo "Usage : $0 build     ( build image )"
   echo "        $0 run       ( run container and login )"
   echo "        $0 login     ( login container )"
   echo "        $0 root_login( login as root )"
   echo "        $0 stop      ( stop container )"
   echo "        $0 restart   ( restart container )"
   echo "        $0 del_cnt   ( delete container )"
   echo "        $0 del_img   ( delete image )"
fi
