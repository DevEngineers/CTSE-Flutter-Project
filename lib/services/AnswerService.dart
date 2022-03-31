import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import '../model/answer.dart';

class AnswerService {
  static String endpoint = '${dotenv.env['API_URL']}/answer';
  const AnswerService();

  Future<List<Answer>> getStoredAnswers() async {
    final response = await get(Uri.parse(endpoint), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    });

    if (response.statusCode == 200) {
      List<Answer> answerList = [];
      List<dynamic> data = jsonDecode(response.body);

      for (dynamic item in data) {
        Answer answer = Answer(
            id: item['_id'],
            questionId: item['questionId'],
            topicId: item['topicId'],
            answer: item['answer'],
            isCorrect: item['isCorrect']);
        answerList.add(answer);
      }

      return answerList;
    }
    throw Exception('Error in getting the answers');
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
    throw Exception('Error in Submitting the answers');
  }

  Future<bool?> updateAnswers(List<Answer> answers) async {
    final response = await put(Uri.parse(endpoint),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode(answers));

    if (response.statusCode == 200) {
      return true;
    }
    throw Exception('Error in updating the answers');
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
