/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class TikiApiModelRspPage {
  int? size;
  int? totalElements;
  int? totalPages;
  int? page;

  TikiApiModelRspPage(
      {this.size, this.totalElements, this.totalPages, this.page});

  TikiApiModelRspPage fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      this.size = json['size'];
      this.totalElements = json['totalElements'];
      this.totalPages = json['totalPages'];
      this.page = json['page'];
    }
    return this;
  }

  Map<String, dynamic> toJson() => {
        'size': size,
        'totalElements': totalElements,
        'totalPages': totalPages,
        'page': page
      };
}
