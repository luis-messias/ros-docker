#!/bin/sh
./kill_all.sh

xhost +
docker run -it --net=host --gpus all --privileged \
    --env="NVIDIA_DRIVER_CAPABILITIES=all" \
    --env="DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --name ros_noetic \
    --device=/dev/dri:/dev/dri \
    ros_docker:ros_noetic_nvidia 