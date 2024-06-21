import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_chat_app/models/message.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection('Users').snapshots().map(
      (snapshot) {
        return snapshot.docs.map((doc) {
          final user = doc.data();
          return user;
        }).toList();
      },
    );
  }

  Future<void> sendMessage(String receiverId, String message) async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();
    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join('_');
    Message newMessage = Message(
        senderId: currentUserId,
        senderEmail: currentUserEmail,
        receiverId: receiverId,
        message: message,
        timestamp: timestamp);
    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  Stream<QuerySnapshot> getMessage(String otherUserId) {
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    List<String> ids = [currentUserId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join('_');
    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
