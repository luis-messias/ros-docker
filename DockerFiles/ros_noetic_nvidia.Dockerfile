FROM nvidia/cudagl:11.3.0-devel-ubuntu20.04
 
# Minimal setup
RUN apt-get update && apt-get install -y locales lsb-release 
ARG DEBIAN_FRONTEND=noninteractive
RUN dpkg-reconfigure locales
 
# Install ROS Noetic
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
RUN apt-get update && apt-get install -y --no-install-recommends ros-noetic-desktop-full
RUN apt-get install -y --no-install-recommends python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential
RUN rosdep init \
    && rosdep fix-permissions \
    && rosdep update
RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc

#Others 
RUN apt-get install -y git zsh curl mesa-utils xserver-xorg-video-all libgl1-mesa-glx libgl1-mesa-dri

#Setting oh my zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" -y
COPY ConfigFiles/ros_noetic_nvidia/.zshrc /root/.zshrc

WORKDIR /root/ros_ws