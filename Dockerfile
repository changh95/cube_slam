FROM osrf/ros:kinetic-desktop-full-xenial

ARG DEBIAN_FRONTEND=noninteractive

# Dependencies
RUN apt-get update -y && \
    apt-get install -y sudo unzip git libeigen3-dev wget build-essential gdb cmake \
    libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev libglew-dev

# OpenCV
RUN wget -O opencv.zip https://github.com/opencv/opencv/archive/3.4.15.zip && \
    unzip opencv.zip && \
    cd opencv-3.4.15  && \
    mkdir build && cd build && \
    cmake .. && make -j && make install

# Pangolin
RUN wget https://github.com/stevenlovegrove/Pangolin/archive/refs/tags/v0.6.zip &&\
    unzip v0.6.zip &&\
    cd Pangolin-0.6 && mkdir build && cd build &&\
    cmake .. &&\
    make -j4 &&\
    cd ../../
    

# Build cube_slam
RUN mkdir -p ~/cubeslam_ws/src &&\ 
    cd ~/cubeslam_ws/src &&\
    /bin/bash -c '. /opt/ros/kinetic/setup.bash; catkin_init_workspace' &&\
    # catkin_init_workspace &&\
    git clone https://github.com/changh95/cube_slam &&\
    cd cube_slam &&\
    sh ./install_dependencies.sh &&\
    cd ~/cubeslam_ws &&\
    /bin/bash -c '. /opt/ros/kinetic/setup.bash; catkin_make -j4'
   
 
