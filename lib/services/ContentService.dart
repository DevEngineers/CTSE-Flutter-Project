import 'dart:convert';
import 'package:ctse_flutter_project/model/content.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

const List<Content> q = [
  Content(id: "6238c42e523b9f9d1325096d", title: "Learn Git", content: 'Hello'),
  Content(
      id: '6238c42e523b9f9d1325096t', title: "Learn Git2", content: 'Hello2'),
  Content(
      id: '6238c42e523b9f9d1325096w', title: "Learn", content: 'Hello3')
];

class ContentService {
  static String endpoint = '${dotenv.env['API_URL']}/content';
  const ContentService();

  Future<List<Content>> getCotnents() async {
    // final response = await get(Uri.parse(endpoint), headers: {
    //   'Content-type': 'application/json',
    //   'Accept': 'application/json',
    // });

    // if (response.statusCode == 200) {
    //   return jsonDecode(response.body);
    // }
    // throw Exception('Error in getting the content');
    return q;
  }
}
