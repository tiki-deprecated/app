#!/bin/bash

#
# Copyright (c) TIKI Inc.
# MIT license. See LICENSE file in root directory.
#

# (h/t) https://medium.com/@karaiskc/archive-and-export-ios-app-with-github-actions-b44f676e4bf9

security create-keychain -p "" build.keychain

security import "ios/ci/development.cer" -k "$KEYCHAIN" -P "" -A
security import "ios/ci/distribution.cer" -k "$KEYCHAIN" -P "" -A

security list-keychains -s ~/Library/Keychains/build.keychain
security default-keychain -s ~/Library/Keychains/build.keychain
security unlock-keychain -p "" ~/Library/Keychains/build.keychain

security set-key-partition-list -S apple-tool:,apple: -s -k "" ~/Library/Keychains/build.keychain