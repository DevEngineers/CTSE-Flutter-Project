import 'package:ctse_flutter_project/model/answer.dart';
import 'package:ctse_flutter_project/services/AnswerService.dart';
import 'package:flutter/cupertino.dart';

class AnwserProvider extends ChangeNotifier {
  late AnswerService _answerService;
  final List<Answer> _storedAnswers = [];
  final List<Answer> _answers = [];

  List<Answer> get answers => _answers;
  List<Answer> get storedAnswers => _storedAnswers;

  AnwserProvider() {
    _answerService = const AnswerService();
    getStoredAnswers();
  }

  void getStoredAnswers() async {
    final answers = await _answerService.getStoredAnswers();
    _storedAnswers.addAll(answers);
    notifyListeners();
  }

  void storeUserAnswer(
      String id, String topic, String question, String answer, bool isCorrect) {
    Answer userAnswer = Answer(
        id: id,
        questionId: question,
        topicId: topic,
        answer: answer,
        isCorrect: isCorrect);

    final storedAnswerIndex =
        _answers.indexWhere((answer) => answer.questionId == question);

    if (storedAnswerIndex != -1) {
      _answers.removeAt(storedAnswerIndex);
    }

    _answers.add(userAnswer);
    notifyListeners();
  }

  void submitUserAnswers() {
    final response = _answerService.submitAnswers(_answers);

    response.then((value) {
      if (value == true) {
        _storedAnswers.addAll(_answers);
        _answers.clear();
        notifyListeners();
      }
    });
  }

  void updateUserAnswers() {
    final response = _answerService.updateAnswers(_answers);

    response.then((value) {
      if (value == true) {
        _storedAnswers.addAll(_answers);
        _answers.clear();
        notifyListeners();
      }
    });
  }

  void restAllQuizzes() {
    final response = _answerService.deleteAllQuizzes();

    response.then((value) {
      if (value == true) {
        _storedAnswers.clear();
        _answers.clear();
        notifyListeners();
      }
    });
  }

  List<Answer> getCorrectAnswersByTopic(String topicId) {
    Iterable<Answer> answers = _storedAnswers
        .where((element) =>
            element.topicId == topicId && element.isCorrect == true)
        .toSet()
        .toList();
    return answers.toList();
  }

  void updateStoredUserAnswer(
      String topicId, String question, String answer, bool isCorrect) {
    String answerId = '';

    final storedAnswerIndex =
        _storedAnswers.indexWhere((answer) => answer.questionId == question);

    if (storedAnswerIndex != -1) {
      answerId = _storedAnswers.elementAt(storedAnswerIndex).id;
      _storedAnswers.removeAt(storedAnswerIndex);
    }

    storeUserAnswer(answerId, topicId, question, answer, isCorrect);
    notifyListeners();
  }

  List<String> getTopicIds() {
    List<String> topicIds =
        _storedAnswers.map((element) => element.topicId).toSet().toList();
    return topicIds.toList();
  }
}
