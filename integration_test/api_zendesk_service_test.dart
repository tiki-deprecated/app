import 'dart:io';

import 'package:app/src/slices/api_zendesk/api_zendesk_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:googleapis/servicecontrol/v2.dart';
import 'package:integration_test/integration_test.dart';

import 'package:app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("test Zendesk get Categories", (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    ApiZendeskService apiZendeskService = ApiZendeskService();
    var categories = await apiZendeskService.getZendeskCategories();
    expect(categories.length > 0, true);
  });

}