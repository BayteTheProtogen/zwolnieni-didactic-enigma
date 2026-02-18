enum QuestionType { multipleChoice, scamOrNot }

class Question {
  final String id;
  final String text;
  final List<String> options;
  final int correctIndex;
  final String explanation;
  final QuestionType type;
  final String? assetPath; // For SMS/Email images or simulations

  Question({
    required this.id,
    required this.text,
    required this.options,
    required this.correctIndex,
    required this.explanation,
    this.type = QuestionType.multipleChoice,
    this.assetPath,
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
