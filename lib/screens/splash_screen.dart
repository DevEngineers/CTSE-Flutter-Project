import 'dart:async';
import 'package:ctse_flutter_project/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/answer_provider.dart';
import '../providers/content_provider.dart';
import '../providers/question_provider.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.of(context).pushNamed(
              Home.routeName,
            ));
  }

  void initializeProviders() {
    Provider.of<QuestionProvider>(context);
    Provider.of<AnswerProvider>(context);
    Provider.of<ContentProvider>(context);
  }

  @override
  Widget build(BuildContext context) {
    initializeProviders();
    return Scaffold(
        body: Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              './lib/assets/images/git.png',
              width: 180,
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Text('Learn Git',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold)),
            )
          ]),
    ));
  }
}
