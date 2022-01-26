import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:testpro/routes/register/screens/name_screen.dart';
import 'package:testpro/services/auth.dart';
import 'package:testpro/utils/styles.dart';
import 'package:testpro/utils/texts.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUp extends StatefulWidget {
  final BuildContext registerContext;
  const SignUp({Key? key, required this.registerContext}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _key = GlobalKey<FormState>();

  bool _passwordVisible = false;
  bool _emailPasswordVisible = false;

  String mail = "";
  TextEditingController password = TextEditingController();
  TextEditingController passwordAgain  = TextEditingController();

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
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
                      minHeight: 16,
                      maxHeight: 48,
                    ),
                    border: enabledBorderStyle,
                    enabledBorder: enabledBorderStyle
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null) {
                    return "E-mail cannot be empty";
                  }
                  else {
                    String trimmedValue = value.trim();
                    if (trimmedValue.isEmpty) {
                      return "E-mail cannot be empty";
                    }
                    if (!EmailValidator.validate(trimmedValue)) {
                      return "Please enter a valid email";
                    }
                  }
                  return null;
                },
                onSaved: (value) {
                  if (value != null) {
                    mail = value;
                  }
                }
            ),
            const SizedBox(height: 16,),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "Create Password",
                style: registerStyle,
              ),
            ),
            const SizedBox(height: 8,),
            TextFormField(
              controller: password,
              obscureText: !_emailPasswordVisible,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                  border: enabledBorderStyle,
                  constraints: const BoxConstraints(
                    minHeight: 16,
                    maxHeight: 48,
                  ),
                  enabledBorder: enabledBorderStyle,
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _emailPasswordVisible = !_emailPasswordVisible;
                        });
                      },
                      icon: Icon(
                          _emailPasswordVisible ? Icons.visibility : Icons
                              .visibility_off
                      )
                  )
              ),
              keyboardType: TextInputType.visiblePassword,
              validator: (value) {
                if (value == null) {
                  return "Password cannot be empty";
                }
                else {
                  String trimmedValue = value.trim();
                  if (trimmedValue.isEmpty) {
                    return "Password field cannot be empty";
                  }
                  if (trimmedValue.length < 8) {
                    return "Password must be at least 8 characters long";
                  }
                }
                return null;
              },
            ),
            const SizedBox(height: 16,),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "Re-write Password",
                style: registerStyle,
              ),
            ),
            const SizedBox(height: 8,),
            TextFormField(
              controller: passwordAgain,
              obscureText: !_passwordVisible,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                  border: enabledBorderStyle,
                  constraints: const BoxConstraints(
                    minHeight: 16,
                    maxHeight: 48,
                  ),
                  enabledBorder: enabledBorderStyle,
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                      icon: Icon(
                          _passwordVisible ? Icons.visibility : Icons
                              .visibility_off
                      )
                  )
              ),
              keyboardType: TextInputType.visiblePassword,
              validator: (value) {
                if (value == null) {
                  return "Password cannot be empty";
                }
                else {
                  String trimmedValue = value.trim();
                  if (trimmedValue.isEmpty) {
                    return "Password field cannot be empty";
                  }
                  if (password.text != passwordAgain.text) {
                    return "Passwords do not match";
                  }
                }
                return null;
              },

            ),
            SizedBox(height: MediaQuery
                .of(context)
                .size
                .height / 14,),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    termsOfUseFirst,
                    textAlign: TextAlign.start,
                    style: registerStyleGrey,
                  ),
                  RichText(
                      text: TextSpan(
                          children: [
                            TextSpan(
                                text: termsOfUseSecondP1,
                                style: registerStyleGrey
                            ),
                            TextSpan(
                              text: ' Terms of use ',
                              style: registerStyleBlue,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  launch("https://developer.moneris.com/More/Compliance/Sample%20Terms%20of%20Use");
                                }
                            ),
                            TextSpan(
                                text: termsOfUseSecondP2,
                                style: registerStyleGrey
                            )
                          ]
                      )
                  ),
                  Center(
                    child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            children: [
                              TextSpan(
                                  text: termsOfUseThirdP1,
                                  style: registerStyleGrey
                              ),
                              TextSpan(
                                  text: ' Privacy Notice',
                                  style: registerStyleBlue,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      launch("https://www.privacypolicies.com/blog/privacy-policy-template/");
                                    }
                              ),
                              TextSpan(
                                  text: termsOfUseThirdP2,
                                  style: registerStyleGrey
                              )
                            ]
                        )
                    ),
                  )

                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.blueGrey[100],
                          minimumSize: const Size.fromHeight(48)
                      ),
                      onPressed: () async {
                        if (_key.currentState!.validate()) {
                          _key.currentState!.save();
                          await _auth.signUpWithMailAndPassword(
                              mail, password.text);
                          Navigator.push(context,
                              MaterialPageRoute(builder:
                                  (context) => const NameScreen()
                              )
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
