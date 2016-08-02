#!/bin/bash
set -ev
if [ "$BUILD_TYPE" = jobst-ios ]
then
  brew reinstall node flow watchman xctool
elif [ "$BUILD_TYPE" = jobst-and ]
then
  brew reinstall node gradle flow watchman android-sdk
  echo ">> Installing necessary android extension..."
  echo "y" | android update sdk --no-ui --filter android-23
  echo "y" | android update sdk --all --no-ui --filter build-tools-23.0.1
  echo "y" | android update sdk --all --no-ui --filter extra-android-m2repository
fi
echo ">> Installing react-native-cli..."
npm install -g react-native-cli
echo ">> Installing nodeJS dependencies..."
npm install

if [ "$BUILD_TYPE" = jobst-ios ]
then
  echo ">> Decrypt IOS Key"
  sh ./travis/scripts/decrypt_key.sh
  echo ">> Adding IOS Key to system"
  sh ./travis/scripts/add_key.sh
elif [ "$BUILD_TYPE" = jobst-and  ]
then
  echo ">> Decrypt Keystore"
  openssl aes-256-cbc -k ${ENCRYPT_PASS} -in travis/scripts/cert/travisPOC.keystore.enc -out travis/scripts/cert/travisPOC.keystore -d -a
  mv travis/scripts/cert/travisPOC.keystore android/app/travisPOC.keystore
  echo ">> Set Gradle Properties"
  echo "RELEASE_STORE_FILE=travisPOC.keystore" >> ~/.gradle/gradle.properties
  echo "RELEASE_KEY_ALIAS=travis-poc" >> ~/.gradle/gradle.properties
  echo "RELEASE_STORE_PASSWORD=$ENCRYPT_PASS" >> ~/.gradle/gradle.properties
  echo "RELEASE_KEY_PASSWORD=$ENCRYPT_PASS" >> ~/.gradle/gradle.properties
fi
