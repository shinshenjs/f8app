#!/bin/bash
set -ev
# echo ">> Starting Jest Unit Test..."
#./travis/tests/jest-unit-test.sh

if [ "$BUILD_TYPE" = jobst-ios ]
then
  xctool -project ios/travisPOC.xcodeproj \
    -scheme travisPOC \
    -sdk iphoneos \
    -configuration Release \
    OBJROOT=$HOME/travisPOC/ios/build \
    SYMROOT=$HOME/travisPOC/ios/build \
    PROVISIONING_PROFILE="d81d4408-1c56-43cc-9622-98102fc206fb" \
    CODE_SIGN_IDENTITY="iPhone Distribution: Tek Min Ewe (P8F363AVJ2)" \
    OTHER_CODE_SIGN_FLAGS="--keychain ios-build.keychain" \
    DEAD_CODE_STRIPPING=NO \
    build
  if [[ $? != 0 ]];then
    echo ">> xctool build failed"
    exit 1;
  fi
elif [ "$BUILD_TYPE" = jobst-and ]
then
  cd android

  ./gradlew test --stacktrace --quiet
  if [[ $? != 0 ]];then
    echo ">> gradlew test failed"
    exit 1;
  fi
else
  echo "Unknown test type: $BUILD_TYPE"
exit 1
fi
