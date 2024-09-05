import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_chat_app/models/user_model.dart';

class UserService {
  UserService._();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static UserService? _instance;
  static UserService get instance => _instance ??= UserService._();

  Future<UserModel> getUserProfile(String uid) async {
    DocumentSnapshot user = await _firestore.collection('Users').doc(uid).get();
    return UserModel(
        uid: user['uid'], email: user['email'], name: user['name']);
  }

  void setUserProfile(String uid, UserModel userModel) async {
    await _firestore.collection('Users').doc(uid).set(userModel.toJson());
  }

  Future<void> updateUserName(String uid, String name) async {
    await _firestore.collection('Users').doc(uid).update({'name': name});
  }
}
