import 'package:ctse_flutter_project/screens/view_content.dart';
import 'package:ctse_flutter_project/screens/view_quizzes.dart';
import 'package:flutter/material.dart';
import '../components/custom_text.dart';

class Home extends StatefulWidget {
  static const String routeName = '/home';
  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Home();
}

class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          automaticallyImplyLeading: false,
        ),
        body: Column(
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
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: CustomText(
                    text: 'Home',
                    type: 'headText',
                    fontWeight: FontWeight.w600),
              ),
            ),
            Flexible(
                child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              children: [
                MenuItem(
                  name: 'Tutorial',
                  onPress: () {
                    Navigator.of(context).pushNamed(
                      ViewContent.routeName,
                    );
                  },
                  image: './lib/assets/images/tutorial.png',
                ),
                MenuItem(
                  name: 'Quiz',
                  onPress: () {
                    Navigator.of(context).pushNamed(
                      ViewQuizzes.routeName,
                    );
                  },
                  icon: Icons.cast_for_education,
                  image: './lib/assets/images/quiz.png',
                )
              ],
            ))
          ],
        ));
  }
}

class MenuItem extends StatelessWidget {
  final String name;
  final Function onPress;
  final IconData? icon;
  final String image;

  const MenuItem({
    Key? key,
    required this.name,
    required this.onPress,
    this.icon,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return SizedBox(
        width: width / 2,
        height: 50,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Card(
              color: const Color(0xff30445C),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: InkWell(
                onTap: () => onPress(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Image.asset(
                        image,
                        width: 80,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: CustomText(
                            text: name,
                            type: 'headText',
                            color: 'white',
                            fontWeight: FontWeight.w600)),
                    const Padding(
                        padding: EdgeInsets.fromLTRB(0, 2, 5, 0),
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              Icons.arrow_circle_right_sharp,
                              size: 45,
                              color: Color(0xffE78230),
                            ))),
                  ],
                ),
              )),
        ));
  }
}
