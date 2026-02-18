import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  double _fontSizeMultiplier = 1.0;
  bool _highContrast = false;
  bool _useScrollButtons = false;
  bool _ttsEnabled = false;

  double get fontSizeMultiplier => _fontSizeMultiplier;
  bool get highContrast => _highContrast;
  bool get useScrollButtons => _useScrollButtons;
  bool get ttsEnabled => _ttsEnabled;

  SettingsProvider() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _fontSizeMultiplier = prefs.getDouble('fontSizeMultiplier') ?? 1.0;
    _highContrast = prefs.getBool('highContrast') ?? false;
    _useScrollButtons = prefs.getBool('useScrollButtons') ?? false;
    _ttsEnabled = prefs.getBool('ttsEnabled') ?? false;
    notifyListeners();
  }

  Future<void> setFontSizeMultiplier(double value) async {
    _fontSizeMultiplier = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('fontSizeMultiplier', value);
    notifyListeners();
  }

  Future<void> setHighContrast(bool value) async {
    _highContrast = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('highContrast', value);
    notifyListeners();
  }

  Future<void> setUseScrollButtons(bool value) async {
    _useScrollButtons = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('useScrollButtons', value);
    notifyListeners();
  }

  Future<void> setTtsEnabled(bool value) async {
    _ttsEnabled = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('ttsEnabled', value);
    notifyListeners();
  }
}
