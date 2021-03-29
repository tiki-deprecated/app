/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

class UtilityAPIRspPage {
  int size;
  int totalElements;
  int totalPages;
  int page;

  UtilityAPIRspPage(
      {this.size, this.totalElements, this.totalPages, this.page});

  UtilityAPIRspPage.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      this.size = json['size'];
      this.totalElements = json['totalElements'];
      this.totalPages = json['totalPages'];
      this.page = json['page'];
    }
  }

  Map<String, dynamic> toJson() => {
        'size': size,
        'totalElements': totalElements,
        'totalPages': totalPages,
        'page': page
      };
}
