import 'package:app/src/slices/app/app_service.dart';
import 'package:app/src/slices/intro_screen/ui/intro_screen_layout.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Test IntroScreen home route.', (WidgetTester tester) async {
    AppService appService = AppService();
    await tester.pumpWidget(appService.getUI());
    Finder findIntroScreen = find.byWidget(IntroScreen());
    expect(findIntroScreen, findsOneWidget);
  });
}
