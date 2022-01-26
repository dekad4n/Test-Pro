import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testpro/routes/register/screens/signin.dart';
import 'package:testpro/routes/register/screens/signup.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final List<bool> _selected = [true, false];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BackButton(
              onPressed: () => Navigator.of(context).pop(),
            ),
            SizedBox(height: MediaQuery.of(context).size.height/16,),
            Center(
              child: Container(

                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: Colors.blueGrey[100]

                ),
                child: ToggleButtons(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width*5/12,
                    minHeight: 40.0,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  renderBorder: false,
                  selectedBorderColor: Colors.black,
                  fillColor: Colors.blueGrey[100],

                  onPressed: (int idx){
                    setState(() {
                      if((idx == 0 && _selected[1]) || (idx == 1 && _selected[0])) {
                        _selected[idx] = !_selected[idx];
                        _selected[(idx + 1) % 2] = !_selected[(idx + 1) % 2];
                      }
                    });
                  },
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width*4.9/12,
                      height: 38,
                      decoration: BoxDecoration(
                          color: _selected[0] ? Colors.white : Colors.blueGrey[100],
                          borderRadius: const BorderRadius.all(Radius.circular(10))
                      ),
                      child: Center(
                        child: Text(
                          "Sign up",
                          style: GoogleFonts.raleway(
                              color: _selected[0] ? Colors.black : Colors.white
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width*4.9/12,
                      height: 38,
                      decoration: BoxDecoration(
                          color: _selected[1] ? Colors.white : Colors.blueGrey[100],
                          borderRadius: const BorderRadius.all(Radius.circular(10))
                      ),
                      child: Center(
                        child: Text(
                          "Sign in",
                          style: GoogleFonts.raleway(
                              color: _selected[1] ? Colors.black : Colors.white
                          ),
                        ),
                      ),
                    ),
                  ],
                  isSelected: _selected,
                ),
              ),
            ),
            if(_selected[0])
              SignUp(registerContext: context,)
            else
              const SignIn()

          ],
        ),
      ),
    );
  }
}
