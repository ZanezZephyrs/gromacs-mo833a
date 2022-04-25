
FROM ubuntu:latest

ARG build_type

RUN apt-get update
RUN apt-get install cmake -y
RUN apt-get install g++ -y

RUN mkdir gromacs-2022

WORKDIR /gromacs-2022

COPY ./ ./

RUN apt upgrade -y && apt-get install linux-tools-common -y  && apt-get install linux-tools-generic -y && apt-get install linux-tools-`uname -r` -y

RUN apt-get valgrind -y

RUN mkdir build && cd build && cmake .. -DGMX_BUILD_OWN_FFTW=ON -DCMAKE_BUILD_TYPE=$build_type

WORKDIR /gromacs-2022/build


RUN make

RUN make install

ENV PATH=${PATH}:/gromacs-2022/build/bin

