import 'package:flutter_test/flutter_test.dart';
import 'package:cyberguide/main.dart';
import 'package:cyberguide/providers/settings_provider.dart';
import 'package:cyberguide/providers/game_provider.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('CyberGuideApp test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => SettingsProvider()),
          ChangeNotifierProvider(create: (_) => GameProvider()),
        ],
        child: const CyberGuideApp(seenOnboarding: false),
      ),
    );

    // Verify that onboarding screen is shown initially
    expect(find.text('Witaj w CyberGuide!'), findsOneWidget);

    // We need to stop the animations before finishing the test to avoid "Timer still pending"
  });
}
