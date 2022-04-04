class Answer {
  final String id;
  final String topicId;
  final String questionId;
  final String answer;
  final bool isCorrect;

  const Answer(
      {required this.id,
      required this.questionId,
      required this.topicId,
      required this.answer,
      required this.isCorrect});

  Map<String, dynamic> toJson() => {
        'topicId': topicId,
        'questionId': questionId,
        'answer': answer,
        'isCorrect': isCorrect
      };
}
