import 'package:flutter/material.dart';
import 'package:my_chat_app/pages/login_page.dart';
import 'package:my_chat_app/pages/register_page.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  // initially show the login screen
  bool showLoginScreen = true;

  void togglePages() {
    setState(() {
      showLoginScreen = !showLoginScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showLoginScreen
        ? LoginPage(
            onTap: togglePages,
          )
        : RegisterPage(
            onTap: togglePages,
          );
  }
}
