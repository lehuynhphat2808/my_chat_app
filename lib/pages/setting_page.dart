import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_chat_app/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Dark Mode',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary),
            ),
            CupertinoSwitch(
              value:
                  Provider.of<ThemeProvider>(context, listen: false).isDarkMode,
              onChanged: (value) =>
                  Provider.of<ThemeProvider>(context, listen: false)
                      .toggleTheme(),
            )
          ],
        ),
      ),
    );
  }
}
