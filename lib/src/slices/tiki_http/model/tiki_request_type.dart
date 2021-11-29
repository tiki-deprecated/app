enum TikiRequestType { GET, POST, PUT, DELETE, HEAD }

extension TikiRequestTypeExt on TikiRequestType {
  String? get value {
    switch (this) {
      case TikiRequestType.GET:
        return "GET";
      case TikiRequestType.POST:
        return "POST";
      case TikiRequestType.PUT:
        return "PUT";
      case TikiRequestType.DELETE:
        return "DELETE";
      case TikiRequestType.HEAD:
        return "HEAD";
      default:
        return null;
    }
  }
}
