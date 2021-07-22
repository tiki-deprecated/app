import 'package:app/src/slices/api_company/model/api_company_model.dart';

import '../api_sender/model/api_sender_model.dart';

class ApiCompanyService {

  Future<Map<String, String>> getCompanyDataFromApi(String domain) {
    // TODO call api
  }

  void processEmailData(Map<String, dynamic> emailData) async {
    var companyData = await getCompanyDataFromApi(emailData['domain']);
    var companyModel = await createUpdateOrNewCompany(
        logo: companyData['logo'],
        securityScore: companyData['securityScore'],
        domain: companyData['domain']
    );
    var sender = createUpdateOrNewSender(
        name: null


    )
  }

  createOrUpdate(senderData) {}

}