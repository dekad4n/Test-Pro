import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:testpro/routes/feed.dart';
import 'package:testpro/routes/register/screens/name_screen.dart';
import 'package:testpro/routes/register/screens/personal_info.dart';
import 'package:testpro/services/auth.dart';
import 'package:testpro/services/database.dart';
import 'package:testpro/utils/styles.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _key = GlobalKey<FormState>();

  String mail = "";
  String password = "";

  @override


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "Email",
                style: registerStyle,
              ),
            ),
            const SizedBox(height: 8,),
            TextFormField(
                decoration: InputDecoration(
                    constraints: const BoxConstraints(
                      minHeight: 48,
                      maxHeight: 48,
                    ),
                    border: enabledBorderStyle,
                    enabledBorder: enabledBorderStyle
                ),

                keyboardType: TextInputType.emailAddress,
                validator: (value){
                  if( value == null )
                  {
                    return "E-mail cannot be empty";
                  }
                  else
                  {
                    String trimmedValue = value.trim();
                    if(trimmedValue.isEmpty)
                    {
                      return "E-mail cannot be empty";
                    }
                    if(!EmailValidator.validate(trimmedValue)){
                      return "Please enter a valid email";
                    }
                  }
                  return null;
                },
                onSaved: (value)
                {
                  if(value != null)
                  {
                    mail = value;
                  }
                }
            ),
            const SizedBox(height: 16,),

            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "Password",
                style: registerStyle,
              ),
            ),
            const SizedBox(height: 8,),
            TextFormField(
              enableSuggestions: false,
              autocorrect: false,
              obscureText: true,
              decoration: InputDecoration(
                  border: enabledBorderStyle,
                  constraints: const BoxConstraints(
                    minHeight: 48,
                    maxHeight: 48,
                  ),
                  enabledBorder: enabledBorderStyle,
              ),
              keyboardType: TextInputType.visiblePassword,
              validator: (value)
              {
                if(value == null)
                {
                  return "Password cannot be empty";
                }
                else
                {
                  String trimmedValue = value.trim();
                  if(trimmedValue.isEmpty)
                  {
                    return "Password field cannot be empty";
                  }
                  if(trimmedValue.length < 8)
                  {
                    return "Password must be at least 8 characters long";
                  }
                }
                return null;
              },
              onSaved: (value)
              {
                if(value != null)
                  {
                    password = value;
                  }
              },
            ),
            const SizedBox(height: 16,),
            Center(
              child: Text.rich(
                TextSpan(
                  text: "Forgot Password?",
                  style: GoogleFonts.raleway(
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                    }
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*3/12,),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.blueGrey[100],
                          minimumSize: const Size.fromHeight(48)
                      ),
                      onPressed: () async{
                        if(_key.currentState!.validate()) {
                          _key.currentState!.save();
                          await AuthService().signInWithMailAndPassword(
                              mail, password, context);
                          Navigator.push(context,
                            MaterialPageRoute(builder: (context) => const LoginInitialize())
                          );
                        }
                      },
                      child: Text(
                        'Continue',
                        style: registerStyle,
                      )
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16,),
          ],
        ),
      ),
    );
  }
}

class LoginInitialize extends StatefulWidget {
  const LoginInitialize({Key? key}) : super(key: key);

  @override
  _LoginInitializeState createState() => _LoginInitializeState();
}

class _LoginInitializeState extends State<LoginInitialize> {

  Future<void> loginInitFunc(User? user) async{
    if(user != null) {
      int state = await Database().isSignupDone(
          user.uid);
      if (state == 0) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const NameScreen()));
      }
      else if (state != 5) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const PersonalInfo()));
      }
      else {
        Navigator.pushNamed(context, '/feed');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    if(!user!.isAnonymous) {
      loginInitFunc(user);
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return const Feed();
  }
}

