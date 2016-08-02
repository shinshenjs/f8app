#!/bin/bash
set -ev
npm test

if [[ $? != 0 ]]
then
  echo ">> Jest test failed!!"
  exit 1;
else
  echo ">> Jest test passed!!"
fi
