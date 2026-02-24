enum QuestionType { multipleChoice, scamOrNot, information }

class Question {
  final String id;
  final String text;
  final List<String> options;
  final int? correctIndex;
  final String explanation;
  final QuestionType type;
  final String? assetPath; // For SMS/Email images or simulations
  final String? title; // Optional title for info screens

  Question({
    required this.id,
    required this.text,
    this.options = const [],
    this.correctIndex,
    this.explanation = '',
    this.type = QuestionType.multipleChoice,
    this.assetPath,
    this.title,
  });
}

class Lesson {
  final String id;
  final String title;
  final String category;
  final List<Question> questions;
  final int xpReward;

  Lesson({
    required this.id,
    required this.title,
    required this.category,
    required this.questions,
    this.xpReward = 10,
  });
}
