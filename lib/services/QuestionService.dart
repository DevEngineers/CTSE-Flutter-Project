import 'dart:convert';
import 'package:ctse_flutter_project/model/question.dart';
import 'package:http/http.dart';

const List<Question> q = [
  Question(
      id: '1',
      topicId: 'T1',
      question: 'What is the git branching?',
      answers: ['1', '2'],
      correctAnswer: '2'),
  Question(
      id: '2',
      topicId: 'T1',
      question: 'What is the git branching?2',
      answers: ['11', '22'],
      correctAnswer: '11'),
  Question(
      id: '3',
      topicId: 'T1',
      question: 'What is the git branching?3',
      answers: ['33', '44'],
      correctAnswer: '44')
];

class QuestionServie {
  static const String endpoint = "";
  const QuestionServie();

  Future<List<Question>?> getQuestions(String topicId) async {
    // final response = await get(Uri.parse(endpoint).replace(queryParameters: {
    //   "topic": topicId,
    // }));

    // if (response.statusCode == 200) {
    //   return jsonDecode(response.body)['age'];
    // }
    //throw Exception('Error in getting the age');

    return q;
  }
}
