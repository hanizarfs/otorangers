import 'package:flutter/material.dart';
import 'package:otoranger/auth.dart';
import 'package:otoranger/screens/auth/login.dart';
import 'package:otoranger/screens/ranger/home.dart';
import 'package:otoranger/screens/jager/home.dart';
import 'package:otoranger/screens/ranger/workshop_outlet/index.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Add loading indicator if needed
        }

        if (snapshot.hasData) {
          return FutureBuilder(
            future: Auth().getUserRole(snapshot.data!.uid),
            builder: (context, roleSnapshot) {
              if (roleSnapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(); // Add loading indicator if needed
              }

              if (roleSnapshot.hasData) {
                String userRole = roleSnapshot.data as String;
                if (userRole == 'Ranger - Pemilik Bengkel') {
                  // return RangerHomePage();
                  return WorkshopOutletListPage();
                } else {
                  // return WorkshopList();
                  return JagerHomePage();
                }
              } else {
                return Text('Error getting user role');
              }
            },
          );
        } else {
          return LoginPage();
        }
      },
    );
  }
}
