import 'package:flutter/material.dart';

import '../../model/content_model.dart';

class Content extends StatelessWidget {
  const Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ContentModel;
    return Scaffold(
        appBar: AppBar(
          title: const Text("contain page"),
        ),
        body: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Text(args.title!),
                Text(args.content!, textAlign: TextAlign.justify),
                const Divider(height: 20.0)
              ],
            )));
  }
}
