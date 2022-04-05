import 'dart:convert';
import 'package:ctse_flutter_project/model/content.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

class ContentService {
  static String endpoint = '${dotenv.env['API_URL']}/content';
  const ContentService();

  Future<Set<Content>> getContent() async {
    final response = await get(Uri.parse(endpoint), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    });

    if (response.statusCode == 200) {
      Set<Content> contentList = {};
      List<dynamic> data = jsonDecode(response.body)['data'];

      for (dynamic item in data) {
        Content content = Content(
          id: item['_id'],
          title: item['title'],
          content: item['content'],
        );

        contentList.add(content);
      }

      return contentList;
    }
    throw Exception('Error in getting the answers');
  }
}
