import 'package:ctse_flutter_project/screens/home.dart';
import 'package:ctse_flutter_project/screens/learngit/content.dart';
import 'package:ctse_flutter_project/screens/learngit/content_add_edit.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CTSE Flutter Project',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Home.routeName,
      routes: {
        Home.routeName: ((context) => const Home()),
        '/add-product': (context) => const ProductAddEdit(),
        '/edit-product': (context) => const ProductAddEdit(),
        '/content': (context) => const Content(),
      },
    );
  }
}
