import 'package:ctse_flutter_project/providers/content_provider.dart';
import 'package:ctse_flutter_project/screens/content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/custom_text.dart';
import '../model/content.dart';
import '../model/route_arguments.dart';

class ViewContent extends StatefulWidget {
  static const String routeName = '/view_content';

  const ViewContent({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ViewContent();
}

class _ViewContent extends State<ViewContent> {
  Set<Content> products = {};

  void onPressContent(Content content) {
    Navigator.of(context).pushNamed(ContentView.routeName,
        arguments: RouteArguments('', '', content.id));
  }

  @override
  Widget build(BuildContext context) {
    Set<Content> _contents = Provider.of<ContentProvider>(context).contents;
    return Scaffold(
        appBar: AppBar(
          title: RichText(
            text: TextSpan(children: [
              const TextSpan(
                  text: "Learn",
                  style: TextStyle(
                      color: Color(0xffE78230),
                      fontWeight: FontWeight.bold,
                      fontSize: 22)),
              TextSpan(
                  text: "Git",
                  style: TextStyle(
                      color: Colors.green[400],
                      fontWeight: FontWeight.bold,
                      fontSize: 22)),
            ]),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
                padding: EdgeInsets.fromLTRB(0, 30, 0, 5),
                child: Text('Tutorials',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold))),
            const Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Divider(
                  thickness: 2.0,
                  color: Colors.white,
                )),
            ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: _contents.length,
              itemBuilder: (context, index) {
                return ContentItem(
                  index: index,
                  content: _contents.elementAt(index),
                  onPress: onPressContent,
                );
              },
            ),
          ],
        )));
  }
}

class ContentItem extends StatelessWidget {
  final Content content;
  final int index;
  final Function? onPress;

  const ContentItem({
    Key? key,
    required this.content,
    required this.index,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return SizedBox(
        width: width,
        height: 150,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Card(
              color: const Color(0xff30445C),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: InkWell(
                onTap: () {
                  onPress!(content);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                        child: CustomText(
                            text: content.title,
                            type: 'title',
                            color: 'white',
                            fontWeight: FontWeight.bold)),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                          child: CustomText(
                            text: 'Tutorial ${index + 1}',
                            type: 'bodyText',
                            color: 'white',
                          ),
                        )),
                    const Padding(
                        padding: EdgeInsets.fromLTRB(0, 2, 5, 0),
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              Icons.arrow_circle_right_outlined,
                              size: 45,
                              color: Color(0xffE78230),
                            )))
                  ],
                ),
              )),
        ));
  }
}
