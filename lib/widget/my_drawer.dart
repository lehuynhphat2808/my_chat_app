import 'package:flutter/material.dart';
import 'package:my_chat_app/pages/profile_page.dart';
import 'package:my_chat_app/pages/setting_page.dart';

class MyDrawer extends StatelessWidget {
  final Function()? logout;
  const MyDrawer({super.key, this.logout});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              DrawerHeader(
                  child: Center(
                child: Icon(Icons.message,
                    size: 40, color: Theme.of(context).colorScheme.surface),
              )),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: ListTile(
                  onTap: () => Navigator.pop(context),
                  leading: Icon(Icons.home,
                      color: Theme.of(context).colorScheme.surface),
                  title: Text(
                    'H O M E',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.surface),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: ListTile(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfilePage(),
                      )),
                  leading: Icon(Icons.person,
                      color: Theme.of(context).colorScheme.surface),
                  title: Text(
                    'P R O F I L E',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.surface),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: ListTile(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingPage(),
                      )),
                  leading: Icon(Icons.settings,
                      color: Theme.of(context).colorScheme.surface),
                  title: Text(
                    'S E T T I N G S',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.surface),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 25),
            child: ListTile(
              onTap: logout,
              leading: Icon(Icons.logout,
                  color: Theme.of(context).colorScheme.surface),
              title: Text(
                'L O G  O U T',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.surface),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
