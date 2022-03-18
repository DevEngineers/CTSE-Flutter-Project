import 'dart:convert';
import 'package:http/http.dart';
import '../model/answer.dart';

class AnswerService {
  static const String endpoint = "";
  const AnswerService();

  Future<bool?> submitAnswers(String topic, List<Answer> answers) async {
    //final response = await get(Uri.parse(endpoint).replace());

    // if (response.statusCode == 200) {
    //   return jsonDecode(response.body)['age'];
    // }
    // throw Exception('Error in getting the age');

    print(topic);
    return true;
  }
}
