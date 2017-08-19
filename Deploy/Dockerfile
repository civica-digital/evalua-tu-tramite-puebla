FROM ruby:2.2.5

ENV APP=/app

RUN apt-get update -y \
  && apt-get install -y \
    ssh \
    rsync

ADD . $APP
WORKDIR $APP/Deploy

RUN bundle install \
  && cp -n data_bags/keys/secret.json.example data_bags/keys/secret.json

ARG ssh_user=deploy
ARG ssh_host

ENV SSH_USER=$ssh_user SSH_HOST=$ssh_host

ENTRYPOINT eval $(ssh-agent) \
  && ssh-add $APP/.ssh/id_rsa \
  && knife solo prepare \
       --identity-file ../.ssh/id_rsa \
       --run-list urbem \
       $SSH_USER@$SSH_HOST \
  && knife solo cook $SSH_USER@$SSH_HOST
