import 'package:ctse_flutter_project/providers/answer_provider.dart';
import 'package:ctse_flutter_project/providers/content_provider.dart';
import 'package:ctse_flutter_project/providers/question_provider.dart';
import 'package:ctse_flutter_project/screens/content.dart';
import 'package:ctse_flutter_project/screens/home.dart';
import 'package:ctse_flutter_project/screens/quiz.dart';
import 'package:ctse_flutter_project/screens/splash_screen.dart';
import 'package:ctse_flutter_project/screens/view_content.dart';
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
          ChangeNotifierProvider<AnswerProvider>(
            create: (context) => AnswerProvider(),
          ),
          ChangeNotifierProvider<ContentProvider>(
            create: (context) => ContentProvider(),
          ),
        ],
        child: MaterialApp(
          title: 'CTSE Flutter Project',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              appBarTheme: const AppBarTheme(color: Color(0xff2D4159)),
              scaffoldBackgroundColor: const Color(0xff0F152D)),
          initialRoute: SplashScreen.routeName,
          routes: {
            SplashScreen.routeName: ((context) => const SplashScreen()),
            Home.routeName: ((context) => const Home()),
            Quiz.routeName: ((context) => const Quiz()),
            ViewQuizzes.routeName: ((context) => const ViewQuizzes()),
            ContentView.routeName: (context) => const ContentView(),
            ViewContent.routeName: (((context) => const ViewContent())),
          },
        ));
  }
}
