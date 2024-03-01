import 'dart:math';
import 'dart:typed_data';
import 'package:starwish/models/usermodel.dart';
import 'package:starwish/providers/storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main page/navigation.dart';


class Edit3 extends StatefulWidget {
  String name;
  String email;
  String credintials;
  String state;

  Edit3(
      {Key? key, required this.name, required this.credintials, required this.state, required this.email,})
      : super(key: key);

  @override
  State<Edit3> createState() => _Edit3State();
}

class _Edit3State extends State<Edit3> {


  Uint8List? file;
  String Pic_link = " ";
  String Bio = " ";
  String Age = " ";
  String Gender = " ";
  String starwish_Level = " ";
  int Draw = 0;
  int Lose = 0;
  int Won = 0;
  int Game = 0;
  String Language = " ";
  String Location = " ";
  String Code = " ";
  String Talk = " ";
  String Lat = " ";
  String Lon = " ";
  String lastlogin = " ";
  String lastloginn = " ";

  final List<String> talk = [
    'Average talker',
    'Extrovert',
    'Introvert',
  ];
  String? talkv;

  final List<String> gender = [
    'Male',
    'Female',
    'Transgender',
    'Other LGBTGA+'
  ];
  String? genderv;

  final List<String> week = [
    'Begineer',
    'Intermediate',
    'Advance',
    'Master'
  ];
  String? weekv;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffff79ac),
        automaticallyImplyLeading: false,
        title: Center(child: Text("We need few more details",
            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18))),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 10,
            ),
            Center(
              child: InkWell(

                  child: file == null ? Stack(
                    children: [
                      CircleAvatar(
                        radius: 85,
                        backgroundImage: NetworkImage(
                            "https://t3.ftcdn.net/jpg/05/17/79/88/360_F_517798849_WuXhHTpg2djTbfNf0FQAjzFEoluHpnct.jpg"),
                      ),
                      Positioned(
                        left: 10,
                        child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(Icons.edit, color: Colors.green)),
                      )
                    ],
                  ) : CircleAvatar(
                    radius: 85,
                    backgroundImage: MemoryImage(file!),
                  )
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.streetAddress,
                decoration: InputDecoration(
                  labelText: 'Your Address', isDense: true,
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {

                  });
                },
              ),
            ), // Adress
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width / 2 - 50,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Your Age', isDense: true,
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      Age = value;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: "Language you Speak", isDense: true,
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    Language = value;
                  });
                },
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: "Your Bio", isDense: true,
                  border: OutlineInputBorder(),
                ),
                minLines: 3,
                maxLines: 9,
                onChanged: (value) {
                  setState(() {
                    Bio = value;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey, // Border color
                      width: 1.0, // Border width
                    ),
                    color: Color(0xffff79ac),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      // specify the radius for the top-left corner
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      // specify the radius for the top-right corner
                    ),
                  ),
                  child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width - 40,
                      child: TextButton.icon(
                          onPressed: () async {

                            try{
                              int g = m();
                              String h = g.toString();
                              int millisecondsSinceEpoch = DateTime.now().millisecondsSinceEpoch;
                              String po = FirebaseAuth.instance.currentUser!.uid ;

                              // Convert milliseconds since epoch to DateTime object
                              DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
                              final SharedPreferences prefs = await SharedPreferences.getInstance();
                              await prefs.setString('State', widget.state );
                              UserModel user = UserModel(
                                Email: widget.email, Chess_Level: starwish_Level, State : widget.state,
                                Name: widget.name, Pic_link: Pic_link, Bio: Bio, Draw: 0, Gender: Gender, Language: Language,
                                Location: Location, Lose: 0, Talk: Talk, Won: 0, uid: po, age: Age, Lat: 22.2661556,
                                lastlogin:  "hh", Lon: 84.9088836, lastloginn: millisecondsSinceEpoch.toString(), code: h,);

                              await FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(po).set(user.toJson());
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Success'),
                                ),
                              );
                              Navigator.push(
                                      context,
                                      PageTransition(
                                          child: Home(),
                                          type: PageTransitionType.leftToRight,
                                          duration: Duration(milliseconds: 800)));
                            }catch(e){
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      '${e}'),
                                ),
                              );
                            }




                          },
                          icon: Icon(
                              CupertinoIcons.arrow_down_right_arrow_up_left,
                              color: Colors.black),
                          label: Text(" Proceed ",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black))))),
            ),
          ],
        ),
      ),
    );
  }

/* Future<void> f() async {
    String h2 = "https://t3.ftcdn.net/jpg/05/17/79/88/360_F_517798849_WuXhHTpg2djTbfNf0FQAjzFEoluHpnct.jpg" ;
    if(file != null){
      */ /* String photoUrl =  await StorageMethods().uploadImageToStorage('users', file!, true);*/ /*
      setState(() {
        */ /* h2 = photoUrl;*/ /*
      });
    }
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .update({
        "Name": name1,
        "Pic_link" : h2,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Profile Pic updated"),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Welcome ${name1}"),
        ),
      );
      */ /*Navigator.push(
          context,
          PageTransition(
              child: Navigation(),
              type: PageTransitionType.rightToLeft,
              duration: Duration(milliseconds: 800)));*/ /*
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("$e"),
        ),
      );
      print(e);
    }
  }*/
  int m() {
    var intValue = Random().nextInt(9999);
    return intValue;
  }



}
