FROM ubuntu:20.04

ENV USERNAME="debug"
ENV USER_UID="1000"
ENV USER_GID="$USER_UID"

RUN apt-get -qq update && \
    apt-get upgrade -y && \
    apt-get install -y apt-transport-https \
                   ca-certificates \
                   software-properties-common \
                   man \
                   manpages-posix \
                   man-db \
                   vim \
                   screen \
                   curl \
                   atop \
                   htop \
                   dstat \
                   jq \
                   dnsutils \
                   tcpdump \
                   traceroute \
                   iputils-ping \
                   net-tools \
                   netcat \
                   iproute2 \
                   strace \
                   telnet \
                   conntrack \
                   tmux \ 
                   sudo
                   
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

USER $USERNAME

CMD ["sleep", "infinity"]
