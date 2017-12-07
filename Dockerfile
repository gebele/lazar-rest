FROM        base/archlinux
MAINTAINER  Denis Gebele <gebele@in-silico.ch>

RUN         pacman-db-upgrade
RUN         pacman -Syyu --noconfirm
RUN         pacman -S base-devel vim cmake gcc-fortran gsl swig ruby boost-libs fontconfig jre7-openjdk-headless git eigen3 wget --noconfirm 
RUN         pacman -Scc --noconfirm
RUN         useradd -ms /bin/bash ist
RUN         echo "ist ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER        ist
WORKDIR     /home/ist
RUN         echo 'gem: --user-install --no-document' > ~/.gemrc
ENV         PATH $PATH:/home/ist/.gem/ruby/2.4.0/bin
RUN         export GEM_HOME=$(ruby -e 'print Gem.user_dir')
RUN         gem install bundler
RUN         bundle config --global silence_root_warning 1

RUN         git clone https://github.com/opentox/lazar.git \ 
            && (cd lazar && git checkout "feature/pure" && bundle install --path ~/.gem)

RUN         git clone https://github.com/opentox/qsar-report.git \
            && (cd qsar-report && git checkout "development" && bundle install --path ~/.gem)

RUN         git clone https://github.com/opentox/lazar-public-data.git 

RUN         git clone https://github.com/opentox/lazar-rest.git \
            && (cd lazar-rest && git checkout "ORN" && bundle install --path ~/.gem)

RUN         git clone https://github.com/swagger-api/swagger-ui.git

COPY        start.sh /home/ist/start.sh
WORKDIR     /home/ist
RUN         sudo chmod +x /home/ist/start.sh
ENTRYPOINT  ["/home/ist/start.sh"]

