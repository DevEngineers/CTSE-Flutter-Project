import 'package:ctse_flutter_project/model/answer.dart';
import 'package:ctse_flutter_project/services/AnswerService.dart';
import 'package:flutter/cupertino.dart';

class AnwserProvider extends ChangeNotifier {
  late AnswerService _answerServie;
  final List<Answer> _storedAnswers = [];
  final List<Answer> _answers = [];

  List<Answer> get answers => _answers;
  List<Answer> get stordAnswers => _storedAnswers;

  AnwserProvider() {
    _answerServie = const AnswerService();
  }

  void storeUserAnswer(String topic, String question, String answer) {
    Answer userAnswer =
        Answer(id: '', questionId: question, topicId: topic, answer: answer);

    final storedAnswerIndex =
        _answers.indexWhere((answer) => answer.questionId == question);

    if (storedAnswerIndex != -1) {
      _answers.removeAt(storedAnswerIndex);
    }

    _answers.add(userAnswer);
    notifyListeners();
  }

  void submitUserAnswers() {
    final response = _answerServie.submitAnswers(_answers);

    response.then((value) {
      if (value == true) {
        _storedAnswers.addAll(_answers);
        _answers.clear();
        notifyListeners();
      }
    });
  }
}
