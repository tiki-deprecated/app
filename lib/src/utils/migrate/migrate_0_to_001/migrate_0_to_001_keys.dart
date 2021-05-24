/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class Migrate0To001Keys {
  String? uuid;
  String? address;
  String? signPrivateKey;
  String? signPublicKey;
  String? dataPrivateKey;
  String? dataPublicKey;
  bool? registered;
  String? refer;

  Migrate0To001Keys(this.uuid,
      {this.address,
      this.signPrivateKey,
      this.signPublicKey,
      this.dataPrivateKey,
      this.dataPublicKey,
      this.registered,
      this.refer});

  Migrate0To001Keys.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      this.uuid = json['uuid'];
      this.address = json['address'];
      this.signPrivateKey = json['signPrivateKey'];
      this.signPublicKey = json['signPublicKey'];
      this.dataPrivateKey = json['dataPrivateKey'];
      this.dataPublicKey = json['dataPublicKey'];
      this.registered = json['registered'];
      this.refer = json['refer'];
    }
  }

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'address': address,
        'signPrivateKey': signPrivateKey,
        'signPublicKey': signPublicKey,
        'dataPrivateKey': dataPrivateKey,
        'dataPublicKey': dataPublicKey,
        'registered': registered,
        'refer': refer
      };
}
