/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class SecurityKeysStore {
  String email;
  String id;
  String signPrivateKey;
  String signPublicKey;
  String dataPrivateKey;
  String dataPublicKey;

  SecurityKeysStore(
      {this.email,
      this.id,
      this.signPrivateKey,
      this.signPublicKey,
      this.dataPrivateKey,
      this.dataPublicKey});

  SecurityKeysStore.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        id = json['id'],
        signPrivateKey = json['signPrivateKey'],
        signPublicKey = json['signPublicKey'],
        dataPrivateKey = json['dataPrivateKey'],
        dataPublicKey = json['dataPublicKey'];

  Map<String, dynamic> toJson() => {
        'email': email,
        'id': id,
        'signPrivateKey': signPrivateKey,
        'signPublicKey': signPublicKey,
        'dataPrivateKey': dataPrivateKey,
        'dataPublicKey': dataPublicKey
      };
}
