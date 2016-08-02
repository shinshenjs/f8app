#!/bin/bash
# Create a custom keychain
security create-keychain -p travis ios-build.keychain

# Add certificates to keychain and allow codesign to access them
security -v import travis/scripts/cert/ios_distribution.cer -k ~/Library/Keychains/ios-build.keychain -T /usr/bin/codesign -T /usr/local/bin/xctool
security -v import travis/scripts/cert/Certificates.p12 -P travisPOC111111 -k ~/Library/Keychains/ios-build.keychain -T /usr/bin/codesign -T /usr/local/bin/xctool

# Unlock the keychain
security list-keychain -s ~/Library/Keychains/ios-build.keychain
security unlock-keychain -p travis ~/Library/Keychains/ios-build.keychain

# Set keychain timeout to 1 hour for long builds
security set-keychain-settings -t 3600 -l ~/Library/Keychains/ios-build.keychain

# Put the provisioning profile in place
mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles
cp "travis/scripts/cert/travisPOC.mobileprovision" ~/Library/MobileDevice/Provisioning\ Profiles/
