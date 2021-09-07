enum DataBkgProviderType { email }

extension DataBkgProviderTypeExtension on DataBkgProviderType {
  String? get value {
    switch (this) {
      case DataBkgProviderType.email:
        return 'email';
    }
  }
}
