import 'dart:ui';
import 'package:ctse_flutter_project/components/button.dart';
import 'package:ctse_flutter_project/screens/edit-profile.dart';
import 'package:ctse_flutter_project/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../components/custom_text_field.dart';
import '../model/profile.dart';
import '../providers/profile_provider.dart';
import 'package:provider/provider.dart';

class ViewProfile extends StatefulWidget {
  static const String routeName = '/viewProfile';
  const ViewProfile({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ViewProfile();
}

class _ViewProfile extends State<ViewProfile> {
  final _formKey = GlobalKey<FormState>();
  String _id = '';
  String _userName = '';
  String _email = '';
  String _title = '';
  String _password = '';

  @override
  void initState() {
    super.initState();
    Profile profile =
        Provider.of<ProfileProvider>(context, listen: false).profile;

    setState(() {
      _id = profile.id;
      _userName = profile.userName;
      _email = profile.email;
      _title = profile.title;
      _password = profile.password;
    });
  }

  void onDelete() {
    Provider.of<ProfileProvider>(context, listen: false).deleteProfile(_id);
    Navigator.of(context).pushNamed(LoginScreen.routeName);
  }

  void logout() {
    Provider.of<ProfileProvider>(context, listen: false).logout();
    Navigator.of(context).pushNamed(LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
            appBar: AppBar(
              title: const Text(
                'Profile',
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.power_settings_new_sharp),
                  onPressed: () {
                    logout();
                  },
                ),
              ],
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
                            value: _userName,
                            onChange: (String? value) {},
                            isEnable: false,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: CustomTextField(
                              label: 'Email',
                              value: _email,
                              isEnable: false,
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
                              value: _title,
                              isEnable: false,
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
                              value: _password,
                              isEnable: false,
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
                            title: 'Edit Profile',
                            color: const Color(0xffE78230),
                            onPress: () => Navigator.of(context)
                                .pushNamed(EditProfile.routeName),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Button(
                            title: 'Deactivate Account',
                            color: Colors.red,
                            onPress: () => onDelete(),
                          ),
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
