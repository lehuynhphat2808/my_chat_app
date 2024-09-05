import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_chat_app/models/user_model.dart';
import 'package:my_chat_app/service/user/user_service.dart';
import 'package:my_chat_app/widget/my_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late UserModel userModel;

  void handleClick(int item, BuildContext context) {
    TextEditingController nameController =
        TextEditingController(text: userModel.name ?? userModel.email);
    switch (item) {
      case 0:
        showDialog(
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: const Color(0xffebbeca),
                scrollable: true,
                title: Text(
                  'Update Profile',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.w800),
                ),
                content: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.surface),
                          controller: nameController,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.account_box,
                              color: Theme.of(context).colorScheme.surface,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [
                  MyButton(
                    text: 'Submit',
                    onTap: () async {
                      await UserService.instance
                          .updateUserName(userModel.uid!, nameController.text);
                      setState(() {});
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    },
                  )
                ],
              );
            },
            context: context);

        break;
      case 1:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: UserService.instance
          .getUserProfile(FirebaseAuth.instance.currentUser!.uid),
      builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
        if (snapshot.hasData) {
          userModel = snapshot.data!;
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            appBar: AppBar(
              title: const Text('Profile'),
              actions: [
                PopupMenuButton(
                  onSelected: (value) {
                    handleClick(value, context);
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem<int>(
                      value: 0,
                      child: Text(
                        'Update Profile',
                      ),
                    ),
                  ],
                )
              ],
            ),
            body: Container(
              color: Theme.of(context).colorScheme.tertiary,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 300,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(16),
                                bottomRight: Radius.circular(16)),
                            child: FadeInImage(
                              fit: BoxFit.cover,
                              placeholder: const AssetImage(
                                  'assets/images/background.jpg'),
                              imageErrorBuilder: (context, error, stackTrace) =>
                                  Image.asset(
                                'assets/images/background.jpg',
                                fit: BoxFit.cover,
                              ),
                              image: const NetworkImage(
                                'assets/images/background.jpg',
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(120),
                                child: FadeInImage(
                                  height: 120,
                                  width: 120,
                                  fit: BoxFit.cover,
                                  placeholder:
                                      const AssetImage('assets/images/avt.jpg'),
                                  imageErrorBuilder:
                                      (context, error, stackTrace) =>
                                          Image.asset(
                                    'assets/images/avt.jpg',
                                    height: 120,
                                    width: 120,
                                    fit: BoxFit.cover,
                                  ),
                                  image: const NetworkImage(
                                    'assets/images/avt.jpg',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    userModel.name ?? userModel.email!,
                    style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
