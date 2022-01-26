import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testpro/routes/landing.dart';
import 'package:testpro/services/auth.dart';

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    if(user != null) {
      return Scaffold(
        body: Center(
          child: OutlinedButton(
              onPressed: () {
                AuthService().signOut();
              },
              child: const Text("Sign Out!")
          ),
        ),
      );
    }
    return const LandingPage();
  }
}
