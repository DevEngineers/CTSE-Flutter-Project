import 'package:flutter/material.dart';

import '../drawer/my_drawer_header.dart';
import 'learnGit/learn_git.dart';
import 'profile/profile.dart';
import 'question/question.dart';

class Home extends StatefulWidget {
  static const String routeName = '/';
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var currentPage = DrawerSections.profile;
  @override
  Widget build(BuildContext context) {
    StatelessWidget container = const ProfilePage();
    if (currentPage == DrawerSections.profile) {
      container = const ProfilePage();
    } else if (currentPage == DrawerSections.learGit) {
      container = const LearnGitPage();
    } else if (currentPage == DrawerSections.quesAndAnswer) {
      container = const QuestionPage();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: const Text("Git Study "),
      ),
      body: container,
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const MyHeaderDrawer(),
              myDrawerList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget myDrawerList() {
    return Container(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          menuItem(1, "Profile", Icons.people_alt_outlined,
              currentPage == DrawerSections.profile ? true : false),
          menuItem(2, "Learn Git", Icons.catching_pokemon_outlined,
              currentPage == DrawerSections.learGit ? true : false),
          menuItem(3, "Question and answer", Icons.question_answer_outlined,
              currentPage == DrawerSections.profile ? true : false),
          const Divider(),
          menuItem(4, "About us", Icons.home_max_outlined,
              currentPage == DrawerSections.profile ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      // color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: (() {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.profile;
            } else if (id == 2) {
              currentPage = DrawerSections.learGit;
            } else if (id == 3) {
              currentPage = DrawerSections.quesAndAnswer;
            } else if (id == 4) {
              currentPage = DrawerSections.aboutUs;
            }
          });
        }),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                  flex: 4,
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

enum DrawerSections {
  profile,
  learGit,
  quesAndAnswer,
  aboutUs,
}

// class Home extends StatelessWidget {
//   static const String routeName = '/';
//   const Home({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(appBar: AppBar(title: const Text('Home')));
//   }
// }
