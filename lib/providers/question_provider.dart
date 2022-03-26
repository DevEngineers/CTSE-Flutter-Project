import 'package:ctse_flutter_project/model/question.dart';
import 'package:flutter/cupertino.dart';

import '../services/QuestionService.dart';

class QuestionProvider extends ChangeNotifier {
  late QuestionServie _questionServie;
  final Set<Question> _questions = {};

  Set<Question> get questions => _questions;

  QuestionProvider() {
    _questionServie = const QuestionServie();
    getQuestions();
  }

  void getQuestions() async {
    final questions = await _questionServie.getQuestions();
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
