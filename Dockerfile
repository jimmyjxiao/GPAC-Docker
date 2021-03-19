FROM ubuntu:latest
RUN apt-get update
RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y build-essential pkg-config g++ git scons cmake yasm
RUN apt-get install -y zlib1g-dev libfreetype6-dev libjpeg62-dev libpng-dev libmad0-dev libfaad-dev libogg-dev libvorbis-dev libtheora-dev liba52-0.7.4-dev libavcodec-dev libavformat-dev libavutil-dev libswscale-dev libavdevice-dev libxv-dev x11proto-video-dev libgl1-mesa-dev x11proto-gl-dev libxvidcore-dev libssl-dev libjack-dev libasound2-dev libpulse-dev libsdl2-dev dvb-apps mesa-utils

RUN git clone https://github.com/gpac/gpac gpac_public

RUN git clone https://github.com/gpac/deps_unix

WORKDIR deps_unix

RUN git submodule update --init --recursive --force --checkout

RUN ./build_all.sh linux

WORKDIR ../gpac_public

RUN ./configure
RUN make
RUN make install

ENTRYPOINT [ "gpac" ]