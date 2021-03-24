/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class SecurityKeysStoreUsers {
  Map<String, String> users;

  SecurityKeysStoreUsers({this.users});

  SecurityKeysStoreUsers.fromJson(Map<String, dynamic> json) {
    users = json.map((key, value) => MapEntry(key, value?.toString()));
  }

  Map<String, dynamic> toJson() => users;
}
