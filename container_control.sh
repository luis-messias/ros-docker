#!/bin/bash
build() {
    docker build -t ros_docker:ros_noetic_nvidia .
}

kill() {
    docker container stop ros_noetic
    docker container remove ros_noetic
}

start() {
    xhost +
    mkdir -p "$(pwd)/catkin_ws/src"
    docker run -it --detach --net=host --gpus all --privileged \
        --env="NVIDIA_DRIVER_CAPABILITIES=all" \
        --env="DISPLAY" \
        --env="QT_X11_NO_MITSHM=1" \
        --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
        --volume="$(pwd)/catkin_ws:/root/catkin_ws:rw" \
        -v ~/.gitconfig:/etc/gitconfig \
        --name ros_noetic \
        --device=/dev/dri:/dev/dri \
        ros_docker:ros_noetic_nvidia zsh
}

attach_shell(){
    docker exec -it ros_noetic zsh 
}

while [ $# -gt 0 ]; do 
    case $1 in
    -b|--build)
      build
      shift
      ;;
    -k|--kill)
      kill
      shift
      ;;
    -s|--start)
      start
      shift
      ;;
    -a|--attach_shell)
      attach_shell
      shift
      ;;
    *)
      echo Agumento inválido ["$1"]
      shift # past argument
      ;;
  esac
done

