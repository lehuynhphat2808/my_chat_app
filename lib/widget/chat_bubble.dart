import 'package:flutter/material.dart';
import 'package:my_chat_app/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isCurrentUser;
  const ChatBubble(
      {super.key, required this.text, required this.isCurrentUser});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isDarkMode
            ? (isCurrentUser
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context).colorScheme.secondary)
            : (isCurrentUser
                ? Theme.of(context).colorScheme.inversePrimary
                : Theme.of(context).colorScheme.secondary),
      ),
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 25),
      child: Text(
        text,
        style: TextStyle(color: isCurrentUser ? Colors.black : Colors.white),
      ),
    );
  }
}
