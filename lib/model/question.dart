class Question {
  final String id;
  final String topicId;
  final String question;
  final List<dynamic> answers;
  final String correctAnswer;

  const Question({
    required this.id,
    required this.topicId,
    required this.question,
    required this.answers,
    required this.correctAnswer,
  });
}
