FROM ubuntu:20.04

ENV USERNAME="debug"
ENV USER_UID="1000"
ENV USER_GID="$USER_UID"

RUN apt-get -qq update && \
    apt-get upgrade -y && \
    apt-get install -y apt-transport-https \
                   ca-certificates \
                   software-properties-common \
                   apt-utils \
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
                   mysql-client \
                   postgresql-client  \
	           wget \
                   tmux \ 
                   sudo \
			

# Install mongodb cli 
RUN wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | apt-key add - && \
    echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.4.list && \
    apt-get update && apt-get install mongodb-org-shell

# Install mssql cli 
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list | sudo tee /etc/apt/sources.list.d/msprod.list && \
    apt-get update && \ 
    apt-get install -y unixodbc-dev && \ 
    ACCEPT_EULA=Y apt-get -y install mssql-tools && \
    echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc 

RUN wget https://github.com/mikefarah/yq/releases/download/v4.2.0/yq_linux_amd64 -o /usr/bin/yq && chmod +x /usr/bin/yq

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

USER $USERNAME

CMD ["sleep", "infinity"]
