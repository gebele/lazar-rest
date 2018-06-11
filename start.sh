#!/bin/sh

sudo mongod &
R CMD Rserve --vanilla &
#cd $HOME/lazar-rest &&
#unicorn -p 8089 -E production
cd $HOME/lazar-gui &&
unicorn -p 8089 -E production

if ! [[ -h "$HOME/lazar-gui/public/swagger-ui-bundle.js" ]]; then
  ln -s "$HOME/swagger-ui/dist/swagger-ui-bundle.js" "$HOME/lazar-gui/public/swagger-ui-bundle.js"
fi
if ! [[ -h "$HOME/lazar-gui/public/swagger-ui-standalone-preset.js" ]]; then
  ln -s "$HOME/swagger-ui/dist/swagger-ui-standalone-preset.js" "$HOME/lazar-gui/public/swagger-ui-standalone-preset.js"
fi
if ! [[ -h "$HOME/lazar-gui/public/swagger-ui.css" ]]; then
  ln -s "$HOME/swagger-ui/dist/swagger-ui.css" "$HOME/lazar-gui/public/swagger-ui.css"
fi

#cd $HOME/lazar-public-data
#if [ ! -d "$HOME/lazar-validation-reports" ]
#then
#  ruby $HOME/lazar-public-data/create_test_prediction_models.rb
#fi
