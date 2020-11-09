FROM jenkins/jenkins:2.249.2-slim
USER root
RUN apt-get update && apt-get install -y apt-transport-https \
       ca-certificates curl gnupg2 \
       software-properties-common
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN apt-key fingerprint 0EBFCD88
RUN add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/debian \
       $(lsb_release -cs) stable"
RUN apt-get update && apt-get install -y docker-ce-cli

EXPOSE 8080
VOLUME /var/jenkins_home
VOLUME /var/run/docker.sock

USER jenkins
RUN jenkins-plugin-cli --plugins blueocean:1.24.3

USER root
COPY run.sh /run.sh
RUN chmod +x /run.sh
ENTRYPOINT ["sh", "/run.sh"]
