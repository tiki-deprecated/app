/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class RepoLocalSsCurrentModel {
  String? email;

  RepoLocalSsCurrentModel({required this.email});

  RepoLocalSsCurrentModel.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      this.email = json['email'];
    }
  }

  Map<String, dynamic> toJson() => {'email': email};
}
