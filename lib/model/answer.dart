class Answer {
  final String id;
  final String topicId;
  final String questionId;
  final String answer;

  const Answer(
      {required this.id,
      required this.questionId,
      required this.topicId,
      required this.answer});

  Map<String, dynamic> toJson() =>
      {'topicId': topicId, 'questionId': questionId, 'answer': answer};

}
