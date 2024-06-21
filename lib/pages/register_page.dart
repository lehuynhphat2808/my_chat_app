import 'package:flutter/material.dart';
import 'package:my_chat_app/widget/my_button.dart';
import 'package:my_chat_app/widget/my_text_field.dart';
import 'package:provider/provider.dart';

import '../service/auth/auth_service.dart';

class RegisterPage extends StatefulWidget {
  final void Function() onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  void signUp() async {
    if (passwordController.text == confirmPasswordController.text) {
      final authService = AuthService();

      try {
        await authService.signUpWithEmailAndPassword(
            emailController.text, passwordController.text);
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.toString())));
        }
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Password do not match')));
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
                  "Let's create an account for you",
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
                  height: 12,
                ),
                MyTextField(
                    controller: confirmPasswordController,
                    hintText: 'Confirm Password',
                    obscureText: true),
                const SizedBox(
                  height: 25,
                ),
                MyButton(
                  text: 'Register',
                  onTap: signUp,
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already a member?'),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        'Login now',
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
