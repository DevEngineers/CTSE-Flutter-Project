import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import '../model/answer.dart';

class AnswerService {
  static String endpoint = '${dotenv.env['API_URL']}/answer';
  const AnswerService();

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
}
