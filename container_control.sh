#!/bin/bash

build() {
    docker build -t ros_docker:ros_noetic_nvidia -f DockerFiles/${DOCKERFILE} .
}

kill() {
    docker container stop ${DOCKERFILE}
    docker container remove ${DOCKERFILE}
}

start() {
    xhost +
    mkdir -p "$(pwd)/catkin_ws/src"
    docker run -it --detach --net=host --gpus all --privileged \
        --env="NVIDIA_DRIVER_CAPABILITIES=all" \
        --env="DISPLAY" \
        --env="QT_X11_NO_MITSHM=1" \
        --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
        --volume="$(pwd)/${DOCKERFILE}_ws:/root/catkin_ws:rw" \
        -v ~/.gitconfig:/etc/gitconfig \
        --name ${DOCKERFILE} \
        --device=/dev/dri:/dev/dri \
        ros_docker:${DOCKERFILE} zsh
}

attach_shell(){
    docker exec -it ${DOCKERFILE} zsh 
}

DOCKERFILE="ros_noetic_nvidia"
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
    --all)
      kill
      build
      start
      attach_shell
      exit 0
      ;;
    *)
      echo Config selecionada ["$1"]
      shift # past argument
      ;;
  esac
done

