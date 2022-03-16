class Question {
  final String id;
  final String question;
  final List<String> answers;
  final String correctAnswer;
  const Question(
      {required this.id,
      required this.question,
      required this.answers,
      required this.correctAnswer});
}
