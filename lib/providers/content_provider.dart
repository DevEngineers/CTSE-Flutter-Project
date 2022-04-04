import 'package:ctse_flutter_project/model/content.dart';
import 'package:ctse_flutter_project/services/ContentService.dart';
import 'package:flutter/cupertino.dart';

class ContentProvider extends ChangeNotifier {
  late ContentService _contentService;
  final Set<Content> _contents = {};

  Set<Content> get contents => _contents;

  ContentProvider() {
    _contentService = const ContentService();
    getContents();
  }

  void getContents() async {
    final answers = await _contentService.getContent();
    _contents.addAll(answers);
    notifyListeners();
  }

  Content? getContentsByIds(String id) {
    return _contents.singleWhere((content) => content.id == id);
  }
}
