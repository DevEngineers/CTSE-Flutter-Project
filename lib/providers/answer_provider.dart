import 'package:ctse_flutter_project/model/answer.dart';
import 'package:ctse_flutter_project/services/AnswerService.dart';
import 'package:flutter/cupertino.dart';

class AnwserProvider extends ChangeNotifier {
  late AnswerService _answerServie;
  final List<Answer> _answers = [];

  List<Answer> get answers => _answers;

  AnwserProvider() {
    _answerServie = const AnswerService();
  }

  void storeUserAnswer(String topic, String question, String answer) {
    Answer userAnswer =
        Answer(id: '', questionId: question, topicId: topic, answer: answer);

    final storedAnswerIndex =
        _answers.indexWhere((element) => element.questionId == question);

    if (storedAnswerIndex != -1) {
      _answers.removeAt(storedAnswerIndex);
    }

    _answers.add(userAnswer);
    notifyListeners();
  }
}
