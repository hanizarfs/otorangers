import "package:firebase_auth/firebase_auth.dart";
import 'package:cloud_firestore/cloud_firestore.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String role,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String userUid = _firebaseAuth.currentUser!.uid;

      // Save user data to Firestore
      await FirebaseFirestore.instance.collection('users').doc(userUid).set({
        'userUUID': userUid,
        'email': email,
        'password': password,
        'role': role,
      });
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'Registration failed';
    }
  }

  // New method to get user role from Firestore
  Future<String?> getUserRole(String uid) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (userDoc.exists) {
        return userDoc.data()?['role'] as String?;
      } else {
        return null;
      }
    } catch (e) {
      print('Error getting user role: $e');
      return null;
    }
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'Sign in failed';
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}