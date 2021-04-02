#!/bin/bash

#
# Copyright (c) TIKI Inc.
# MIT license. See LICENSE file in root directory.
#

# (h/t) https://medium.com/@karaiskc/archive-and-export-ios-app-with-github-actions-b44f676e4bf9

mkdir -p "$HOME/Library/MobileDevice/Provisioning Profiles"

echo ${{ env.IOS_DEV_PROFILE_B64 }} | base64 --decode > ios/Development.mobileprovision
echo ${{ env.IOS_DIST_PROFILE_B64 }} | base64 --decode > ios/Distribution.mobileprovision

for PROVISION in `ls ./ios/*.mobileprovision`
do
  UUID=`/usr/libexec/PlistBuddy -c 'Print :UUID' /dev/stdin <<< $(security cms -D -i ./$PROVISION)`
  cp "./$PROVISION" "$HOME/Library/MobileDevice/Provisioning Profiles/$UUID.mobileprovision"
done
