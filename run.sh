groupadd -for -g $(stat -c '%g' /var/run/docker.sock) docker
usermod -aG docker jenkins
su -c /usr/local/bin/jenkins.sh jenkins
