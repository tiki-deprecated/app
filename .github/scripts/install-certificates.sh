#!/bin/bash

#
# Copyright (c) TIKI Inc.
# MIT license. See LICENSE file in root directory.
#

# (h/t) https://medium.com/@karaiskc/archive-and-export-ios-app-with-github-actions-b44f676e4bf9

security create-keychain -p "" build.keychain

security import "ios/AppleWWDRCAG3.cer" -k ~/Library/Keychains/build.keychain -P "" -A
security import "ios/Development.p12" -t agg -k ~/Library/Keychains/build.keychain -P "" -A
security import "ios/Distribution.p12" -t agg -k ~/Library/Keychains/build.keychain -P "" -A

security list-keychains -s ~/Library/Keychains/build.keychain
security default-keychain -s ~/Library/Keychains/build.keychain
security unlock-keychain -p "" ~/Library/Keychains/build.keychain

security set-key-partition-list -S apple-tool:,apple: -s -k "" build.keychain

security find-identity -v -p codesigning