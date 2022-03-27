import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import '../model/answer.dart';

const List<Answer> q = [
  Answer(
      id: "623a09111b634fdb2c6f789f",
      topicId: "6238c42e523b9f9d1325096d",
      questionId: "623905c080c1fe96e840b431",
      answer: "1",
      isCorrect: true),
  Answer(
      id: "623a09111b634fdb2c6f789w",
      topicId: "6238c42e523b9f9d1325096d",
      questionId: "623905c080c1fe96e840b432",
      answer: "2",
      isCorrect: true),
  Answer(
      id: "623a09111b634fdb2c6f789z",
      topicId: "6238c42e523b9f9d1325096t",
      questionId: "623905c080c1fe96e840b433",
      answer: "3",
      isCorrect: false)
];

class AnswerService {
  static String endpoint = '${dotenv.env['API_URL']}/answer';
  const AnswerService();

  Future<List<Answer>> getStoredAnswers() async {
    // final response = await post(Uri.parse(endpoint),
    //     headers: {
    //       'Content-type': 'application/json',
    //       'Accept': 'application/json',
    //     },
    //     body: json.encode(answers));

    // if (response.statusCode == 200) {
    //   return true;
    // }
    // throw Exception('Error in getting the age');
    return q;
  }

  Future<bool?> submitAnswers(List<Answer> answers) async {
    final response = await post(Uri.parse(endpoint),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode(answers));

    if (response.statusCode == 200) {
      return true;
    }
    throw Exception('Error in getting the age');
  }

  Future<bool?> deleteAllQuizzes() async {
    final response = await delete(Uri.parse(endpoint), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    });

    if (response.statusCode == 200) {
      return true;
    }
    throw Exception('Error in getting the age');
  }
}
