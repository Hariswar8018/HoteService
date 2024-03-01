
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:read_more_text/read_more_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:simple_progress_indicators/simple_progress_indicators.dart' ;
import 'package:starwish/second/card_order.dart';
import 'package:timelines/timelines.dart';
import 'package:intl/intl.dart';

class Ship extends StatefulWidget {
  String id ;
  Ship({super.key, required this.id});

  @override
  State<Ship> createState() => _ShipState();
}

class _ShipState extends State<Ship> {

  bool b = false ;

  void initState(){
    String s = FirebaseAuth.instance.currentUser!.uid ;
    if ( s == "Qq0nRqCJZhTN7Av2W8AEzE9Jdar1" || s == "05wYwWtMDSUSrMUuvs5snWQYu0v2"){
      setState(() {
        b = true ;
      });
    }
  }

  List<ShipModel> list = [];
  late Map<String, dynamic> userMap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Track Status : ${widget.id}", style : TextStyle(color : Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(
            color : Colors.white
        ),
      ),
      floatingActionButton: IconButton(
        onPressed: (){
          Navigator.push(
              context,
              PageTransition(
                  child: Add(id: widget.id,),
                  type: PageTransitionType.rightToLeft,
                  duration: Duration(milliseconds: 400)));
        },
        icon: Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Orders').doc(widget.id).collection("Ship").snapshots(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.active:
            case ConnectionState.done:
              final data = snapshot.data?.docs;
              list = data
                  ?.map((e) => ShipModel.fromJson(e.data())).toList() ?? [];
              if(list.isEmpty){
                return Center(
                    child : Text("No")
                );
              }else{
                return ListView.builder(
                  itemCount: list.length,
                  padding: EdgeInsets.only(left : 20),
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return TimelineWidget(
                      timelineElements: list[index],
                      l: list.length,
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

class TimelineWidget extends StatelessWidget {
  int l ;

  ShipModel timelineElements;

  TimelineWidget({required this.timelineElements, required this.l});

  String sy(String g) {

    DateTime dateTime = DateTime.parse(g);
    String formattedDate = DateFormat('dd, MMM yy').format(dateTime);
    print(formattedDate); // Output: 28, Jan 22
    return formattedDate ;
  }
  String sj(String g) {

    DateTime dateTime = DateTime.parse(g);
    String formattedDate = DateFormat('dd, MMM yy').format(dateTime);
    String formattedTime = DateFormat('hh:mm a').format(dateTime);
    print(formattedDate); // Output: 28, Jan 22
    return formattedTime ;
  }

  @override
  Widget build(BuildContext context) {
    return FixedTimeline.tileBuilder(
      theme: TimelineTheme.of(context).copyWith(
        nodePosition: 0,
        connectorTheme: TimelineTheme.of(context).connectorTheme.copyWith(
          thickness: 1.0,
        ),
        indicatorTheme: TimelineTheme.of(context).indicatorTheme.copyWith(
          size: 10.0,
          position: 0.5,
        ),
      ),

      builder: TimelineTileBuilder.connectedFromStyle(
        contentsAlign: ContentsAlign.basic,
        contentsBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text( sy(timelineElements.Updated) ),
              Text( "At : " + sj(timelineElements.Updated) ),
            ],
          ),
          ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.only( left : 9.0, right : 9, top : 6, bottom : 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(timelineElements.Title, style : TextStyle( fontWeight: FontWeight.w800, fontSize: 18)),
                      Text(timelineElements.Description),
                    ],
                  ),
                ),
              ),
              SizedBox( height :20)
            ],
          );
        },
        connectorStyleBuilder: (context, index) => timelineElements.isLong ? ConnectorStyle.solidLine : ConnectorStyle.dashedLine  ,
        indicatorStyleBuilder: (context, index) => timelineElements.isLong ? IndicatorStyle.dot : IndicatorStyle.outlined,
        itemCount: g(l) ,
      ),
    );
  }

  int g(int j){
    int y = j ~/ 2;
    return y ;
  }

}


class Add extends StatefulWidget {
  String id;

  Add({super.key, required this.id});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {

  final TextEditingController userNameController= TextEditingController() ;
  final TextEditingController userPhoneController= TextEditingController() ;
  final TextEditingController done= TextEditingController() ;
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
                } else {
                  b = true ;

                }
                setState(() {

                });
              },
              leading: Icon(CupertinoIcons.location_fill, color : Colors.red),
              title : Text("Is Big ?",
                  style : TextStyle ( fontWeight: FontWeight.w800, fontSize: 20)),
              subtitle: Text("For CLP"),
              trailing: b ? Icon(Icons.verified, color : Colors.blue) : Icon(Icons.circle, color : Colors.grey),
            ),
            g(userNameController, "Name "),
            g(userPhoneController, "Description"),
            g(done, "How much done ? "),
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
                  String st =  DateTime.now().microsecondsSinceEpoch.toString()  ;
                  String h66 = DateTime.now().toString() ;
                  CollectionReference collection = FirebaseFirestore.instance.collection('Orders').doc(widget.id).collection("Ship");
                  ShipModel sety = ShipModel(Name: st, id: st,
                      Title: userNameController.text, isLong: b,
                      Description: userPhoneController.text, Updated: h66, Done: userNameController.text,
                  );

                  try {
                    await collection.doc(st).set(sety.toJson());
                    CollectionReference collectiong = FirebaseFirestore.instance.collection('Orders');

                    await collectiong.doc(widget.id).update({
                      'Last_Update': h66,
                      'Update_Status' : done.text ,
                      'Update' : done.text ,
                    });

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

class ShipModel {
  ShipModel({
    required this.Name,
    required this.id,
    required this.Title,
    required this.isLong,
    required this.Description,
    required this.Updated,
    required this.Done
  });

  late final String Name;
  late final String id;
  late final String Done ;
  late final String Title;
  late final bool isLong;
  late final String Description;
  late final String Updated;

  ShipModel.fromJson(Map<String, dynamic> json) {
    Name = json['Name'] ?? 'samai';
    Done = json['Done'] ?? "In - Transit";
    id = json['id'] ?? 'Xhqo6S2946pNlw8sRSKd';
    Title = json['Title'] ?? '';
    isLong = json['isLong'] ?? false;
    Description = json['Description'] ?? '';
    Updated = json['Updated'] ?? '2024-01-28T12:00:00Z' ;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Name'] = Name;
    data['Done'] = Done ;
    data['id'] = id;
    data['Title'] = Title;
    data['isLong'] = isLong;
    data['Description'] = Description;
    data['Updated'] = Updated ;
    return data;
  }
}
