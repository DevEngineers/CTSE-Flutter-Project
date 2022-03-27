import 'package:ctse_flutter_project/model/question.dart';
import 'package:flutter/cupertino.dart';

import '../services/QuestionService.dart';

class QuestionProvider extends ChangeNotifier {
  late QuestionService _questionService;
  final Set<Question> _questions = {};

  Set<Question> get questions => _questions;

  QuestionProvider() {
    _questionService = const QuestionService();
    getQuestions();
  }

  void getQuestions() async {
    final questions = await _questionService.getQuestions();
    _questions.addAll(questions!);
    notifyListeners();
  }

  Set<Question> getQuestionsByTopic(String topicId) {
    Iterable<Question> questions = _questions
        .where((element) => element.topicId == topicId)
        .toSet()
        .toList();
    return questions.toSet();
  }
}
