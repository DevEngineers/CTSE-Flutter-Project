import 'package:ctse_flutter_project/components/custom_text.dart';
import 'package:ctse_flutter_project/providers/profile_provider.dart';
import 'package:ctse_flutter_project/screens/create-new-account.dart';
import 'package:ctse_flutter_project/screens/forgot-password.dart';
import 'package:ctse_flutter_project/screens/home.dart';
import 'package:ctse_flutter_project/services/ProfileService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/button.dart';
import '../components/custom_text_field.dart';
import '../model/login.dart';
import '../model/profile.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _errorText = 'value';
  bool _isErrorTextVisible = false;

  void onSubmit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Login login = Login(
        email: _email,
        password: _password,
      );

      late ProfileService _profileService = const ProfileService();

      Profile? profile = await _profileService.login(login);

      if (profile!.id != '') {
        if (profile.isActive) {
          Provider.of<ProfileProvider>(context, listen: false)
              .addProfile(profile);
          setState(() {
            _isErrorTextVisible = false;
          });
          Navigator.of(context).pushNamed(Home.routeName);
        } else {
          setState(() {
            _errorText = 'Your Account is disabled';
            _isErrorTextVisible = true;
          });
        }
      } else {
        setState(() {
          _errorText = 'Email or Password is incorrect';
          _isErrorTextVisible = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
            child: Form(
          key: _formKey,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  './lib/assets/images/git.png',
                  width: 180,
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: RichText(
                      text: TextSpan(children: [
                        const TextSpan(
                            text: "Learn",
                            style: TextStyle(
                                color: Color(0xffE78230),
                                fontWeight: FontWeight.bold,
                                fontSize: 32)),
                        TextSpan(
                            text: "Git",
                            style: TextStyle(
                                color: Colors.green[400],
                                fontWeight: FontWeight.bold,
                                fontSize: 32)),
                      ]),
                    )),
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
                      label: 'Password',
                      enableObscureText: true,
                      onChange: (String? value) {
                        setState(() {
                          _password = value!;
                        });
                      }),
                ),
                if (_isErrorTextVisible) ...{
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 10),
                        child: CustomText(
                          text: _errorText,
                          type: 'label',
                          color: 'red',
                        )),
                  ),
                },
                GestureDetector(
                  onTap: () =>
                      Navigator.of(context).pushNamed(ForgotPassword.routeName),
                  child: const CustomText(
                    text: 'Forgot Password ?',
                    type: 'bodyTextTwo',
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Button(
                    title: 'Login',
                    color: const Color(0xffE78230),
                    onPress: () => onSubmit(),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context)
                      .pushNamed(CreateNewAccount.routeName),
                  child: const CustomText(
                    text: 'Create New Account',
                    type: 'bodyTextTwo',
                  ),
                ),
              ]),
        )));
  }
}
