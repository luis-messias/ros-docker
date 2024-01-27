FROM nvidia/cuda:12.3.1-base-ubuntu22.04
 
# Minimal setup
RUN apt-get update && apt-get install -y locales lsb-release 
ARG DEBIAN_FRONTEND=noninteractive
RUN dpkg-reconfigure locales
 
# Install ROS 2 Humble
RUN apt install -y software-properties-common curl  &&  add-apt-repository universe
RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null
RUN apt update && apt upgrade -y && apt install -y ros-humble-desktop
RUN apt-get install -y python3-colcon-common-extensions python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential python3-pip
RUN rosdep init \
    && rosdep fix-permissions \
    && rosdep update
#Others 
RUN apt-get install -y git zsh mesa-utils xserver-xorg-video-all libgl1-mesa-glx libgl1-mesa-dri

#Setting oh my zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" -y
COPY ConfigFiles/ros2_humble_nvidia/.zshrc /root/.zshrc

WORKDIR /root/ros_ws