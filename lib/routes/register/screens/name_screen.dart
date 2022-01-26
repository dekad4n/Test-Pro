import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:testpro/routes/register/screens/personal_info.dart';
import 'package:testpro/services/database.dart';
import 'package:testpro/utils/styles.dart';

class NameScreen extends StatefulWidget {
  const NameScreen({Key? key}) : super(key: key);

  @override
  _NameScreenState createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  String name = "";
  final _key = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BackButton(
              onPressed: () => Navigator.of(context).pop(),
            ),
            Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.height/24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height/4,),
                  Text(
                    "Your Name?",
                    style: GoogleFonts.raleway(
                      color: Colors.black,
                      fontSize: 32,
                      fontWeight: FontWeight.w500

                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/10,),
                  Form(
                    key : _key,
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: "Your Name",
                          hintStyle: registerStyleGrey,
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey[400]!
                              )
                          )
                      ),
                      onSaved: (value){
                        if(value != null)
                        {
                          name = value;
                        }
                      },
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/4,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 2*MediaQuery.of(context).size.height/24,
                    height: MediaQuery.of(context).size.height/16,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue[900],
                      ),
                      onPressed: () {
                        _key.currentState!.save();
                        Database().setName(user!.uid, name);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PersonalInfo()
                            )
                        );
                      },
                      child: Text(
                        "Continue",
                        style: buttonWhiteStyle,
                      )
                    ),
                  )

                ],
              ) ,
            )


          ],
        ),
      ),
    );
  }
}

