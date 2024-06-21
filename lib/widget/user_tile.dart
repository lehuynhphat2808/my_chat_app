import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const UserTile({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).colorScheme.secondary,
        ),
        child: Row(
          children: [
            Icon(
              Icons.person,
              color: Theme.of(context).indicatorColor,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(text)
          ],
        ),
      ),
    );
  }
}
