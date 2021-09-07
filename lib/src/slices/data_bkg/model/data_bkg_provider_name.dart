enum DataBkgProviderName { google, microsoft }

extension DataBkgProviderNameExtension on DataBkgProviderName {
  String? get value {
    switch (this) {
      case DataBkgProviderName.google:
        return 'Google';
      case DataBkgProviderName.microsoft:
        return 'Microsoft';
    }
  }
}
