#!/bin/sh

sudo mongod &
R CMD Rserve --vanilla &
cd $HOME/lazar-rest &&
unicorn -p 8089 -E production
cd $HOME/lazar-gui &&
unicorn -p 8088 -E production

cd $HOME/lazar-public-data
if [ ! -d "$HOME/lazar-validation-reports" ]
then
  ruby $HOME/lazar-public-data/create_test_prediction_models.rb
fi
