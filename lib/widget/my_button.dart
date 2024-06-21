import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final Function()? onTap;
  const MyButton({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            padding: const EdgeInsets.all(16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
        child: Text(
          text,
          style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
        ),
      ),
    );
  }
}
