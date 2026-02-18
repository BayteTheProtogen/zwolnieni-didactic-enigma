import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameProvider with ChangeNotifier {
  int _xp = 0;
  int _streak = 0;
  DateTime? _lastActivityDate;
  Set<String> _completedLessonIds = {};

  int get xp => _xp;
  int get streak => _streak;
  Set<String> get completedLessonIds => _completedLessonIds;

  GameProvider() {
    _loadGameState();
  }

  Future<void> _loadGameState() async {
    final prefs = await SharedPreferences.getInstance();
    _xp = prefs.getInt('xp') ?? 0;
    _streak = prefs.getInt('streak') ?? 0;
    _completedLessonIds = (prefs.getStringList('completedLessons') ?? []).toSet();
    String? lastDateStr = prefs.getString('lastActivityDate');
    if (lastDateStr != null) {
      _lastActivityDate = DateTime.parse(lastDateStr);
    }
    _checkStreak();
    notifyListeners();
  }

  void _checkStreak() {
    if (_lastActivityDate == null) return;

    final now = DateTime.now();
    final difference = now.difference(_lastActivityDate!).inDays;

    if (difference > 1) {
      _streak = 0;
      _saveStreak();
    }
  }

  Future<void> completeLesson(String lessonId, int xpReward) async {
    _completedLessonIds.add(lessonId);
    _xp += xpReward;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('xp', _xp);
    await prefs.setStringList('completedLessons', _completedLessonIds.toList());

    // Update streak if it's a new day
    final now = DateTime.now();
    if (_lastActivityDate == null ||
        now.day != _lastActivityDate!.day ||
        now.month != _lastActivityDate!.month ||
        now.year != _lastActivityDate!.year) {
      _streak += 1;
      _lastActivityDate = now;
      await prefs.setInt('streak', _streak);
      await prefs.setString('lastActivityDate', now.toIso8601String());
    }

    notifyListeners();
  }

  Future<void> _saveStreak() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('streak', _streak);
  }
}
