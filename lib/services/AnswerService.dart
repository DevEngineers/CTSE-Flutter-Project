import 'dart:convert';
import 'package:http/http.dart';
import '../model/answer.dart';

class AnswerService {
  static const String endpoint = "http://192.168.1.4:5000/answer";
  const AnswerService();

  Future<bool?> submitAnswers(List<Answer> answers) async {
    final response = await post(Uri.parse(endpoint),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode(answers));

    if (response.statusCode == 200) {
      //return jsonDecode(response.body)['age'];
      return true;
    }
    throw Exception('Error in getting the age');
  }
}
