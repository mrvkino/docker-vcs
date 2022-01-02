# Define the installer image stage
# 18.04 is bionic
# https://wiki.ubuntu.com/Releases
# https://packages.ubuntu.com
FROM ubuntu:18.04 AS installer

LABEL maintainer="Michel Rogers-Vallée"

# Definition of the tool to install and where to install
ARG vcs_name="VCS"
ARG dve_name="DVE"
ARG version_letter="P"
ARG version="2019.06-SP2"
ARG subversion="-7"
ARG host_vcs_dir_path="./${vcs_name}${version}${subversion}"
ARG host_dve_dir_path="./${dve_name}${version}${subversion}"
ARG local_vcs_dir_path="/tmp/vcs"
ARG local_dve_dir_path="/tmp/dve"
ARG install_dir_path="/opt"

ARG installer_version="5.1"
ARG host_installer_dir_path="./installer_v${installer_version}"
ARG local_installer_dir_path="/tmp/installer"
ARG installer_dir_path="/usr/synopsys/installer"

# ADD dependency
RUN apt-get update

# base docker image from synopsys
# from https://hub.docker.com/layers/vgsnps/vcs_docker/latest/images/sha256-c2283e8c6f1007ccfb868a0502467726b6e0a08228b208a3b5e47995ae08f5f9?context=explore
# RUN apt-get install --no-install-recommends -y numactl csh tcsh make
RUN apt-get install -y --no-install-recommends csh tcsh
# lib to use
# RUN apt-get install --no-install-recommends -y libstdc++-devel.i686 ncurses glibc.i686

# from: https://github.com/limerainne/Dockerize-EDA/blob/master/Dockerfile_Synopsys_VCS
# RUN apt-get install --no-install-recommends -y libxss1 libsm6 libice6 libxft2 libjpeg62 libtiff5 libmng2
# minimal xorg install
RUN apt-get install --no-install-recommends -y xserver-xorg-video-dummy xserver-xorg-input-void xserver-xorg-core xinit x11-xserver-utils
# RUN apt-get install --no-install-recommends -y build-essential dc

# change dash to bash
RUN echo "dash dash/sh boolean false" | debconf-set-selections && dpkg-reconfigure -f noninteractive dash

# Copy the installer to the image
COPY ${host_installer_dir_path} ${local_installer_dir_path}

# copy the VCS file to the image
COPY ${host_vcs_dir_path} ${local_vcs_dir_path}
COPY ${host_dve_dir_path} ${local_dve_dir_path}

# install the synopsys installer
# RUN ${local_installer_dir_path}/SynopsysInstaller_v${installer_version}.run -dir ${installer_dir_path} && echo 'yes'

# run the install dir and remove installer files
ARG source_installer_dir="${local_installer_dir_path}"
# ARG source_installer_dir="${installer_dir_path}"
RUN USER=docker ${source_installer_dir}/batch_installer -allprods -install_as_root -source ${local_vcs_dir_path} -target ${install_dir_path}
RUN USER=docker ${source_installer_dir}/batch_installer -allprods -install_as_root -source ${local_dve_dir_path} -target ${install_dir_path}

# set path to the tool executable
ARG vcs_home="${install_dir_path}/vcs/${version_letter}-${version}${subversion}"

ENV VCS_HOME ${vcs_home}
ENV PATH ${vcs_home}/bin:$PATH
ENV VCS_TARGET_ARCH "amd64"

# default command when running this image
CMD "vcs -full64"
