import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ustawienia'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text(
            'Wygląd i Dostępność',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text('Wielkość tekstu'),
          Slider(
            value: settings.fontSizeMultiplier,
            min: 0.8,
            max: 1.5,
            divisions: 7,
            onChanged: (value) => settings.setFontSizeMultiplier(value),
          ),
          SwitchListTile(
            title: const Text('Wysoki kontrast'),
            value: settings.highContrast,
            onChanged: (value) => settings.setHighContrast(value),
          ),
          SwitchListTile(
            title: const Text('Przyciski zamiast gestów'),
            value: settings.useScrollButtons,
            onChanged: (value) => settings.setUseScrollButtons(value),
          ),
          SwitchListTile(
            title: const Text('Czytanie tekstu (Głos)'),
            value: settings.ttsEnabled,
            onChanged: (value) => settings.setTtsEnabled(value),
          ),
        ],
      ),
    );
  }
}
