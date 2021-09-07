import 'package:app/src/slices/data_bkg/model/data_bkg_provider_name.dart';
import 'package:app/src/slices/data_bkg/model/data_bkg_provider_type.dart';

class DataBkgSvProviderFactory {
  final DataBkgProviderName providerName;
  final DataBkgProviderType providerType;

  DataBkgSvProviderFactory(this.providerName, this.providerType);
}
