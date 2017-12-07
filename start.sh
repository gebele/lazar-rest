#!/bin/sh

cd $HOME/lazar-public-data
if [ ! -d "$HOME/lazar-validation-reports" ]
then
  ruby $HOME/lazar-public-data/create_test_prediction_models.rb
fi
cd $HOME/lazar-rest &&
#cd $HOME/lazar-gui &&
unicorn -p 8089 -E production
