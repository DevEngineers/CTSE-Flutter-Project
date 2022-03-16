import 'package:ctse_flutter_project/screens/quiz.dart';
import 'package:flutter/material.dart';
import '../components/button.dart';

class Home extends StatelessWidget {
  static const String routeName = '/';
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Column(
        children: [
          Button(
            title: 'quiz',
            onPress: () {
              Navigator.of(context).pushNamed(Quiz.routeName);
            },
            width: 200,
          )
        ],
      ),
    );
  }
}
