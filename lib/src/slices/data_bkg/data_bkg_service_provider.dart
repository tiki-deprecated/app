import 'data_bkg_sv_email_prov_gmail.dart';
import 'data_bkg_sv_email_prov_microsoft.dart';
import 'model/data_bkg_provider_name.dart';
import 'model/data_bkg_provider_type.dart';

abstract class DataBkgServiceProvAbstract {
  factory DataBkgServiceProvAbstract(
      DataBkgProviderName providerName, DataBkgProviderType providerType) {
    switch (providerName) {
      case DataBkgProviderName.google:
        if (providerType == DataBkgProviderType.email) {
          return DataBkgSvEmailProvGmail();
        }
        break;
      case DataBkgProviderName.microsoft:
        if (providerType == DataBkgProviderType.email) {
          return DataBkgSvEmailProvMicrosoft();
        }
        break;
    }
    throw Exception("invalid provider name or provider type.");
  }

  logIn();

  logOut();

  getAccount();
}
