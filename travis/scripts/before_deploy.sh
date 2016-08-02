#!/bin/bash
if [ "$BUILD_TYPE" = jobst-ios ]
then
  xcrun -v -sdk iphoneos PackageApplication "$HOME/travisPOC/ios/build/Release-iphoneos/travisPOC.app" -o "$HOME/travisPOC/ios/build/Release-iphoneos/$BUILD_TYPE.ipa"
  if [[ $? != 0 ]];then
    echo ">> ipa Packaging failed"
    exit 1;
  else
    echo ">> ipa Packaging success"
  fi
elif [ "$BUILD_TYPE" = jobst-and ]
then
  cd android
  ./gradlew assembleRelease --stacktrace
  if [[ $? != 0 ]];then
    echo ">> gradlew assembleRelease failed"
    exit 1;
  else
    mv ./app/build/outputs/apk/app-release.apk ./app/build/outputs/apk/$BUILD_TYPE.apk
    echo ">> gradlew assembleRelease success"
  fi
fi
