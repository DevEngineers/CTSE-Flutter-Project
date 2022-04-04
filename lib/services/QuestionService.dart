import 'dart:convert';
import 'package:ctse_flutter_project/model/question.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

class QuestionService {
  static String endpoint = "${dotenv.env['API_URL']}/question";
  const QuestionService();

  Future<Set<Question>?> getQuestions() async {
    final response = await get(Uri.parse(endpoint), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    });

    if (response.statusCode == 200) {
      Set<Question> questionList = {};
      Set<dynamic> data = jsonDecode(response.body);

      for (dynamic item in data) {
        Question answer = Question(
            id: item['_id'],
            topicId: item['topicId'],
            answers: item['answers'],
            correctAnswer: item['correctAnswer'],
            question: item['question']);
        questionList.add(answer);
      }

      return questionList;
    }
    throw Exception('Error in getting the questions');
  }
}
