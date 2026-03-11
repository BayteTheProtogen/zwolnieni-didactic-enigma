import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../models/lesson.dart';
import '../widgets/mascot.dart';
import '../providers/game_provider.dart';
import '../providers/settings_provider.dart';
import '../theme/app_theme.dart';

class LessonScreen extends StatefulWidget {
  final Lesson lesson;

  const LessonScreen({super.key, required this.lesson});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  int _currentQuestionIndex = 0;
  int _attempts = 0;
  int _totalErrors = 0;
  final Set<int> _triedOptions = {};
  bool _isAnswered = false;
  bool _isCorrect = false;
  MascotState _mascotState = MascotState.thinking;
  final FlutterTts _flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _initTts();
  }

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }

  void _initTts() async {
    await _flutterTts.setLanguage("pl-PL");
    _speakQuestion();
  }

  void _speakQuestion() async {
    final settings = context.read<SettingsProvider>();
    if (settings.ttsEnabled) {
      final question = widget.lesson.questions[_currentQuestionIndex];
      String textToSpeak = '';
      if (question.title != null) {
        textToSpeak += '${question.title}. ';
      }
      textToSpeak += question.text;
      await _flutterTts.speak(textToSpeak);
    }
  }

  void _speakExplanation() async {
    final settings = context.read<SettingsProvider>();
    if (settings.ttsEnabled) {
      await _flutterTts.speak(widget.lesson.questions[_currentQuestionIndex].explanation);
    }
  }

  void _checkAnswer(int index) {
    if (_isAnswered || _triedOptions.contains(index)) return;
    final question = widget.lesson.questions[_currentQuestionIndex];
    if (question.type == QuestionType.information) return;

    setState(() {
      _triedOptions.add(index);
      _attempts++;

      if (index == question.correctIndex) {
        _isCorrect = true;
        _isAnswered = true;
        _mascotState = MascotState.happy;
        _speakExplanation();
      } else {
        _totalErrors++;
        if (_attempts >= 2) {
          _isCorrect = false;
          _isAnswered = true;
          _mascotState = MascotState.sad;
          _speakExplanation();
        } else {
          _mascotState = MascotState.thinking;
        }
      }
    });
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < widget.lesson.questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _attempts = 0;
        _triedOptions.clear();
        _isAnswered = false;
        _isCorrect = false;
        _mascotState = widget.lesson.questions[_currentQuestionIndex].type == QuestionType.information
            ? MascotState.happy
            : MascotState.thinking;
      });
      _speakQuestion();
    } else {
      // Calculate reward based on performance
      int reward = widget.lesson.xpReward;
      if (_totalErrors == 0) {
        // Perfect score
      } else if (_totalErrors <= 2) {
        reward = (reward * 0.7).toInt();
      } else {
        reward = (reward * 0.4).toInt();
      }

      context.read<GameProvider>().completeLesson(widget.lesson.id, reward);
      _showFinishDialog(reward);
    }
  }

  void _showFinishDialog(int actualReward) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: 'Finish',
      pageBuilder: (context, anim1, anim2) => Scaffold(
        backgroundColor: AppTheme.darkBlue.withOpacity(0.9),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const MascotWidget(state: MascotState.excited, size: 150, color: Colors.white)
                  .animate()
                  .scale(duration: 600.ms, curve: Curves.elasticOut)
                  .shimmer(delay: 1.seconds, color: Colors.blue.shade100),
              const SizedBox(height: 32),
              const Text(
                'GRATULACJE!',
                style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
              ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.5, end: 0),
              const SizedBox(height: 16),
              Text(
                'Ukończyłeś lekcję:\n${widget.lesson.title}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ).animate().fadeIn(delay: 500.ms),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Text(
                  '+ $actualReward XP',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ).animate().fadeIn(delay: 800.ms).scale(),
              const SizedBox(height: 48),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppTheme.darkBlue,
                  padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 20),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: const Text('WRÓĆ DO MAPY'),
              ).animate().fadeIn(delay: 1.seconds),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.lesson.questions[_currentQuestionIndex];
    final progress = (_currentQuestionIndex) / widget.lesson.questions.length;

    return Scaffold(
      appBar: AppBar(
        title: LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.white24,
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Row(
              children: [
                Hero(
                  tag: 'mascot',
                  child: MascotWidget(state: _mascotState, size: 80),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      question.type == QuestionType.information
                          ? 'Dobra rada:'
                          : (_isAnswered
                              ? (_isCorrect ? 'Świetnie!' : 'Nie martw się, uczymy się dalej.')
                              : (_attempts == 1 ? 'Spróbuj jeszcze raz!' : 'Jak myślisz?')),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ).animate().fadeIn().slideX(),
            const SizedBox(height: 24),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(scale: animation, child: child),
                  );
                },
                child: KeyedSubtree(
                  key: ValueKey(_currentQuestionIndex),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (question.title != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            question.title!,
                            style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ).animate().fadeIn(delay: 100.ms),
                      if (question.type != QuestionType.trueFalse && question.type != QuestionType.simulation) ...[
                        Text(
                          question.text,
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ).animate().fadeIn(delay: 200.ms),
                        const SizedBox(height: 24),
                      ],
                      if (question.type == QuestionType.simulation)
                        _buildSimulationUI(question)
                      else if (question.type == QuestionType.trueFalse)
                        _buildTrueFalseUI(question)
                      else if (question.type != QuestionType.information)
                        ...List.generate(question.options.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: _buildOptionButton(index, question),
                          ).animate().fadeIn(delay: (400 + index * 100).ms).slideY(begin: 0.1, end: 0);
                        })
                      else
                        const Expanded(
                          child: Center(
                            child: Icon(Icons.lightbulb_outline, size: 100, color: Colors.amber),
                          ),
                        ).animate().fadeIn(delay: 400.ms).scale(),
                    ],
                  ),
                ),
              ),
            ),
            if (_isAnswered || question.type == QuestionType.information)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: question.type == QuestionType.information
                      ? Colors.blue[100]
                      : (_isCorrect ? Colors.green[100] : Colors.red[100]),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    if (question.explanation.isNotEmpty)
                      Text(
                        question.explanation,
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    if (question.explanation.isNotEmpty) const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: question.type == QuestionType.information
                              ? AppTheme.darkBlue
                              : (_isCorrect ? Colors.green : Colors.red),
                        ),
                        onPressed: _nextQuestion,
                        child: const Text('Dalej'),
                      ),
                    ),
                  ],
                ),
              ).animate().slideY(begin: 1, end: 0),
          ],
        ),
      ),
    );
  }

  Widget _buildSimulationUI(Question question) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              const CircleAvatar(child: Icon(Icons.person)),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  question.text,
                  style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                ),
              ),
            ],
          ),
        ).animate().slideX(begin: -0.2, end: 0).fadeIn(),
        const SizedBox(height: 24),
        ...List.generate(question.options.length, (index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: _buildOptionButton(index, question),
          ).animate().fadeIn(delay: (400 + index * 100).ms);
        }),
      ],
    );
  }

  Widget _buildTrueFalseUI(Question question) {
    return Column(
      children: [
        Text(
          question.text,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ).animate().fadeIn(),
        const SizedBox(height: 40),
        Row(
          children: [
            _buildTrueFalseButton(0, 'TAK', question),
            const SizedBox(width: 16),
            _buildTrueFalseButton(1, 'NIE', question),
          ],
        ).animate().fadeIn(delay: 300.ms).scale(),
      ],
    );
  }

  Widget _buildTrueFalseButton(int index, String label, Question question) {
    final bool isTried = _triedOptions.contains(index);
    final bool isCorrectAnswer = index == question.correctIndex;

    Color? backgroundColor;
    Color? foregroundColor;
    BorderSide borderSide = BorderSide.none;

    if (_isAnswered) {
      if (isCorrectAnswer) {
        backgroundColor = Colors.green;
        foregroundColor = Colors.white;
      } else if (isTried) {
        backgroundColor = Colors.red;
        foregroundColor = Colors.white;
      }
    } else if (isTried) {
      backgroundColor = Colors.red.withOpacity(0.8);
      foregroundColor = Colors.white;
      borderSide = const BorderSide(color: Colors.red, width: 2);
    }

    return Expanded(
      child: SizedBox(
        height: 100,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            side: borderSide,
          ),
          onPressed: (_isAnswered || isTried) ? null : () => _checkAnswer(index),
          child: Text(label, style: const TextStyle(fontSize: 24)),
        ),
      ),
    );
  }

  Widget _buildOptionButton(int index, Question question) {
    final bool isTried = _triedOptions.contains(index);
    final bool isCorrectAnswer = index == question.correctIndex;

    Color? backgroundColor;
    Color? foregroundColor;
    BorderSide borderSide = BorderSide.none;

    if (_isAnswered) {
      if (isCorrectAnswer) {
        backgroundColor = Colors.green;
        foregroundColor = Colors.white;
      } else if (isTried) {
        backgroundColor = Colors.red;
        foregroundColor = Colors.white;
      }
    } else if (isTried) {
      // Incorrect attempt
      backgroundColor = Colors.red.withOpacity(0.8);
      foregroundColor = Colors.white;
      borderSide = const BorderSide(color: Colors.red, width: 2);
    }

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        side: borderSide,
      ),
      onPressed: (_isAnswered || isTried) ? null : () => _checkAnswer(index),
      child: Text(question.options[index]),
    );
  }
}
