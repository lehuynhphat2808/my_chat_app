import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // instance of auth
  static AuthService? _authService;

  AuthService._();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // instance of firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late UserCredential userCredential;

  static AuthService get instance => _authService ??= AuthService._();

  // sign user in
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      // sign in
      userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  } // sign user up

  Future<UserCredential> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      // sign in
      userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _firestore.collection('Users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': userCredential.user!.email,
        'name': null,
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // sign user out
  Future<void> signOut() async {
    _firebaseAuth.signOut();
  }
}
