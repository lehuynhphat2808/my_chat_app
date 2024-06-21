import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_chat_app/service/auth/auth_service.dart';
import 'package:my_chat_app/widget/my_button.dart';
import 'package:my_chat_app/widget/my_text_field.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final void Function() onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signIn() async {
    final authService = AuthService();
    try {
      await authService.signInWithEmailAndPassword(
          emailController.text, passwordController.text);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.message,
                  size: 100,
                ),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  "Welcome to LH Phat's chat app",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  height: 12,
                ),
                MyTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false),
                const SizedBox(
                  height: 12,
                ),
                MyTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true),
                const SizedBox(
                  height: 25,
                ),
                MyButton(
                  text: 'Sign In',
                  onTap: signIn,
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Not a member?'),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        'Register now',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color:
                                Theme.of(context).colorScheme.inversePrimary),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
