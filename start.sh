#!/bin/sh
./kill_all.sh

xhost +
mkdir -p "$(pwd)/catkin_ws/src"
docker run -it --net=host --gpus all --privileged \
    --env="NVIDIA_DRIVER_CAPABILITIES=all" \
    --env="DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --volume="$(pwd)/catkin_ws:/root/catkin_ws:rw" \
    --name ros_noetic \
    --device=/dev/dri:/dev/dri \
    ros_docker:ros_noetic_nvidia zsh