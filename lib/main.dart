import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_chat_app/firebase_options.dart';
import 'package:my_chat_app/service/auth/auth_service.dart';
import 'package:my_chat_app/themes/theme_provider.dart';
import 'package:provider/provider.dart';

import 'service/auth/auth_gate.dart';
import 'themes/light_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Chat App',
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: const AuthGate(),
    );
  }
}
