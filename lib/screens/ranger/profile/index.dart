import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:otoranger/auth.dart';

class ProfileTabPage extends StatefulWidget {
  @override
  _ProfileTabPageState createState() => _ProfileTabPageState();
}

class _ProfileTabPageState extends State<ProfileTabPage> {
  final User? user = Auth().currentUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Profile',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('users')
                .doc(user?.uid)
                .get(),
            builder:
                (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              if (snapshot.connectionState == ConnectionState.done) {
                var userData = snapshot.data?.data() as Map<String, dynamic>;
                var username = userData['username'] ?? 'Username Tidak Tersedia';
                var email = userData['email'] ?? 'Email Tidak Tersedia';
                var role = userData['role'] ?? 'Role Tidak Tersedia';

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Username: $username'),
                    Text('Email: $email'),
                    Text('Role: $role'),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Implement signout logic
                        Auth().signOut();
                        Navigator.of(context).pop(); // Close the profile page
                      },
                      child: Text('Sign Out'),
                    ),
                  ],
                );
              }

              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ],
      ),
    );
  }
}
