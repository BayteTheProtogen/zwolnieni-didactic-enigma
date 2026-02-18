import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../providers/game_provider.dart';
import '../providers/settings_provider.dart';
import '../widgets/mascot.dart';
import '../content/lessons_data.dart';
import '../theme/app_theme.dart';
import '../models/lesson.dart';
import 'lesson_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scroll(double offset) {
    _scrollController.animateTo(
      _scrollController.offset + offset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final game = context.watch<GameProvider>();
    final settings = context.watch<SettingsProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('CyberGuide'),
        actions: [
          _buildStreakWidget(game.streak),
          _buildXpWidget(game.xp),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const SettingsScreen()),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            itemCount: lessonsData.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return const Center(
                  child: Hero(
                    tag: 'mascot',
                    child: MascotWidget(state: MascotState.happy, size: 120),
                  ),
                );
              }
              final lesson = lessonsData[index - 1];
              return _LessonNode(
                lesson: lesson,
                isLeft: (index - 1) % 2 == 0,
                isCompleted: game.completedLessonIds.contains(lesson.id),
              );
            },
          ),
          if (settings.useScrollButtons) _buildScrollButtons(context),
        ],
      ),
    );
  }

  Widget _buildScrollButtons(BuildContext context) {
    return Positioned(
      right: 20,
      bottom: 20,
      child: Column(
        children: [
          FloatingActionButton(
            heroTag: 'scrollUp',
            mini: true,
            onPressed: () => _scroll(-200),
            child: const Icon(Icons.arrow_upward),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            heroTag: 'scrollDown',
            mini: true,
            onPressed: () => _scroll(200),
            child: const Icon(Icons.arrow_downward),
          ),
        ],
      ),
    );
  }

  Widget _buildStreakWidget(int streak) {
    return Row(
      children: [
        const Icon(Icons.local_fire_department, color: Colors.orange),
        Text('$streak', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildXpWidget(int xp) {
    return Row(
      children: [
        const Icon(Icons.star, color: Colors.yellow),
        Text('$xp', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
        const SizedBox(width: 8),
      ],
    );
  }
}

class _LessonNode extends StatelessWidget {
  final Lesson lesson;
  final bool isLeft;
  final bool isCompleted;

  const _LessonNode({
    required this.lesson,
    required this.isLeft,
    this.isCompleted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      alignment: isLeft ? Alignment.centerLeft : Alignment.centerRight,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => LessonScreen(lesson: lesson),
                ),
              );
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (isCompleted)
                  const SizedBox(
                    width: 120,
                    height: 120,
                    child: CircularProgressIndicator(
                      value: 1.0,
                      strokeWidth: 8,
                      color: Colors.green,
                    ),
                  ).animate().fadeIn(),
                Hero(
                  tag: 'lesson-${lesson.id}',
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: isCompleted ? Colors.green : AppTheme.darkBlue,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Icon(
                      isCompleted ? Icons.check : Icons.menu_book,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            lesson.category,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ).animate().fadeIn(),
          Text(lesson.title).animate().fadeIn(),
        ],
      ),
    );
  }
}
