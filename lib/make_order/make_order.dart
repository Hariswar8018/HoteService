import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:social_media_buttons/social_media_buttons.dart';
import 'package:starwish/first/login.dart';
import 'package:starwish/main%20page/navigation.dart';
import 'package:starwish/make_order/stless.dart';
import 'package:starwish/models/order.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class Ad1 extends StatefulWidget {
  const Ad1({super.key});

  @override
  State<Ad1> createState() => _Ad1State();
}

class _Ad1State extends State<Ad1> {
  bool b = true;

  final TextEditingController Functionalities = TextEditingController();
  final TextEditingController Help = TextEditingController();
  final TextEditingController Detila = TextEditingController();
  final TextEditingController Date = TextEditingController();
  final TextEditingController Advance = TextEditingController();
  final TextEditingController Other = TextEditingController();
  final TextEditingController Notes = TextEditingController();

  final TextEditingController Mobile = TextEditingController();
  final TextEditingController Email = TextEditingController();
  final TextEditingController Address = TextEditingController();
  final TextEditingController Purpose = TextEditingController();
  final TextEditingController Business = TextEditingController();
  final TextEditingController Business_Details = TextEditingController();
  final TextEditingController GovtId = TextEditingController();
  final TextEditingController GovtId1 = TextEditingController();

  final TextEditingController Name = TextEditingController();

  final TextEditingController Driver = TextEditingController();
  final TextEditingController Other1 = TextEditingController();
  final List<String> a1 = [
    'Simple App',
    'Intermediate App',
    'Advance App',
  ];

  final List<String> a2 = [
    'Animation',
    'Turnaround',
    'Illustration',
  ];

  final List<String> b1 = [
    'Passport',
    'Driving Licenses',
    'VoterId',
    'Other Govt. ID',
  ];

  final List<String> b2 = [
    'Incorporation Certificate',
    'GST',
    'Pan & Tan Card',
  ];

  bool f = false;

  bool i = true;

  bool bu = false;

  int currentStep = 0;
  bool illu = false , ai = false ;
  String? hj, hjk;

  String? hhu;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Create Order", style: TextStyle(color: Colors.white)),
          backgroundColor: Color(0xffff79ac),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Stepper(
          type: StepperType.horizontal,
          steps: getSteps(),
          currentStep: currentStep,
          onStepContinue: () async {
            if (currentStep == 2) {
              String st = "HOTE_ " +
                  DateTime.now().microsecondsSinceEpoch.toString() +
                  "T_U";
              CollectionReference collection =
                  FirebaseFirestore.instance.collection('users');
              String h66 = DateTime.now().toString();
              SessionModel sg = SessionModel(
                  Name: st,
                  id: st,
                  OrderId: st,
                  User_Pic: "h",
                  User_Name: Name.text,
                  User_Phone: Mobile.text,
                  User_Time: "h",
                  U1: "h",
                  U2: "h",
                  progress: 30.9,
                  U3: "h",
                  F1: "h",
                  F2: "h",
                  F3: "h",
                  A1: "h",
                  A2: "h",
                  A3: "h",
                  B1: "h",
                  B2: "h",
                  B3: "h",
                  C1: "h",
                  C2: "h",
                  C3: "h",
                  D1: "h",
                  D2: "h",
                  D3: "h",
                  Last_Update: h66,
                  Update_Status: "In Transit",
                  Update: "In Transit", Email: Email.text, st : 1);
              CollectionReference collection2 = FirebaseFirestore.instance.collection('Orders');

              try {
                String sj = FirebaseAuth.instance.currentUser!.uid;
                await collection
                    .doc(sj)
                    .collection("Orders")
                    .doc(st)
                    .set(sg.toJson());
                await collection2.doc(sj).set(sg.toJson());
                Navigator.push(
                    context,
                    PageTransition(
                        child: Make_O(),
                        type: PageTransitionType.rightToLeft,
                        duration: Duration(milliseconds: 800)));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Thank you, We receive your Order"),
                  ),
                );
              } catch (e) {
                print('${e}');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${e}'),
                  ),
                );
              }
              ;
            }
            setState(() {
              currentStep++;
            });
          },
          onStepCancel: () {
            if (currentStep == 0) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Cancelled"),
                ),
              );
              Navigator.push(
                  context,
                  PageTransition(
                      child: Home(),
                      type: PageTransitionType.rightToLeft,
                      duration: Duration(milliseconds: 800)));
            }
            setState(() {
              currentStep--;
            });
          },
        ));
  }

  List<Step> getSteps() => [
        Step(
          isActive: currentStep >= 0,
          title: Text("Project"),
          content: Column(children: [
            Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: () {
                          gh1();
                          b = true;
                        },
                        child: a(
                            b,
                            "Animation",
                            "assets/0021_3-removebg-preview.png",
                            context)),
                    InkWell(
                        onTap: () {
                          gh1();
                          f = true;
                        },
                        child: a(
                            f,
                            "App Development",
                            "assets/336-3367489_mobile-application-development-mobile-app-development-png-transparent_1-removebg-preview.png",
                            context))
                  ],
                )),
            SizedBox(height: 15),
            Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: () {
                          gh1();
                          illu = true;
                        },
                        child: a(
                            illu,
                            "Illustration",
                            "assets/gaomon-pd-1161-size-removebg-preview.png",
                            context)),
                    InkWell(
                        onTap: () {
                          gh1();
                          ai = true ;
                        },
                        child: a(
                            ai,
                            "Data Science & AI",
                            "assets/ai-robotic-5067057-4257199.png", context))
                  ],
                )),
            SizedBox(height: 15),
            d( 1,
              Detila,
              "Details of Project",
              "Please make it best UI",
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Icon(Icons.question_answer, size: 25, color: Colors.red),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Text("Basic Questions",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Colors.red)),
            ),
            d( 1,
              Help,
              "Any Demo already in Internet",
              "Zomato App",
            ),

            d( 2,
              Functionalities,
              "What all functionalities you want ? ",
              "API, Key",
            ),
            f
                ? Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, right: 8.0, top: 10),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: Text(
                          'Level of App developing?',
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                          ),
                        ),
                        items: a1
                            .map((String item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ))
                            .toList(),
                        value: hj,
                        onChanged: (String? value) {
                          hj = value;
                        },
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          height: 40,
                          width: 400,
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding:
                        const EdgeInsets.only(left: 3.0, right: 3.0, top: 10),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: Text(
                          'Which one you want to make ?',
                          style: TextStyle(
                            fontSize: 19,
                            color: Colors.black,
                          ),
                        ),
                        items: a2
                            .map((String item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                  ),
                                ))
                            .toList(),
                        value: hjk,
                        onChanged: (String? value) {
                          hjk = value;
                        },
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          height: 40,
                          width: 400,
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                        ),
                      ),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Icon(Icons.person_pin, size: 25, color: Colors.pinkAccent),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Text("Other Details Needed",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Colors.pinkAccent)),
            ),
            d( 2,
              Other,
              "Any Other Details ?",
              "NA",
            ),
            d( 1,
              Notes,
              "Notes if any",
              "UI must be best",
            ),
          ]),
        ),
        Step(
          isActive: currentStep >= 1,
          title: Text("Personal"),
          content: Column(children: [
            Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: () {
                          i = false;
                          bu = true;
                          setState(() {});
                        },
                        child: a(
                            bu,
                            "Business",
                            "assets/pngtree-office-team-works-work-people-png-image_6051534-removebg-preview.png",
                            context)),
                    InkWell(
                        onTap: () {
                          i = true;
                          bu = false;
                          setState(() {});
                        },
                        child: a(
                            i,
                            "Individual",
                            "assets/png-clipart-computer-icons-businessman-miscellaneous-reading-removebg-preview.png",
                            context))
                  ],
                )),
            SizedBox(height: 15),
            d( 1,
              Name,
              "Your Name",
              "Ayusman Samasi",
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Icon(Icons.mail, size: 25, color: Colors.red),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Text("Contact Details",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Colors.red)),
            ),
            d( 1,
              Mobile,
              "Mobile",
              "+917978097489",
            ),
            d( 1,
              Email,
              "Email",
              "hariswarsamasi@gmail.com",
            ),
            d( 1,
              Address,
              "Address",
              "RS Colony, Jhirpani",
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Icon(Icons.question_mark_outlined,
                  size: 25, color: Colors.pinkAccent),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Text("Identity Details",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Colors.pinkAccent)),
            ),
            i
                ? Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, right: 8.0, top: 10),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: Text(
                          'Your Govt Id for verification',
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                          ),
                        ),
                        items: b1
                            .map((String item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ))
                            .toList(),
                        value: hhu,
                        onChanged: (String? value) {
                          hhu = value;
                        },
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          height: 40,
                          width: 400,
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, right: 8.0, top: 10),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: Text(
                          'Your Company Id for verification',
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                          ),
                        ),
                        items: b2
                            .map((String item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ))
                            .toList(),
                        value: hhu,
                        onChanged: (String? value) {
                          hhu = value;
                        },
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          height: 40,
                          width: 400,
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                        ),
                      ),
                    ),
                  ),
            d( 1,
              GovtId1,
              "ID Number",
              "ID Number",
            ),
          ]),
        ),
        Step(
          isActive: currentStep >= 2,
          title: Text("Confirm"),
          content: Column(
            children: [
              Image.network(
                  "https://img.freepik.com/premium-photo/3d-anime-cartoon-character-sits-table-with-laptop-coder-designer-office-worker_839035-133199.jpg",
                  height: 250),
              d( 1,
                Purpose,
                "Why you are making Project ?",
                "For Earning",
              ),
              d( 1,
                Business,
                "Your Business Hosting",
                "To change Eduction system",
              ),
              d( 2,
                Business_Details,
                "What change you see by this Order",
                "To make App and reach thousand Customers",
              ),
            ],
          ),
        ),
      ];

  void gh1() {
    setState(() {
      b = false;
      f = false;
      illu = false ;
      ai = false ;
    });
  }

  Widget d( int min, TextEditingController c, String label, String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
        controller: c, maxLines: min,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          isDense: true,
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please type It';
          }
          return null;
        },
      ),
    );
  }

  Widget a(bool g1, String s, String y, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2 - 30,
      height: MediaQuery.of(context).size.width / 2 - 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
            Radius.circular(5.0) //                 <--- border radius here
            ),
        color: g1 ? Colors.white : Colors.white70,
        border: Border.all(
          color: g1 ? Colors.blueAccent : Colors.grey,
          width: g1 ? 2.5 : 0.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Stack(
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                      child: Text(s,
                          style: TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 18))),
                  SizedBox(height: 8),
                  Center(child: Image.asset(height: 90, y)),
                ]),
            Align(
                alignment: Alignment.bottomRight,
                child: g1
                    ? Icon(
                        Icons.verified,
                        color: Colors.blue,
                      )
                    : Icon(Icons.circle_rounded, color: Colors.grey))
          ],
        ),
      ),
    );
  }
}
