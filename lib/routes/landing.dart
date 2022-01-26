import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:testpro/routes/register/screens/signin.dart';
import 'package:testpro/services/auth.dart';
import 'package:testpro/utils/dimensions.dart';
import 'package:testpro/utils/styles.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  Dimension dim = Dimension();
  final AuthService _auth = AuthService();

  bool isAnon = false;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    if(user == null) {
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo
            SizedBox(height: MediaQuery.of(context).size.height/6,),

            Padding(
              padding: dim.regularPaddingAll,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Test Pro",
                    style: GoogleFonts.dancingScript(
                      color: Colors.teal,
                      fontSize: 84
                    ),
                  ),
                  const SizedBox(height: Dimension.heightPadding),
                  Text(
                    'Welcome to Test Pro! Test pro is a fitness app that helps you to improve your fitness skills.',
                    style: appDescription,
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height/12,),

            Container(
              padding: dim.minimalPaddingHorizontal,
              width: MediaQuery
                  .of(context)
                  .size
                  .width*2/3,
              child: ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/register'),

                child: Row(
                  children: const <Widget>[
                    Icon(
                      Icons.mail,
                      color: Colors.blueGrey,
                    ),
                    SizedBox(width: 8.0,),
                    Text(
                      "Continue with mail",
                      style: TextStyle(
                        color: Colors.black87
                      ),
                    ),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white
                ),

              ),
            ),

            Container(
              padding: dim.minimalPaddingHorizontal,
              width: MediaQuery
                  .of(context)
                  .size
                  .width*2/3,
              child: ElevatedButton(
                onPressed: (){
                  _auth.signInWithGoogle();
                },
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: Image.network(
                          "https://upload.wikimedia.org/wikipedia/commons/thumb/8/8c/Gmail_Icon_%282013-2020%29.svg/1024px-Gmail_Icon_%282013-2020%29.svg.png",
                        ),
                    ),
                    const SizedBox(width: 8.0,),

                    const Text(
                      "Continue with google",
                      style: TextStyle(
                        color: Colors.black87
                      ),
                    ),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white
                ),
              )
            ),
            Container(
              padding: dim.regularPaddingHorizontal,
              width: MediaQuery
                  .of(context)
                  .size
                  .width*2/3,
              child: ElevatedButton(
                onPressed: () {
                  _auth.signInWithFacebook();
                },
                  child: Row(
                  children: const <Widget>[
                    Icon(
                        Icons.facebook,
                      color: Colors.white,
                    ),
                    SizedBox(width: 8.0,),

                    Text(
                      "Continue with facebook",
                      style: TextStyle(
                        color: Colors.white
                      ),
                    )
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue
                ),
              ),
            ),
            Container(
              padding: dim.regularPaddingHorizontal, 
              width: MediaQuery
                  .of(context)
                  .size
                  .width*2/3,
              child: ElevatedButton(
                onPressed: (){
                  _auth.anonSignIn();
                  Navigator.pushNamed(context, '/feed');
                },
                child: const Text(
                    "Continue without signing up"
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueGrey
                ),
              ),
            ),
          ],
        ),
      );
    }
    return const LoginInitialize();
  }
}
