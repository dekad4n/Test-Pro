
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:testpro/services/database.dart';
import 'package:testpro/utils/styles.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({Key? key}) : super(key: key);

  @override
  _PersonalInfoState createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  final PageController _pc = PageController(initialPage: 0);
  int ctr = 0;
  List<bool> selected = [false, false];
  Database db = Database();

  Widget nextButton(String userId)
  {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 2*MediaQuery.of(context).size.height/24,
      height: MediaQuery.of(context).size.height/16,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.blue[900],
          ),
          onPressed: () {
            setState(() {
              if(ctr != 3)
                {
                  if(ctr == 0 && !selected[0] && !selected[1])
                    {
                      // THROW A MESSAGE
                    }
                  else {
                    ctr++;
                    _pc.jumpToPage(ctr);
                  }
                }
              else{
                db.setSex(userId, selected[1]);
                db.setAge(userId, ageSelected);
                db.setLength(userId, lengthSelected, !cm);
                db.setWeight(userId, weightSelected);
                Navigator.pushNamed(context, '/feed');
              }
            });
          },
          child: Text(
            "Next",
            style: buttonWhiteStyle,
          )
      ),
    );
  }

  Widget dots(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: MediaQuery.of(context).size.width*4/11,),
        for(int i = 0 ; i < 4; i++)
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.all(3,),
              height: 8,
              width: 8,
              decoration: BoxDecoration(
                  color: i == ctr ? Colors.grey[700]: Colors.grey[400],
                  borderRadius: const BorderRadius.all(Radius.circular(10))
              ),
            ),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _pc,
      children: [
        sexChoose(user!.uid),
        age(user.uid),
        length(user.uid),
        weight(user.uid),
      ],
    );
  }
  Widget sexChoose(String userId){
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
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/20
                  ,vertical: MediaQuery.of(context).size.height/20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height/10
                  ),
                  Center(
                    child: Text(
                      "What is your sex?",
                      style: personalInfoStyle
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height/5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Container(
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.white,
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.grey[500]!,
                                    blurRadius: 2.0,
                                    spreadRadius: 2.2,
                                    offset: const Offset(-2.0, 2.0), // shadow direction: bottom right
                                  )
                                ],
                              ),
                              child: IconButton(
                                onPressed: (){
                                  setState(() {
                                    selected[0] = true;
                                    selected[1] = false;
                                  });

                                },
                                iconSize: MediaQuery.of(context).size.width*1/3,
                                splashRadius: MediaQuery.of(context).size.width*1/6,
                                icon: Icon(
                                 Icons.female,
                                 color: selected[0] ? Colors.red : Colors.grey[500],
                                 size: MediaQuery.of(context).size.width*1/3  ,
                                ),
                              )
                          ),
                          Text(
                            "Woman",
                            style: registerStyleGrey,
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.white,
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.grey[500]!,
                                    blurRadius: 2.0,
                                    spreadRadius: 2.2,
                                    offset: const Offset(-2.0, 2.0), // shadow direction: bottom left
                                  )
                                ],
                              ),
                              child: IconButton(
                                onPressed: (){
                                  setState(() {
                                    selected[0] = false;
                                    selected[1] = true;
                                  });

                                },
                                iconSize: MediaQuery.of(context).size.width*1/3,
                                splashRadius: MediaQuery.of(context).size.width*1/6,
                                icon: Icon(
                                  Icons.male,
                                  color: selected[1] ? Colors.green[900]: Colors.grey[500],
                                  size: MediaQuery.of(context).size.width*1/3  ,
                                ),
                              )
                          ),

                          Text(
                            "Men",
                            style: registerStyleGrey,
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height/12,
                  ),
                  nextButton(userId),
                  SizedBox(height: MediaQuery.of(context).size.height/24),
                  dots()

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  int ageSelected = 38;
  ScrollController ageController = FixedExtentScrollController(initialItem: 20);
  Widget age(String userId){
    List<Widget> items = [];
    for(int i = 18  ; i  < 75 ; i++)
      {
        items.add(
          ListTile(
            leading: Text(
              i.toString(),
            ),
            selectedColor: Colors.black,
            textColor: ageSelected ==i ? Colors.black : Colors.grey[500],
          )
        );
      }
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).size.height/40,
            left: 0,
            child: BackButton(
              onPressed: (){
                ctr--;
                _pc.jumpToPage(ctr-1);
              },
            ),
          ),
          Positioned(
            top:MediaQuery.of(context).size.height/4,
              left: MediaQuery.of(context).size.width*3/11,
            child: Text(
              "How old are you?",
              style: personalInfoStyle,
            )
          ),
          Positioned(
            top: MediaQuery.of(context).size.height*1/2,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Divider(
                thickness: 3,
                color: Colors.grey[500],
              ),
            )
          ),
          Positioned(
            top:MediaQuery.of(context).size.height*1/3,
            left: MediaQuery.of(context).size.width*3/7,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height/2,
                  width: MediaQuery.of(context).size.width/6,
                  child: ListWheelScrollView(
                    controller: ageController,
                    itemExtent: 75,
                    useMagnifier: true,
                    magnification: 1.5,
                    diameterRatio: 2,
                    children: items,
                    onSelectedItemChanged: (index)
                    {
                      setState(() {
                        ageSelected = index+18;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              top: MediaQuery.of(context).size.height*9/15,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Divider(
                  thickness: 3,
                  color: Colors.grey[500],
                ),
              )
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height/20,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/20
                  ,vertical: MediaQuery.of(context).size.height/20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  nextButton(userId),

                ],
              ),
            )
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height/24,
            left: MediaQuery.of(context).size.width/19,
              child: dots()
          )
        ],
      ),
    );
  }

  double lengthSelected = 150;
  bool cm = true;
  ScrollController lengthController = FixedExtentScrollController(initialItem: 50);
  Widget length(String userId){
    List<Widget> items = [];
    if(cm) {
      for (double i = 100; i < 210; i++) {
        items.add(
            ListTile(
              leading: Text(
                i.toString(),
              ),
              selectedColor: Colors.black,
              textColor: lengthSelected == i? Colors.black : Colors.grey[500],
            )
        );
      }
    }else{
      for (double i = 32; i < 69; i++) {
        items.add(
            ListTile(
              leading: Text(
                (i/10).toString(),
              ),
              selectedColor: Colors.black,
              textColor: lengthSelected == i /10 ? Colors.black : Colors.grey[500],
            )
        );
      }
    }
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).size.height/40,
            left: 0,
            child: BackButton(
              onPressed: (){
                setState(() {
                  ctr--;
                  _pc.jumpToPage(ctr);


                });
              },
            ),
          ),
          Positioned(
              top:MediaQuery.of(context).size.height/4,
              left: MediaQuery.of(context).size.width*2/11,
              child: Text(
                "How much is your length?",
                style: personalInfoStyle,
              )
          ),
          Positioned(
              top: MediaQuery.of(context).size.height*1/2,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Divider(
                  thickness: 3,
                  color: Colors.grey[500],
                ),
              )
          ),
          Positioned(
              top: MediaQuery.of(context).size.height*20.5/39,
              right: MediaQuery.of(context).size.width/28,
              child: SizedBox(
                child: Text(
                  cm ? "cm" : "ft",
                  style: GoogleFonts.raleway(
                    fontSize: 32,
                    color: Colors.black,

                  ),
                ),
              )
          ),
          Positioned(
            top:MediaQuery.of(context).size.height*1/3,
            left: MediaQuery.of(context).size.width*3/7,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height/2,
                  width: MediaQuery.of(context).size.width/6,
                  child: ListWheelScrollView(
                    controller: lengthController,
                    itemExtent: 75,
                    useMagnifier: true,
                    magnification: 1.5,
                    diameterRatio: 2,
                    children: items,
                    onSelectedItemChanged: (index)
                    {
                      setState(() {
                        if(cm) {
                          lengthSelected = index+ 100;
                        }
                        else{
                          lengthSelected = (index + 32)/10;
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              top: MediaQuery.of(context).size.height*3/5,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Divider(
                  thickness: 3,
                  color: Colors.grey[500],
                ),
              )
          ),
          Positioned(
              top: MediaQuery.of(context).size.height*25/39,
              right: MediaQuery.of(context).size.width/28 ,
              child: SizedBox(
                child: Text.rich(
                  TextSpan(
                    text: cm ? "ft" : "cm",
                    style: GoogleFonts.raleway(
                      fontSize: 32,
                      color: Colors.grey[500],
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        setState(() {
                          cm = !cm;
                          lengthController.jumpTo(0);
                          lengthSelected = cm ? 100 : 3.2;
                        });
                      }
                  ),
                )
              )
          ),
          Positioned(
              bottom: MediaQuery.of(context).size.height/20,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/20
                    ,vertical: MediaQuery.of(context).size.height/20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    nextButton(userId),

                  ],
                ),
              )
          ),
          Positioned(
              bottom: MediaQuery.of(context).size.height/24,
              left: MediaQuery.of(context).size.width/19,
              child: dots()
          )
        ],
      ),
    );
  }

  int weightSelected = 90;
  ScrollController weightController = FixedExtentScrollController(initialItem: 21);
  Widget weight(String userId){
    List<Widget> items = [];
    for (int i = 40; i < 210; i++) {
      items.add(
          ListTile(
            leading: Text(
              i.toString(),
            ),
            selectedColor: Colors.black,
            textColor: weightSelected == i? Colors.black : Colors.grey[500],
          )
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).size.height/40,
            left: 0,
            child: BackButton(
              onPressed: (){
                setState(() {
                  ctr--;
                  _pc.jumpToPage(ctr);


                });
              },
            ),
          ),
          Positioned(
              top:MediaQuery.of(context).size.height/4,
              left: MediaQuery.of(context).size.width*2/11,
              child: Text(
                "How much is your weight?",
                style: personalInfoStyle,
              )
          ),
          Positioned(
              top: MediaQuery.of(context).size.height*1/2,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Divider(
                  thickness: 3,
                  color: Colors.grey[500],
                ),
              )
          ),
          Positioned(
              top: MediaQuery.of(context).size.height*20.5/39,
              right: MediaQuery.of(context).size.width/28,
              child: SizedBox(
                child: Text(
                  "kg",
                  style: GoogleFonts.raleway(
                    fontSize: 32,
                    color: Colors.black,
                  ),
                ),
              )
          ),
          Positioned(
            top:MediaQuery.of(context).size.height*1/3,
            left: MediaQuery.of(context).size.width*3/7,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height/2,
                  width: MediaQuery.of(context).size.width/6,
                  child: ListWheelScrollView(
                    controller: lengthController,
                    itemExtent: 75,
                    useMagnifier: true,
                    magnification: 1.5,
                    diameterRatio: 2,
                    children: items,
                    onSelectedItemChanged: (index)
                    {
                      setState(() {
                        weightSelected = index+ 40;

                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              top: MediaQuery.of(context).size.height*3/5,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Divider(
                  thickness: 3,
                  color: Colors.grey[500],
                ),
              )
          ),

          Positioned(
              bottom: MediaQuery.of(context).size.height/20,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/20
                    ,vertical: MediaQuery.of(context).size.height/20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    nextButton(userId),
                  ],
                ),
              )
          ),
          Positioned(
              bottom: MediaQuery.of(context).size.height/24,
              left: MediaQuery.of(context).size.width/19,
              child: dots()
          )
        ],
      ),
    );
  }

}
