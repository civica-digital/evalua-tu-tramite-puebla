#!/bin/bash

main() {
  create_user
  make_app_dir
  configure_ssh
  install_docker
  install_docker_compose
}

create_user() {
  useradd --create-home --shell /bin/bash deploy
  gpasswd -a deploy sudo
  cp -R ~/.ssh /home/deploy/
  chown -R deploy:deploy /home/deploy/.ssh
  echo 'deploy ALL=NOPASSWD:ALL' >> /etc/sudoers
}

make_app_dir() {
  app_dir="/var/www/${project_name}"
  mkdir -p $app_dir
  chown -R deploy:deploy $app_dir
}

configure_ssh() {
  sed -i 's/RootLogin yes/RootLogin no/' /etc/ssh/sshd_config
  systemctl restart ssh
}

install_docker() {
  # Update repository
  sudo apt-get -y update

  # Install dependencies
  sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

  # Add Docker’s official GPG key
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

  # Add Docker's repository
  sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

  # Install Docker (Community edition)
  sudo apt-get update -y \
    && apt-get install -y docker-ce

  sudo gpasswd -a deploy docker
}

install_docker_compose() {
  sudo curl -L https://github.com/docker/compose/releases/download/1.14.0/docker-compose-`uname -s`-`uname -m` -o docker-compose
  sudo mv docker-compose /usr/local/bin/
  sudo chmod +x /usr/local/bin/docker-compose
}

main
