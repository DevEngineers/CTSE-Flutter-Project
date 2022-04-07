import 'dart:ui';
import 'package:ctse_flutter_project/components/button.dart';
import 'package:ctse_flutter_project/screens/home.dart';
import 'package:ctse_flutter_project/screens/view-profile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../components/custom_text_field.dart';
import '../model/profile.dart';
import '../providers/profile_provider.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  static const String routeName = '/EditProfile';

  const EditProfile({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EditProfile();
}

class _EditProfile extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  String _id = '';
  String _userName = '';
  String _email = '';
  String _title = '';
  String _password = '';

  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Profile profile = Profile(
        id: _id,
        userName: _userName,
        email: _email,
        title: _title,
        password: _password,
        isActive: true,
      );

      Provider.of<ProfileProvider>(context, listen: false)
          .updateProfile(profile);
      Navigator.of(context).pushNamed(Home.routeName);
    }
  }

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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
            appBar: AppBar(
              title: const Text(
                'Edit Profile',
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
                              value: _userName,
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
                              value: _email,
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
                            title: 'Update Profile',
                            color: const Color(0xffE78230),
                            onPress: () => onSubmit(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Button(
                            title: 'Cancel',
                            color: Colors.red,
                            onPress: () => Navigator.of(context)
                                .pushNamed(ViewProfile.routeName),
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
