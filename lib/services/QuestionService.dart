import 'dart:convert';
import 'package:ctse_flutter_project/model/question.dart';
import 'package:http/http.dart';

const List<Question> q = [
  Question(
      id: '623905c080c1fe96e840b431',
      topicId: '6238c42e523b9f9d1325096d',
      question: 'What is the git branching?',
      answers: ['1', '2', '3', '4'],
      correctAnswer: '2'),
  Question(
      id: '6238c42e523b9f9d1325096f',
      topicId: '6238c42e523b9f9d1325096d',
      question: 'What is the git branching?2',
      answers: ['11', '22', '33', '44'],
      correctAnswer: '11'),
  Question(
      id: '6238c42e523b9f9d1325096z',
      topicId: '6238c42e523b9f9d1325096t',
      question: 'What is the git branching?3',
      answers: ['33', '44'],
      correctAnswer: '44')
];

class QuestionServie {
  static const String endpoint = "";
  const QuestionServie();

  Future<List<Question>?> getQuestions() async {
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
