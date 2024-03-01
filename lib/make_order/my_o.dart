
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:read_more_text/read_more_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:starwish/main%20page/learn.dart';
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

  List<SessionModel> list = [];
  late Map<String, dynamic> userMap;
  String? suj = FirebaseAuth.instance.currentUser!.email ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("My Orders", style : TextStyle(color : Colors.white)),
        backgroundColor: Color(0xffff79ac),
        iconTheme: IconThemeData(
            color : Colors.white
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Orders').where("Email", isEqualTo: suj).snapshots(),
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
