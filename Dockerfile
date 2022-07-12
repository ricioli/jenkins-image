FROM jenkins/jenkins:lts-jdk11

USER root

RUN apt-get update \
      && apt-get install -y sudo \
      && rm -rf /var/lib/apt/lists/*
RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

RUN apt-get update && apt-get install -y apt-utils

RUN curl -fsSL https://get.docker.com -o get-docker.sh
RUN sh get-docker.sh

RUN usermod -aG docker jenkins

# COPY /var/run/docker.sock /var/run/docker.sock
# COPY ~/.ssh/id_rsa ~/.ssh/id_rsa

# RUN chmod 666 /var/run/docker.sock

RUN apt-get install -y sqitch libdbd-pg-perl postgresql-client libdbd-sqlite3-perl sqlite3
RUN sqitch config --user user.name jenkins
RUN sqitch config --user user.email jenkins@jenkins.jen

USER jenkins