#!/bin/bash

#
# Copyright (c) TIKI Inc.
# MIT license. See LICENSE file in root directory.
#

echo ${{ env.ANDROID_SIGNER_B64}} | base64 --decode > android/android_signer.jks
printf 'storePassword=%s\nkeyPassword=%s\nkeyAlias=key\nstoreFile=../android_signer.jks' ${{ env.ANDROID_SIGNER_SECRET }} ${{ env.ANDROID_SIGNER_SECRET }} > android/keystore.properties