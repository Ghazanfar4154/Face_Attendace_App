import 'package:cli/Classes/add_class_details.dart';
import 'package:cli/Classes/view_classes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'Pages/loginScreen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void _logout(BuildContext context) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.disconnect(); // This will revoke the access token
      await FirebaseAuth.instance.signOut(); // Sign out the current user
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
            (route) => false,
      );
      print("signed out successfully");
    } catch (e) {
      // Display an error if sign-out fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to sign out: $e'),
        ),
      );
      print("Not signed out");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
      ListTile(
        leading: Icon(Icons.add),
        title: Text('Add Class'),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddClassDetails()));
        },
      ),
            ListTile(
              leading: Icon(Icons.remove_circle),
              title: Text('Delete Class'),
              onTap: () {

              },
            ),
            ListTile(
              leading: Icon(Icons.class_),
              title: Text('All Classes '),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewClasses()));

              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () {
                _logout(context);
              },
            ),

          ],
        ),
      ),
    );
  }
}
