import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'theme/app_theme.dart';
import 'providers/settings_provider.dart';
import 'providers/game_provider.dart';
import 'screens/onboarding_screen.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final prefs = await SharedPreferences.getInstance();
  final bool seenOnboarding = prefs.getBool('seenOnboarding') ?? false;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        ChangeNotifierProvider(create: (_) => GameProvider()),
      ],
      child: CyberGuideApp(seenOnboarding: seenOnboarding),
    ),
  );
}

class CyberGuideApp extends StatelessWidget {
  final bool seenOnboarding;

  const CyberGuideApp({super.key, required this.seenOnboarding});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();

    return MaterialApp(
      title: 'CyberGuide',
      debugShowCheckedModeBanner: false,
      theme: settings.highContrast ? AppTheme.highContrastTheme : AppTheme.lightTheme,
      home: seenOnboarding ? const HomeScreen() : const OnboardingScreen(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(settings.fontSizeMultiplier),
          ),
          child: child!,
        );
      },
    );
  }
}
