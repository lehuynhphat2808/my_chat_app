import 'package:flutter/material.dart';
import 'package:my_chat_app/service/chat/chat_service.dart';
import 'package:my_chat_app/widget/my_drawer.dart';
import 'package:my_chat_app/widget/user_tile.dart';

import '../service/auth/auth_service.dart';
import 'chat_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final AuthService authService = AuthService.instance;

  final ChatService chatService = ChatService();

  void signOut() async {
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'Home Page',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      drawer: MyDrawer(
        logout: signOut,
      ),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: chatService.getUsersStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('Error!'),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Text('Loading..'),
          );
        }
        return ListView(
          padding: const EdgeInsets.only(top: 8),
          children: snapshot.data!
              .map<Widget>((userData) => _buildUserItem(userData, context))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserItem(Map<String, dynamic> userData, BuildContext context) {
    return UserTile(
      text: userData['name'] ?? userData['email'],
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receiverEmail: userData['name'] ?? userData['email'],
                receiverId: userData['uid'],
              ),
            ));
      },
    );
  }
}
