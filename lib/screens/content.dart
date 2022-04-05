import 'package:ctse_flutter_project/model/content.dart';
import 'package:ctse_flutter_project/screens/quiz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/button.dart';
import '../components/custom_text.dart';
import '../model/route_arguments.dart';
import '../providers/content_provider.dart';

class ContentView extends StatefulWidget {
  static const String routeName = '/content';
  const ContentView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ContentView();
}

class _ContentView extends State<ContentView> {
  String _topicId = '';

  Future<void> getRouteArguments() async {
    final RouteArguments arg =
        ModalRoute.of(context)!.settings.arguments as RouteArguments;

    setState(() {
      _topicId = arg.topicId;
    });
  }

  @override
  Widget build(BuildContext context) {
    getRouteArguments();
    Content? content =
        Provider.of<ContentProvider>(context).getContentsByIds(_topicId);
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Tutorial"),
        ),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 0, 10),
              child: CustomText(
                  text: content!.title,
                  type: 'title',
                  color: 'white',
                  fontWeight: FontWeight.bold),
            ),
            SingleChildScrollView(
              child: SizedBox(
                width: width,
                child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Card(
                      color: const Color(0xff30445C),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 20, 10, 20),
                              child: Text(
                                content.content,
                                textAlign: TextAlign.justify,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                                softWrap: true,
                              )),
                        ],
                      ),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Button(
                  title: 'Start Quiz',
                  onPress: () {
                    Navigator.of(context).pushNamed(Quiz.routeName,
                        arguments:
                            RouteArguments('First', content.title, content.id));
                  },
                  color: const Color(0xffE78230)),
            )
          ],
        )));
  }
}
