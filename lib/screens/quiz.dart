import 'package:ctse_flutter_project/components/custom_text.dart';
import 'package:flutter/material.dart';

import '../model/question.dart';

const List<Question> q = [
  Question(
      id: '1',
      question: 'What is the git branching?',
      answers: ['1', '2'],
      correctAnswer: '2'),
  Question(
      id: '2',
      question: 'What is the git branching?2',
      answers: ['1', '2'],
      correctAnswer: '1')
];

class RadioButton extends StatelessWidget {
  final String answer;
  final String groupValue;
  const RadioButton({Key? key, required this.answer, required this.groupValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: 70,
      child: Card(
        elevation: 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              title: CustomText(text: answer),
              leading: Radio(
                value: answer,
                groupValue: groupValue,
                onChanged: (String? value) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizQuestion extends StatefulWidget {
  final Question question;
  final int questionNo;

  const QuizQuestion(
      {Key? key, required this.question, required this.questionNo})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _QuizQuestion();
}

class _QuizQuestion extends State<QuizQuestion> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: CustomText(
            text: 'Question ${widget.questionNo}',
            color: 'grey',
            type: 'bodyText',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: CustomText(
              text: widget.question.question,
              color: 'black',
              type: 'bodyTextTwo'),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.question.answers.length,
            itemBuilder: (context, index) {
              return RadioButton(
                  answer: widget.question.answers.elementAt(index),
                  groupValue: '');
            },
          ),
        )
      ],
    );
  }
}

class Quiz extends StatelessWidget {
  static const String routeName = '/quiz';
  const Quiz({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Quiz')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
                padding: EdgeInsets.all(8),
                child: CustomText(
                  text: 'Learn Basic Git',
                  type: 'headText',
                )),
            ListView.builder(
              shrinkWrap: true,
              itemCount: q.length,
              itemBuilder: (context, index) {
                return QuizQuestion(
                  question: q.elementAt(index),
                  questionNo: index+1,
                );
              },
            ),
          ],
        ));
  }
}
