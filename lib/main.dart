import 'package:flutter/material.dart';
import 'package:testpro/routes/feed.dart';
import 'package:testpro/routes/landing.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:testpro/routes/register/register.dart';
import 'package:testpro/services/auth.dart';
import 'package:testpro/utils/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AppBase());
}

class AppBase extends StatefulWidget {
  const AppBase({Key? key}) : super(key: key);

  @override
  _AppBaseState createState() => _AppBaseState();
}

class _AppBaseState extends State<AppBase> {
  final Future<FirebaseApp> _init = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _init,
      builder: (context, snapshot)
        {
          if(snapshot.hasError)
            {
              return MaterialApp(
                home: Scaffold(
                  body: Center(
                    child: Text(
                      "Connection Error!",
                      style: errorStyle,
                    ),
                  ),
                ),
              );
            }
          else if(snapshot.connectionState == ConnectionState.done)
            {
              return StreamProvider<User?>.value(
                initialData: null,
                value: AuthService().user,
                child: MaterialApp(
                  title: "Test Pro",
                  home: const LandingPage(),
                  routes: {
                    '/register': (context) => const Register(),
                    '/feed': (context) => const Feed()
                  },
                ),
              );
            }
          else{
            return const MaterialApp(
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }
        }
    );
  }
}

