import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_chat_app/service/chat/chat_service.dart';
import 'package:my_chat_app/widget/chat_bubble.dart';
import 'package:my_chat_app/widget/my_text_field.dart';

class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverId;
  const ChatPage(
      {super.key, required this.receiverEmail, required this.receiverId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ChatService chatService = ChatService();
  final TextEditingController messageController = TextEditingController();
  final FocusNode myFocusNode = FocusNode();
  final GlobalKey<MyListMessageState> listMessageKey = GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        Future.delayed(
          const Duration(milliseconds: 500),
          () => listMessageKey.currentState?.scrollDown(),
        );
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    myFocusNode.dispose();
    messageController.dispose();
    super.dispose();
  }

  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      await chatService.sendMessage(widget.receiverId, messageController.text);
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverEmail),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.call,
                color: Theme.of(context).colorScheme.surface,
              ))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
                stream: chatService.getMessage(widget.receiverId),
                builder: (context, snapshot) {
                  print('new data');
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
                  return MyListMessage(
                    docs: snapshot.data!.docs,
                    key: listMessageKey,
                  );
                }),
          ),
          const SizedBox(
            height: 4,
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 8, bottom: 25),
      child: Row(
        children: [
          Expanded(
              child: MyTextField(
            focusNode: myFocusNode,
            hintText: 'Message',
            controller: messageController,
            obscureText: false,
          )),
          const SizedBox(
            width: 2,
          ),
          IconButton(
              onPressed: sendMessage,
              icon: Icon(
                Icons.send,
                color: Colors.green.shade600,
                size: 30,
              ))
        ],
      ),
    );
  }
}

class MyListMessage extends StatefulWidget {
  final List<QueryDocumentSnapshot<Object?>> docs;
  const MyListMessage({super.key, required this.docs});

  @override
  State<MyListMessage> createState() => MyListMessageState();
}

class MyListMessageState extends State<MyListMessage> {
  final ScrollController _scrollController = ScrollController();

  void scrollDown() {
    print('scroll down');
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
      const Duration(milliseconds: 500),
      () => scrollDown(),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('build message');
    Future.delayed(
      const Duration(milliseconds: 500),
      () => scrollDown(),
    );

    return ListView(
        controller: _scrollController,
        children: widget.docs.map((doc) => _buildMessageItem(doc)).toList());
  }

  Widget _buildMessageItem(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    bool isCurrentUser =
        data['senderId'] == FirebaseAuth.instance.currentUser!.uid;
    return Container(
        alignment: isCurrentUser
            ? AlignmentDirectional.centerEnd
            : AlignmentDirectional.centerStart,
        child: ChatBubble(
          text: data['message'],
          isCurrentUser: isCurrentUser,
        ));
  }
}
