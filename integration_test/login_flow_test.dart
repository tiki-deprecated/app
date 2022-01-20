import 'package:app/src/slices/api_user/model/api_user_model_otp.dart';
import 'package:app/src/slices/intro_screen/ui/intro_screen_view_skip_button.dart';
import 'package:app/src/slices/keys_modal/ui/keys_modal_layout.dart';
import 'package:app/src/slices/login_screen_email/ui/login_screen_email_view_button.dart';
import 'package:app/src/slices/login_screen_email/ui/login_screen_email_view_input.dart';
import 'package:app/src/slices/login_screen_inbox/ui/login_screen_inbox_layout.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:app/main.dart' as app;
import 'package:integration_test/integration_test.dart';

void main() {
  const String TESTER_REQ_EMAIL = 'testreq@test.com';
  const String TESTER_EMAIL = 'test@test.com';
  const String TESTER_TOKEN = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJFUzI1NiJ9.eyJpc3MiOiJjb20ubXl0aWtpLmJvdW5jZXIiLCJleHAiOjE2NDIxMzU5MzEsImlhdCI6MTY0MjEzMjMzMX0.xdt94pGQwEHJZXeQlbAayWJ9ZGAX3xALi17HiPN2ret_V4fdpB3HgMpquiijswcmMYM5eyOhQ-Ak2k3eOQ5axQ';


  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized()
  as IntegrationTestWidgetsFlutterBinding;

  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  group('login flow', () {

    /// Regular first-time login flow
    testWidgets("send otp and login", (WidgetTester tester) async {
      await app.main();
      await tester.pumpAndSettle(Duration(seconds: 2));
      final Finder skipBtn = find.byType(IntroScreenSkipButton);
      expect(skipBtn, findsOneWidget);
      await tester.tap(skipBtn);
      await tester.pumpAndSettle(Duration(seconds: 2));
      final Finder inputEmail = find.byType(LoginScreenEmailViewInput);
      expect(inputEmail, findsOneWidget);
      await tester.enterText(inputEmail, TESTER_REQ_EMAIL);
      await tester.pumpAndSettle(Duration(seconds: 2));
      final Finder submitEmailBtn = find.byType(LoginScreenEmailViewButton);
      expect(submitEmailBtn, findsOneWidget);
      await tester.tap(submitEmailBtn);
      await tester.pumpAndSettle(Duration(seconds: 2));
      final Finder emailInbox = find.byType(LoginScreenInboxLayout);
      expect(emailInbox, findsOneWidget);
      app.loginFlowService.model.user!.token!.bearer = TESTER_TOKEN;
      app.loginFlowService.model.user!.token!.expires =
          DateTime.now().add(Duration(seconds: 3600));
      app.loginFlowService.model.user!.user!.email = TESTER_EMAIL;
      app.loginFlowService.setCreatingKeys();
      await tester.pumpAndSettle(Duration(seconds: 2));
      final Finder keysModal = find.byType(KeysModalLayout);
      expect(keysModal, findsOneWidget);
    });

  });
}