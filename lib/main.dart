import 'package:ctse_flutter_project/providers/answer_provider.dart';
import 'package:ctse_flutter_project/providers/question_provider.dart';
import 'package:ctse_flutter_project/screens/home.dart';
import 'package:ctse_flutter_project/screens/quiz.dart';
import 'package:ctse_flutter_project/screens/view_quizzes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<QuestionProvider>(
            create: (context) => QuestionProvider(),
          ),
          ChangeNotifierProvider<AnwserProvider>(
            create: (context) => AnwserProvider(),
          ),
        ],
        child: MaterialApp(
          title: 'CTSE Flutter Project',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: Home.routeName,
          routes: {
            Home.routeName: ((context) => const Home()),
            Quiz.routeName: ((context) => const Quiz()),
            ViewQuizzes.routeName:((context) => const ViewQuizzes())
          },
        ));
  }
}
