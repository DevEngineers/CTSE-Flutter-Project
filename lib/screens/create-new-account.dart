import 'dart:ui';
import 'package:ctse_flutter_project/components/button.dart';
import 'package:ctse_flutter_project/components/custom_text.dart';
import 'package:ctse_flutter_project/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../components/custom_text_field.dart';
import '../model/profile.dart';
import '../providers/profile_provider.dart';
import 'package:provider/provider.dart';

import '../services/ProfileService.dart';

class CreateNewAccount extends StatefulWidget {
  static const String routeName = '/createNewAccount';
  const CreateNewAccount({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CreateNewAccountState();
}

class _CreateNewAccountState extends State<CreateNewAccount> {
  final _formKey = GlobalKey<FormState>();
  String _userName = '';
  String _email = '';
  String _title = '';
  String _password = '';

  void onSubmit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Profile profile = Profile(
        id: '',
        userName: _userName,
        email: _email,
        title: _title,
        password: _password,
        isActive: true,
      );

      late ProfileService _profileService = const ProfileService();

      bool? response = await _profileService.addProfile(profile);
      if (response == true) {
        Navigator.of(context).pushNamed(LoginScreen.routeName);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
            appBar: AppBar(
              title: const Text(
                'Sign Up',
              ),
            ),
            body: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: size.width * 0.1,
                    ),
                    Stack(
                      children: [
                        Center(
                          child: ClipOval(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                              child: CircleAvatar(
                                radius: size.width * 0.14,
                                backgroundColor: Colors.grey[400]!.withOpacity(
                                  0.4,
                                ),
                                child: Icon(
                                  FontAwesomeIcons.user,
                                  size: size.width * 0.1,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: size.height * 0.08,
                          left: size.width * 0.56,
                          child: Container(
                            height: size.width * 0.1,
                            width: size.width * 0.1,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: const Icon(
                              FontAwesomeIcons.arrowUp,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: size.width * 0.1,
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: CustomTextField(
                              label: 'User Name',
                              onChange: (String? value) {
                                setState(() {
                                  _userName = value!;
                                });
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: CustomTextField(
                              label: 'Email',
                              onChange: (String? value) {
                                setState(() {
                                  _email = value!;
                                });
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: CustomTextField(
                              label: 'Title',
                              onChange: (String? value) {
                                setState(() {
                                  _title = value!;
                                });
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: CustomTextField(
                              label: 'Password',
                              enableObscureText: true,
                              onChange: (String? value) {
                                setState(() {
                                  _password = value!;
                                });
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Button(
                            title: 'Register',
                            color: const Color(0xffE78230),
                            onPress: () => onSubmit(),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CustomText(
                              text: 'Already have an account?',
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(LoginScreen.routeName);
                              },
                              child: const CustomText(
                                text: 'Login',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ))
      ],
    );
  }
}
