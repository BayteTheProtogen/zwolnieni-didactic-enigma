import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/settings_provider.dart';
import '../widgets/mascot.dart';
import 'home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _step = 0;

  void _nextStep() {
    setState(() {
      _step++;
    });
  }

  Future<void> _finishOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seenOnboarding', true);
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const MascotWidget(state: MascotState.happy, size: 120),
              const SizedBox(height: 24),
              Expanded(
                child: _buildStepContent(settings),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _step < 2 ? _nextStep : _finishOnboarding,
                  child: Text(_step < 2 ? 'Dalej' : 'Zaczynamy!'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepContent(SettingsProvider settings) {
    switch (_step) {
      case 0:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Witaj w CyberGuide!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Pomogę Ci bezpiecznie poruszać się w cyfrowym świecie. Na początek dopasujmy aplikację do Twoich potrzeb.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ],
        );
      case 1:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Wielkość tekstu',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Slider(
              value: settings.fontSizeMultiplier,
              min: 0.8,
              max: 1.5,
              divisions: 7,
              label: '${(settings.fontSizeMultiplier * 100).toInt()}%',
              onChanged: (value) => settings.setFontSizeMultiplier(value),
            ),
            const SizedBox(height: 32),
            const Text(
              'Tryb wysokiego kontrastu',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SwitchListTile(
              title: const Text('Włącz wysoki kontrast', style: TextStyle(fontSize: 18)),
              value: settings.highContrast,
              onChanged: (value) => settings.setHighContrast(value),
            ),
          ],
        );
      case 2:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Sposób poruszania się',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            RadioListTile<bool>(
              title: const Text('Przesuwanie palcem (gesty)', style: TextStyle(fontSize: 18)),
              value: false,
              groupValue: settings.useScrollButtons,
              onChanged: (value) => settings.setUseScrollButtons(value!),
            ),
            RadioListTile<bool>(
              title: const Text('Przyciski Góra/Dół', style: TextStyle(fontSize: 18)),
              value: true,
              groupValue: settings.useScrollButtons,
              onChanged: (value) => settings.setUseScrollButtons(value!),
            ),
            const SizedBox(height: 32),
            SwitchListTile(
              title: const Text('Czytanie tekstu (Głos)', style: TextStyle(fontSize: 18)),
              value: settings.ttsEnabled,
              onChanged: (value) => settings.setTtsEnabled(value),
            ),
          ],
        );
      default:
        return Container();
    }
  }
}
