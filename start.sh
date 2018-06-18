#!/bin/sh

# start basic services
sudo mongod &
R CMD Rserve --vanilla &

# symlinks for swagger
if ! [[ -h "$HOME/lazar-gui/public/swagger-ui-bundle.js" ]]; then
  ln -s "$HOME/swagger-ui/dist/swagger-ui-bundle.js" "$HOME/lazar-gui/public/swagger-ui-bundle.js"
fi
if ! [[ -h "$HOME/lazar-gui/public/swagger-ui-standalone-preset.js" ]]; then
  ln -s "$HOME/swagger-ui/dist/swagger-ui-standalone-preset.js" "$HOME/lazar-gui/public/swagger-ui-standalone-preset.js"
fi
if ! [[ -h "$HOME/lazar-gui/public/swagger-ui.css" ]]; then
  ln -s "$HOME/swagger-ui/dist/swagger-ui.css" "$HOME/lazar-gui/public/swagger-ui.css"
fi

# fetch and load database content
if [ ! -d "$HOME/dump" ]; then
  mkdir dump
  wget https://dump.in-silico.ch/dump.tar.gz
  tar xfvz dump.tar.gz -C dump
  mongorestore
fi

# start lazar service
cd $HOME/lazar-gui &&
unicorn -p 8088 -E production

