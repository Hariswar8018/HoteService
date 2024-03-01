
import 'dart:io';

import 'package:starwish/main%20page/Teacher.dart';
import 'package:starwish/main%20page/chat.dart';
import 'package:starwish/main%20page/home.dart';
import 'package:starwish/main%20page/learn.dart';
import 'package:starwish/main%20page/profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:starwish/make_order/make_order.dart';

class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{
  Future<bool> _onWillPop(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Exit App?'),
        content: Text('Do you want to exit the app?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
              exit(0);
              },

            child: Text('Yes'),
          ),
        ],
      ),
    ) ?? false;
  }

  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
          bottomNavigationBar: CurvedNavigationBar(
            key: _bottomNavigationKey,
            index: 0,
            height: 60.0,
            items: <Widget>[
              Icon(Icons.home_filled, size: 30,  color: Colors.white,),
              Icon(Icons.offline_bolt_rounded, size: 30,  color: Colors.white,),
              Icon(Icons.add_business , size: 30,  color: Colors.white,),
              Icon(Icons.account_balance_wallet_rounded, size: 30,  color: Colors.white,),
              Icon(Icons.person, size: 30,  color: Colors.white,),
            ],
            color: Colors.blueAccent,
            buttonBackgroundColor:  Colors.blueAccent,
            backgroundColor: Colors.white,
            animationCurve: Curves.easeInOut,
            animationDuration: Duration(milliseconds: 400),
            onTap: (index) {
              setState(() {
                _page = index;
              });
            },
            letIndexChange: (index) => true,
          ),
          body: itens[_page],
      ),
    );
  }

  List <Widget> itens = [
    Home1(),
    Learn(),
    Ad1(),
    Chat(),
    Profile(),
  ];
}
