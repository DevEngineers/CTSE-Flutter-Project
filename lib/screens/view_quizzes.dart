import 'package:ctse_flutter_project/components/button.dart';
import 'package:ctse_flutter_project/components/custom_text.dart';
import 'package:ctse_flutter_project/model/answer.dart';
import 'package:ctse_flutter_project/providers/answer_provider.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../model/question.dart';
import '../providers/question_provider.dart';

class ViewQuizzes extends StatefulWidget {
  static const String routeName = '/view_quizzes';
  const ViewQuizzes({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ViewQuizzes();
}

class _ViewQuizzes extends State<ViewQuizzes> {
  String getCompletedQuizzes(List<Answer> answers) {
    int topicsLength = 5; // TO DO: need to get the length of all topics
    int completedtopicsLength =
        answers.map((e) => e.topicId).toSet().toList().length;
    return '$completedtopicsLength/$topicsLength';
  }

  String getCompletedQuestions(Set<Question> questions, List<Answer> answers) {
    int questionsLength = questions.map((e) => e.id).toSet().toList().length;
    int completedQuestionsLength =
        answers.map((e) => e.questionId).toSet().toList().length;
    return '$completedQuestionsLength/$questionsLength';
  }

  int getProgress(List<Answer> answers) {
    int topicsLength = 5; // TO DO: need to get the length of all topics
    int completedtopicsLength =
        answers.map((e) => e.topicId).toSet().toList().length;
    double percentage = (completedtopicsLength / topicsLength) * 100;
    return percentage.toInt();
  }

  void onResetAll() {
    print('Reset Button Clicked');
  }

  void onRetakeQuiz() {
    print('Retake Button Clicked');
  }

  @override
  Widget build(BuildContext context) {
    final Set<Question> _quizQuestions =
        Provider.of<QuestionProvider>(context).questions;
    final List<Answer> _answers =
        Provider.of<AnwserProvider>(context).storedAnswers;

    return Scaffold(
      appBar: AppBar(title: const Text('View Quizzes')),
      body: Column(
        children: [
          StatusView(
            percentage: getProgress(_answers),
            completedQuiz: getCompletedQuizzes(_answers),
            completedQuestions: getCompletedQuestions(_quizQuestions, _answers),
            onReset: onResetAll,
          ),
          QuizView(
            topic: 'Learn Git',
            completedQuestions: '1/5',
            noOfQuestions: 5,
            onRetakeQuiz: onRetakeQuiz,
          )
        ],
      ),
    );
  }
}

class StatusView extends StatelessWidget {
  final int percentage;
  final String completedQuiz;
  final String completedQuestions;
  final Function onReset;

  const StatusView(
      {Key? key,
      required this.percentage,
      required this.completedQuiz,
      required this.completedQuestions,
      required this.onReset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return SizedBox(
        width: width,
        height: 330,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Card(
            color: const Color(0xff30445C),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                    padding: EdgeInsets.all(20),
                    child: CustomText(
                        text: "Summary",
                        type: 'title',
                        color: 'white',
                        fontWeight: FontWeight.bold)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StatusBox(title: 'Quizzes', name: completedQuiz),
                    StatusBox(title: 'Questions', name: completedQuestions),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child: LinearPercentIndicator(
                    width: width - 40,
                    percent: percentage / 100,
                    animation: true,
                    backgroundColor: const Color(0xff262C42),
                    progressColor: const Color(0xffCBDAE4),
                    lineHeight: 10,
                    barRadius: const Radius.circular(8),
                  ),
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 20, 0),
                      child: CustomText(
                        text: '$percentage% Completed',
                        type: 'bodyTextTwo',
                        color: 'white',
                      ),
                    )),
                Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 20, 0),
                      child: Button(
                        title: 'Rest all',
                        onPress: () => onReset(),
                        width: 150,
                      ),
                    )),
              ],
            ),
          ),
        ));
  }
}

class StatusBox extends StatelessWidget {
  final String title;
  final String name;
  const StatusBox({Key? key, required this.name, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return SizedBox(
        width: width - 230,
        height: 130,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Card(
            color: const Color(0xffE58130),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                    child: CustomText(
                      text: name,
                      type: 'title',
                      color: 'white',
                      fontWeight: FontWeight.bold,
                    )),
                Padding(
                    padding: const EdgeInsets.fromLTRB(10, 8, 8, 0),
                    child: CustomText(
                      text: title,
                      type: 'bodyTextTwo',
                      color: 'white',
                    )),
                const Padding(
                    padding: EdgeInsets.fromLTRB(10, 3, 8, 0),
                    child: CustomText(
                      text: 'Done',
                      type: 'label',
                      color: 'white',
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
          ),
        ));
  }
}

class QuizView extends StatelessWidget {
  //TO DO: add topic id or topic object here;
  final String topic;
  final String completedQuestions;
  final int noOfQuestions;
  final Function onRetakeQuiz;

  const QuizView(
      {Key? key,
      required this.topic,
      required this.completedQuestions,
      required this.noOfQuestions,
      required this.onRetakeQuiz})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return SizedBox(
        width: width,
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Card(
            color: const Color(0xff30445C),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                    child: CustomText(
                        text: topic,
                        type: 'title',
                        color: 'white',
                        fontWeight: FontWeight.bold)),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: CustomText(
                    text: '$noOfQuestions Questions',
                    type: 'bodyText',
                    color: 'white',
                  ),
                ),
                const Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: CustomText(
                        text: '90% Score',
                        type: 'bodyText',
                        color: 'white',
                      ),
                    )),
                const Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: CustomText(
                        text: '3/5 Currect Answer',
                        type: 'bodyText',
                        color: 'white',
                      ),
                    )),
                Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 20, 0),
                      child: Button(
                        title: 'Re-take',
                        onPress: () => onRetakeQuiz(),
                        width: 100,
                      ),
                    )),
              ],
            ),
          ),
        ));
  }
}