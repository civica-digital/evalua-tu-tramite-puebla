FROM phusion/passenger-ruby22
MAINTAINER "Mikesaurio & Miguel Angel Gordian"

ENV HOME /root
RUN bash -lc 'rvm install ruby-2.2.5'
RUN bash -lc 'rvm --default use ruby-2.2.5'


USER app
RUN bash -lc 'rvm --default use ruby-2.2.5'
WORKDIR /home/app/urbem
ADD . /home/app/urbem
ADD docker/database.yml /home/app/urbem/config/database.yml
RUN gem install bundler
RUN bundle install

USER root
RUN chown -R app:app /home/app/urbem
RUN ln -sf /proc/self/fd /dev/

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
