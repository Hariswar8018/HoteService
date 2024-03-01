
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:read_more_text/read_more_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:starwish/models/order.dart';
import 'package:simple_progress_indicators/simple_progress_indicators.dart' ;
import 'package:starwish/second/card_order.dart';

class Learn extends StatefulWidget {

  Learn({super.key});

  @override
  State<Learn> createState() => _LearnState();
}

class _LearnState extends State<Learn> {

  bool b = false ;

  void initState(){
    String s = FirebaseAuth.instance.currentUser!.uid ;
    if ( s == "Qq0nRqCJZhTN7Av2W8AEzE9Jdar1" || s == "05wYwWtMDSUSrMUuvs5snWQYu0v2"){
      setState(() {
        b = true ;
      });
    }
  }



  List<SessionModel> list = [];
  late Map<String, dynamic> userMap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Current Order being Done", style : TextStyle(color : Colors.white)),
        backgroundColor: Color(0xffff79ac),
        iconTheme: IconThemeData(
            color : Colors.white
        ),
      ),
      floatingActionButton: IconButton(
        onPressed: (){
          Navigator.push(
              context,
              PageTransition(
                  child: Add(id: 'kgjg',),
                  type: PageTransitionType.rightToLeft,
                  duration: Duration(milliseconds: 400)));
        },
        icon: Icon(Icons.add),
      ),
     body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Orders').snapshots(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.active:
            case ConnectionState.done:
              final data = snapshot.data?.docs;
              list = data
                  ?.map((e) => SessionModel.fromJson(e.data())).toList() ?? [];
              if(list.isEmpty){
                return Center(
                  child : Text("No")
                );
              }else{
                return ListView.builder(
                  itemCount: list.length,
                  padding: EdgeInsets.only(top: 10),
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ChatUser(
                      user: list[index],
                    );
                  },
                );
              }

          }
        },
      ),
    );
  }
}


class ChatUser extends StatelessWidget {
  SessionModel user;
  ChatUser({super.key, required this.user});
  String sy(String g) {

    DateTime dateTime = DateTime.parse(g);
    String formattedDate = DateFormat('dd, MMM yy').format(dateTime);
    String formattedTime = DateFormat('hh:mm a').format(dateTime);
    print(formattedDate); // Output: 28, Jan 22
    return formattedDate + " At " + formattedTime;
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Column(
        children: [
          ListTile(
            title: Text("Order ID " + user.Name , style : TextStyle(fontWeight: FontWeight.w800)),
            subtitle: Text("Order Created on : " + user.User_Time),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(user.U1),
            ),
          
            onLongPress: (){
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Delete this ?'),
                  content: Text('Do you really want to delete this Sesssion including all Students'),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        /*CollectionReference collection1 = FirebaseFirestore.instance.collection('School').doc(id).collection('Session');
                        await collection1.doc(user.id).delete() ;*/
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('This Session Deleted'),
                          ),
                        );
                        Navigator.of(context).pop();
                      },
                      child: Text('Yes'),
          
                    ),
                    TextButton(
                      onPressed: () {
                        // Close the dialog
                        Navigator.of(context).pop();
                      },
                      child: Text('No'),
                    ),
                  ],
                );
              },
            ); },
            splashColor: Colors.orange.shade300,

          ),
          ListTile(
            title: Text("Being Made for : " + user.User_Name , style : TextStyle(fontWeight: FontWeight.w800)),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(user.User_Pic),
            ),
            subtitle: Text(user.User_Phone),
            splashColor: Colors.orange.shade300,
          ),
          ListTile(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => No_M(user : user)),
              );
            },
            title: Text("Status : " + user.Update_Status , style : TextStyle(fontWeight: FontWeight.w800)),
            subtitle: Text("Last Updated on " + sy(user.Last_Update)),
            splashColor: Colors.orange.shade300,
            trailing: Icon(Icons.arrow_forward_ios_rounded),
          ),
          ProgressBar(
            value: user.progress, width: MediaQuery.of(context).size.width - 50,
            //specify only one: color or gradient
            gradient: const LinearGradient(
              colors: [
                Colors.blue,
                Colors.red,
              ],
            ), backgroundColor: Colors.black,
          ),
          SizedBox(height : 20)
        ],
      ),
    );
  }

}


class Add extends StatefulWidget {
  String id;

  Add({super.key, required this.id});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  
   final TextEditingController nameController= TextEditingController() ;
   final TextEditingController idController= TextEditingController() ;
   final TextEditingController orderIdController= TextEditingController() ;
   final TextEditingController userPicController= TextEditingController() ;
   final TextEditingController userNameController= TextEditingController() ;
   final TextEditingController userPhoneController= TextEditingController() ;
   final TextEditingController userTimeController= TextEditingController() ;
   final TextEditingController u1Controller= TextEditingController() ;
   final TextEditingController u2Controller= TextEditingController() ;
   final TextEditingController u3Controller= TextEditingController() ;
   final TextEditingController f1Controller= TextEditingController() ;
   final TextEditingController f2Controller= TextEditingController() ;
   final TextEditingController f3Controller= TextEditingController() ;
   final TextEditingController a1Controller= TextEditingController() ;
   final TextEditingController a2Controller= TextEditingController() ;
   final TextEditingController Email = TextEditingController() ;
   final TextEditingController a3Controller= TextEditingController() ;
   final TextEditingController b1Controller= TextEditingController() ;
   final TextEditingController b2Controller= TextEditingController() ;
   final TextEditingController b3Controller= TextEditingController() ;
   final TextEditingController c1Controller= TextEditingController() ;
   final TextEditingController c2Controller= TextEditingController() ;
   final TextEditingController c3Controller= TextEditingController() ;
   final TextEditingController d1Controller= TextEditingController() ;
   final TextEditingController d2Controller= TextEditingController() ;
   final TextEditingController d3Controller= TextEditingController() ;
   final TextEditingController lastUpdateController= TextEditingController() ;
   final TextEditingController updateStatusController= TextEditingController() ;
   final TextEditingController updateController= TextEditingController() ;
  String s = " ";

  bool b = true ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("Add Session"),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              onTap: (){
                if (b ){
                  b = false ;
                  u3Controller.text = "3.7.1";
                  f3Controller.text = "2.2.2";
                } else {
                  b = true ;
                  u3Controller.text = "3.2.6";
                  f3Controller.text = "5.0";
                }
                setState(() {
        
                });
              },
              leading: Icon(CupertinoIcons.location_fill, color : Colors.red),
              title : Text("Illustration",
                  style : TextStyle ( fontWeight: FontWeight.w800, fontSize: 20)),
              subtitle: Text("For CLP"),
              trailing: b ? Icon(Icons.verified, color : Colors.blue) : Icon(Icons.circle, color : Colors.grey),
            ),
            g(userNameController, "User Name"),
            g(Email, "Email"),
            g(userPhoneController, "Phone"),
            g(userTimeController, "Time"),
            SizedBox(height: 40,),
            g(u3Controller, "Flutter Version / Clip Studio"),
            g(f3Controller, "Dart Version / Live2D "),
            g(a3Controller, "Plugins done / Illustration no"),
        
            g(b3Controller, "Lines of Code"),
            g(c3Controller, "Total Amount Paid"),
            g(d3Controller, "Made for Android for "),
            SizedBox(height: 40,),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: SocialLoginButton(
                backgroundColor: Color(0xff50008e),
                height: 40,
                text: 'Add Session Now',
                borderRadius: 20,
                fontSize: 21,
                buttonType: SocialLoginButtonType.generalLogin,
                onPressed: () async {
                  String st = "HOTE_ " + DateTime.now().microsecondsSinceEpoch.toString()  + "T_U";
                  CollectionReference collection = FirebaseFirestore.instance.collection('Orders');
                  if(b){
                    u1Controller.text = "https://logowik.com/content/uploads/images/flutter5786.jpg";
                    u2Controller.text = "Clip Studio Paint";
                    f1Controller.text = "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7e/Dart-logo.png/800px-Dart-logo.png";
                    f2Controller.text ="Live2D";
                    a1Controller.text = "https://talhealthcare.com/wp-content/plugins/tutor/assets/images/tutor-plugin.png";
                    a2Controller.text = "Frames" ;
                    b1Controller.text ="https://clipground.com/images/code-icon-png-8.png";
                    b2Controller.text = "No. of Strokes";
                  }else{
                    u1Controller.text = "https://logowik.com/content/uploads/images/flutter5786.jpg";
                    u2Controller.text = "Flutter";
                    f1Controller.text = "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7e/Dart-logo.png/800px-Dart-logo.png";
                    f2Controller.text ="Dart";
                    a1Controller.text = "https://talhealthcare.com/wp-content/plugins/tutor/assets/images/tutor-plugin.png";
                    a2Controller.text = "Plugin" ;
                    b1Controller.text ="https://clipground.com/images/code-icon-png-8.png";
                    b2Controller.text = "Lines of Code";
                  }
                  String h66 = DateTime.now().toString() ;
                  SessionModel sg = SessionModel(Name: st, id: st, OrderId: st,
                      User_Pic: userPicController.text, User_Name: userNameController.text, User_Phone: userPhoneController.text,
                      User_Time: userTimeController.text, U1: u1Controller.text, U2: u2Controller.text,
                      progress : 30.9, Email : Email.text, st : 2,
                      U3: u3Controller.text, F1: f1Controller.text, F2: f2Controller.text, F3: f3Controller.text,
                      A1: a1Controller.text, A2: a2Controller.text, A3: a3Controller.text, B1: b1Controller.text,
                      B2: b2Controller.text, B3: b3Controller.text, C1: c1Controller.text, C2: c2Controller.text, C3:c3Controller.text,
                      D1: d1Controller.text, D2: d2Controller.text, D3: d3Controller.text, Last_Update: h66, Update_Status:
                      "In Transit", Update: "In Transit");
                  try {
                    await collection.doc(st).set(sg.toJson());
                    /*await collection.doc(customDocumentId).set({
                      'Name': sessionNameController.text,
                      'id' : customDocumentId ,
                      // Add more fields as needed
                    });*/
        
                    Navigator.pop(context);
                  } catch (e) {
                    print('${e}');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${e}'),
                      ),
                    );
                  }
                  ;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget g(TextEditingController c, String st ){
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: TextFormField(
        controller: c,
        decoration: InputDecoration(
          labelText: st,
          isDense: true,
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please type your Password';
          }
          return null;
        },
      ),
    );
  }
}
