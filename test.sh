#!/bin/sh
sleep 5

# service test
if [ ! -f test.log ]; then
  echo "#################"
  echo "Running tests ..." 1>&2
  ruby service-test.rb > test.log
  if [ `grep -c "0 errors" test.log` == 1 ]; then
    echo "#####################"
    echo "Service tests passed." 1>&2
    exit 0
  else
    echo "##########################"
    echo "Service tests with errors." 1>&2
    cat test.log 1>&2
    kill -9 -1
    exit 1
  fi
fi
