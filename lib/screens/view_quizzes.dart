import 'package:ctse_flutter_project/components/button.dart';
import 'package:ctse_flutter_project/components/custom_text.dart';
import 'package:ctse_flutter_project/model/answer.dart';
import 'package:ctse_flutter_project/model/content.dart';
import 'package:ctse_flutter_project/providers/answer_provider.dart';
import 'package:ctse_flutter_project/providers/content_provider.dart';
import 'package:ctse_flutter_project/screens/quiz.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../model/question.dart';
import '../model/route_arguments.dart';
import '../providers/question_provider.dart';

class ViewQuizzes extends StatefulWidget {
  static const String routeName = '/view_quizzes';
  const ViewQuizzes({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ViewQuizzes();
}

class _ViewQuizzes extends State<ViewQuizzes> {
  String getCompletedQuizzes(List<Answer> answers, int topicCount) {
    int topicsLength = topicCount;
    int completedTopicsLength =
        answers.map((e) => e.topicId).toSet().toList().length;
    return '$completedTopicsLength/$topicsLength';
  }

  String getCompletedQuestions(Set<Question> questions, List<Answer> answers) {
    int questionsLength = questions.map((e) => e.id).toSet().toList().length;
    int completedQuestionsLength =
        answers.map((e) => e.questionId).toSet().toList().length;
    return '$completedQuestionsLength/$questionsLength';
  }

  String getCompletedQuestionsByTopic(
      Set<Question> questions, List<Answer> answers) {
    int questionsLength =
        questions.map((e) => e.topicId).toSet().toList().length;
    int completedQuestionsLength =
        answers.map((e) => e.questionId).toSet().toList().length;
    return '$completedQuestionsLength/$questionsLength';
  }

  double getProgress(List<Answer> answers, int topicCount) {
    int topicsLength = topicCount;
    int completedTopicsLength =
        answers.map((e) => e.topicId).toSet().toList().length;
    double percentage = (completedTopicsLength / topicsLength) * 100;
    return percentage;
  }

  void onResetAll(double completedQuizPercentage) {
    if (completedQuizPercentage == 0) {
      showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: const Text('Learn Git'),
                content: const Text("You don't have any attempted quizzes"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Ok'),
                  ),
                ],
              ));
    } else {
      showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: const Text('Learn Git'),
                content: const Text('Are you sure to reset all'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      Provider.of<AnswerProvider>(context, listen: false)
                          .restAllQuizzes();
                      Navigator.pop(context, 'Ok');
                      _displaySuccessDialog(context);
                    },
                    child: const Text('Reset'),
                  ),
                ],
              ));
    }
  }

  _displaySuccessDialog(BuildContext context) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text('Learn Git'),
              content: const Text('All the attempted quizzes are removed'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Ok'),
                ),
              ],
            ));
  }

  void onRetakeQuiz(String topic, String topicId) {
    Navigator.of(context).pushNamed(Quiz.routeName,
        arguments: RouteArguments('Retake', topic, topicId));
  }

  @override
  Widget build(BuildContext context) {
    final Set<Question> _quizQuestions =
        Provider.of<QuestionProvider>(context).questions;
    final List<Answer> _answers =
        Provider.of<AnswerProvider>(context).storedAnswers;
    final List<String> _topicIds =
        Provider.of<AnswerProvider>(context).getTopicIds();
    final Set<Content> _contents =
        Provider.of<ContentProvider>(context).contents;

    return Scaffold(
        appBar: AppBar(title: const Text('View Quizzes')),
        body: SingleChildScrollView(
          child: Column(
            children: [
              StatusView(
                percentage: getProgress(_answers, _contents.length),
                completedQuiz: getCompletedQuizzes(_answers, _contents.length),
                completedQuestions:
                    getCompletedQuestions(_quizQuestions, _answers),
                onReset: onResetAll,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _topicIds.length,
                itemBuilder: (context, index) {
                  if (_contents.elementAt(index).id ==
                      _topicIds.elementAt(index)) {
                    return QuizView(
                      topicId: _contents.elementAt(index).id,
                      topic: _contents.elementAt(index).title,
                      onRetakeQuiz: onRetakeQuiz,
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        ));
  }
}

class StatusView extends StatelessWidget {
  final double percentage;
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
        height: 325,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Card(
            color: const Color(0xff30445C),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
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
                        text: '${percentage.toStringAsFixed(0)}% Completed',
                        type: 'bodyTextTwo',
                        color: 'white',
                      ),
                    )),
                Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 20, 0),
                      child: Button(
                        title: 'Reset Quizzes',
                        onPress: () => onReset(percentage),
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
  final String topic;
  final String topicId;
  final Function onRetakeQuiz;

  const QuizView(
      {Key? key,
      required this.topic,
      required this.onRetakeQuiz,
      required this.topicId})
      : super(key: key);

  String getScore(int questionCount, int correctAnswerCount) {
    String score =
        ((correctAnswerCount / questionCount) * 100).toStringAsFixed(0);
    return '$score% Score';
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final int noOfQuestions = Provider.of<QuestionProvider>(context)
        .getQuestionsByTopic(topicId)
        .length;
    final int correctAnswers = Provider.of<AnswerProvider>(context)
        .getCorrectAnswersByTopic(topicId)
        .length;

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
                Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: CustomText(
                        text: getScore(noOfQuestions, correctAnswers),
                        type: 'bodyText',
                        color: 'white',
                      ),
                    )),
                Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: CustomText(
                        text: '$correctAnswers/$noOfQuestions Correct Answer',
                        type: 'bodyText',
                        color: 'white',
                      ),
                    )),
                Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 20, 0),
                      child: Button(
                        title: 'Re-take quiz',
                        onPress: () => onRetakeQuiz(topic, topicId),
                        width: 150,
                      ),
                    )),
              ],
            ),
          ),
        ));
  }
}
