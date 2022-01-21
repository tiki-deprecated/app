import 'package:app/src/slices/api_user/model/api_user_model.dart';
import 'package:app/src/slices/api_user/model/api_user_model_current.dart';
import 'package:app/src/slices/api_user/model/api_user_model_token.dart';
import 'package:app/src/slices/api_user/model/api_user_model_user.dart';
import 'package:app/src/slices/home_screen/ui/home_screen_layout.dart';
import 'package:app/src/slices/intro_screen/ui/intro_screen_view_skip_button.dart';
import 'package:app/src/slices/keys_modal/ui/keys_modal_layout.dart';
import 'package:app/src/slices/keys_modal/ui/keys_modal_view_new_account_create.dart';
import 'package:app/src/slices/keys_modal/ui/keys_modal_view_new_account_recover.dart';
import 'package:app/src/slices/keys_modal/ui/keys_modal_view_passphrase.dart';
import 'package:app/src/slices/keys_modal/ui/keys_modal_view_passphrase_error.dart';
import 'package:app/src/slices/keys_modal/ui/keys_modal_view_pincode_error.dart';
import 'package:app/src/slices/login_screen_email/ui/login_screen_email_view_button.dart';
import 'package:app/src/slices/login_screen_email/ui/login_screen_email_view_input.dart';
import 'package:app/src/slices/login_screen_inbox/ui/login_screen_inbox_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:app/main.dart' as app;
import 'package:integration_test/integration_test.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

/// E-mail used for otp send test.
const String TESTER_REQ_EMAIL = 'testreq@test.com';

/// E-mail used for keys creation and login.
/// Must be different from [TESTER_REQ_EMAIL] to avoid token resets during test.
const String TESTER_EMAIL = 'test@test.com';

/// Access token for Api. Must be manually set before each test.
const String TESTER_TOKEN = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJFUzI1NiJ9.eyJpc3MiOiJjb20ubXl0aWtpLmJvdW5jZXIiLCJleHAiOjE2NDIxMzU5MzEsImlhdCI6MTY0MjEzMjMzMX0.xdt94pGQwEHJZXeQlbAayWJ9ZGAX3xALi17HiPN2ret_V4fdpB3HgMpquiijswcmMYM5eyOhQ-Ak2k3eOQ5axQ';

const String CORRECT_PINCODE = '123456';
const String CYCLE_PINCODE = '000000';
const String WRONG_PINCODE = '999999';

const String CORRECT_PASSPHRASE = 'test12345';
const String CYCLE_PASSPHRASE = 'test11111';
const String WRONG_PASSPHRASE = 'test0000000000';
const String SHORT_PASSPHRASE = 'test';

void main() {

  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized()
  as IntegrationTestWidgetsFlutterBinding;

  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  /// Send otp email test to [TESTER_REQ_EMAIL]
  testWidgets("send otp email", (WidgetTester tester) async {
    await app.main();
    await tester.pumpAndSettle(Duration(seconds: 2));
    final Finder skipBtn = find.byType(IntroScreenSkipButton);
    if (skipBtn
        .evaluate()
        .isNotEmpty) {
      expect(skipBtn, findsOneWidget);
      await tester.tap(skipBtn);
    }
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
  });

  /// Login flow with keys creation.
  /// Before running this test update [TESTER_TOKEN].
  testWidgets("create keys and login", (WidgetTester tester) async {
    await startAppAndSetCreatingKeys(tester);
    await tester.pumpAndSettle(Duration(seconds: 2));
    final Finder keysModal = find.byType(KeysModalLayout);
    expect(keysModal, findsOneWidget);
    final Finder createButton = find.byType(KeysModalViewNewAccountCreate);
    expect(createButton, findsOneWidget);
    await tester.tap(createButton);
    await tester.pumpAndSettle(Duration(seconds: 2));
    final Finder pinCodeInput = find.byType(PinCodeTextField);
    expect(pinCodeInput, findsOneWidget);
    await tester.enterText(pinCodeInput, CORRECT_PINCODE);
    await tester.pumpAndSettle(Duration(seconds: 2));
    final Finder passphraseInput = find.byType(TextField);
    await tester.enterText(passphraseInput, CORRECT_PASSPHRASE);
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle(Duration(seconds: 30));
    final Finder homeScreen = find.byType(HomeScreenLayout);
    expect(homeScreen, findsOneWidget);
    await logout(tester);
  });

  /// Login flow with wrong passphrase length.
  /// Before running this test update [TESTER_TOKEN].
  testWidgets("wrong passphrase length", (WidgetTester tester) async {
    await startAppAndSetCreatingKeys(tester);
    await tester.pumpAndSettle(Duration(seconds: 2));
    final Finder keysModal = find.byType(KeysModalLayout);
    expect(keysModal, findsOneWidget);
    final Finder createButton = find.byType(KeysModalViewNewAccountCreate);
    expect(createButton, findsOneWidget);
    await tester.tap(createButton);
    await tester.pumpAndSettle(Duration(seconds: 2));
    final Finder pinCodeInput = find.byType(PinCodeTextField);
    expect(pinCodeInput, findsOneWidget);
    await tester.enterText(pinCodeInput, CORRECT_PINCODE);
    await tester.pumpAndSettle(Duration(seconds: 2));
    final Finder passphraseInput = find.byType(TextField);
    await tester.enterText(passphraseInput, SHORT_PASSPHRASE);
    await tester.testTextInput.receiveAction(TextInputAction.done);
    final Finder passError = find.byType(KeysModalViewPassphraseError);
    expect(passError, findsOneWidget);
    await logout(tester);
  });

  /// Login flow with keys recovery by pincode and passphrase.
  /// Before running this test update [TESTER_TOKEN].
  testWidgets("recover keys and login", (WidgetTester tester) async {
    await startAppAndSetCreatingKeys(tester);
    await tester.pumpAndSettle(Duration(seconds: 2));
    final Finder keysModal = find.byType(KeysModalLayout);
    expect(keysModal, findsOneWidget);
    final Finder recoverButton = find.byType(KeysModalViewNewAccountRecover);
    expect(recoverButton, findsOneWidget);
    await tester.tap(recoverButton);
    await tester.pumpAndSettle(Duration(seconds: 2));
    final Finder pinCodeInput = find.byType(PinCodeTextField);
    expect(pinCodeInput, findsOneWidget);
    await tester.enterText(pinCodeInput, CORRECT_PINCODE);
    await tester.pumpAndSettle(Duration(seconds: 2));
    final Finder passphraseInput = find.byType(TextField);
    await tester.enterText(passphraseInput, CORRECT_PASSPHRASE);
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle(Duration(seconds: 30));
    expect(pinCodeInput, findsOneWidget);
    await tester.enterText(pinCodeInput, CYCLE_PINCODE);
    await tester.pumpAndSettle(Duration(seconds: 2));
    await tester.enterText(passphraseInput, CYCLE_PASSPHRASE);
    await tester.pumpAndSettle(Duration(seconds: 30));
    final Finder homeScreen = find.byType(HomeScreenLayout);
    expect(homeScreen, findsOneWidget);
    await logout(tester);
  });

  /// Keys recovery with wrong pincode
  /// Before running this test update [TESTER_TOKEN].
  testWidgets("try to recover keys with wrong pincode", (WidgetTester tester) async {
    await startAppAndSetCreatingKeys(tester);
    await tester.pumpAndSettle(Duration(seconds: 2));
    final Finder keysModal = find.byType(KeysModalLayout);
    expect(keysModal, findsOneWidget);
    final Finder recoverButton = find.byType(KeysModalViewNewAccountRecover);
    expect(recoverButton, findsOneWidget);
    await tester.tap(recoverButton);
    await tester.pumpAndSettle(Duration(seconds: 2));
    final Finder pinCodeInput = find.byType(PinCodeTextField);
    expect(pinCodeInput, findsOneWidget);
    await tester.enterText(pinCodeInput, WRONG_PINCODE);
    await tester.pumpAndSettle(Duration(seconds: 2));
    final Finder passphraseInput = find.byType(TextField);
    await tester.enterText(passphraseInput, CORRECT_PASSPHRASE);
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle(Duration(seconds: 30));
    expect(pinCodeInput, findsOneWidget);
    final Finder pinCodeError = find.byType(KeysModalViewPincodeError);
    expect(pinCodeError, findsOneWidget);
    await logout(tester);
  });

  /// Keys recovery with wrong passphrase
  /// Before running this test update [TESTER_TOKEN].
  testWidgets("try to recover keys with wrong passphrase", (WidgetTester tester) async {
    await startAppAndSetCreatingKeys(tester);
    await tester.pumpAndSettle(Duration(seconds: 2));
    final Finder keysModal = find.byType(KeysModalLayout);
    expect(keysModal, findsOneWidget);
    final Finder recoverButton = find.byType(KeysModalViewNewAccountRecover);
    expect(recoverButton, findsOneWidget);
    await tester.tap(recoverButton);
    await tester.pumpAndSettle(Duration(seconds: 2));
    final Finder pinCodeInput = find.byType(PinCodeTextField);
    expect(pinCodeInput, findsOneWidget);
    await tester.enterText(pinCodeInput, WRONG_PINCODE);
    await tester.pumpAndSettle(Duration(seconds: 2));
    final Finder passphraseInput = find.byType(TextField);
    await tester.enterText(passphraseInput, WRONG_PASSPHRASE);
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle(Duration(seconds: 30));
    expect(pinCodeInput, findsOneWidget);
    final Finder pinCodeError = find.byType(KeysModalViewPassphraseError);
    expect(pinCodeError, findsOneWidget);
    await logout(tester);
  });

  /// Login flow with keys recovery - repeated pincode.
  /// Before running this test update [TESTER_TOKEN].
  testWidgets("recover keys and repeat pincode", (WidgetTester tester) async {
    await startAppAndSetCreatingKeys(tester);
    await tester.pumpAndSettle(Duration(seconds: 2));
    final Finder keysModal = find.byType(KeysModalLayout);
    expect(keysModal, findsOneWidget);
    final Finder recoverButton = find.byType(KeysModalViewNewAccountRecover);
    expect(recoverButton, findsOneWidget);
    await tester.tap(recoverButton);
    await tester.pumpAndSettle(Duration(seconds: 2));
    final Finder pinCodeInput = find.byType(PinCodeTextField);
    expect(pinCodeInput, findsOneWidget);
    await tester.enterText(pinCodeInput, CORRECT_PINCODE);
    await tester.pumpAndSettle(Duration(seconds: 2));
    final Finder passphraseInput = find.byType(TextField);
    await tester.enterText(passphraseInput, CORRECT_PASSPHRASE);
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle(Duration(seconds: 30));
    expect(pinCodeInput, findsOneWidget);
    await tester.enterText(pinCodeInput, CORRECT_PINCODE);
    await tester.pumpAndSettle(Duration(seconds: 2));
    await tester.enterText(passphraseInput, CYCLE_PASSPHRASE);
    await tester.pumpAndSettle(Duration(seconds: 30));
    expect(pinCodeInput, findsOneWidget);
    final Finder pinCodeError = find.byType(KeysModalViewPincodeError);
    expect(pinCodeError, findsOneWidget);
    await logout(tester);
  });

  /// Login flow with keys recovery - repeated passphrase.
  /// Before running this test update [TESTER_TOKEN].
  testWidgets("recover keys and repeat passphrase", (WidgetTester tester) async {
    await startAppAndSetCreatingKeys(tester);
    await tester.pumpAndSettle(Duration(seconds: 2));
    final Finder keysModal = find.byType(KeysModalLayout);
    expect(keysModal, findsOneWidget);
    final Finder recoverButton = find.byType(KeysModalViewNewAccountRecover);
    expect(recoverButton, findsOneWidget);
    await tester.tap(recoverButton);
    await tester.pumpAndSettle(Duration(seconds: 2));
    final Finder pinCodeInput = find.byType(PinCodeTextField);
    expect(pinCodeInput, findsOneWidget);
    await tester.enterText(pinCodeInput, CORRECT_PINCODE);
    await tester.pumpAndSettle(Duration(seconds: 2));
    final Finder passphraseInput = find.byType(TextField);
    await tester.enterText(passphraseInput, CORRECT_PASSPHRASE);
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle(Duration(seconds: 30));
    expect(pinCodeInput, findsOneWidget);
    await tester.enterText(pinCodeInput, CYCLE_PINCODE);
    await tester.pumpAndSettle(Duration(seconds: 2));
    await tester.enterText(passphraseInput, CORRECT_PASSPHRASE);
    await tester.pumpAndSettle(Duration(seconds: 30));
    expect(pinCodeInput, findsOneWidget);
    final Finder pinCodeError = find.byType(KeysModalViewPassphraseError);
    expect(pinCodeError, findsOneWidget);
    await logout(tester);
  });


}

Future<void> logout(WidgetTester tester) async {
  await app.loginFlowService.setLoggedOut();
  await tester.pumpAndSettle(Duration(seconds: 2));
  final Finder inputEmail = find.byType(LoginScreenEmailViewInput);
  expect(inputEmail, findsOneWidget);
}

Future<void> startAppAndSetCreatingKeys(WidgetTester tester) async {
  await app.main();
  await tester.pumpAndSettle(Duration(seconds: 2));
  app.loginFlowService.model.user = ApiUserModel();
  app.loginFlowService.model.user!.current =
      ApiUserModelCurrent(email: TESTER_EMAIL);
  app.loginFlowService.model.user!.token = ApiUserModelToken(
      bearer: TESTER_TOKEN,
      expires: DateTime.now().add(Duration(seconds: 3600)));
  app.loginFlowService.model.user!.user =
      ApiUserModelUser(email: TESTER_EMAIL);
  app.loginFlowService.setCreatingKeys();
}