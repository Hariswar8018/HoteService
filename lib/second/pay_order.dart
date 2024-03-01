import 'package:starwish/main%20page/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Pay_Order extends StatefulWidget {

  Pay_Order(
      {super.key,
        });

  @override
  State<Pay_Order> createState() => _Pay_OrderState();
}

class _Pay_OrderState extends State<Pay_Order> {
  String s = " ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text("Find Order by ID"),
          elevation: 0,
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18),
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Your Order ',
                    isDense: true,
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      s = value;
                    });
                  },
                ),
              ),
              Center(
                child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black, // Border color
                        width: 2.0, // Border width
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
                        width: MediaQuery.of(context).size.width - 40,
                        child: TextButton.icon(
                            onPressed: () async {},
                            icon: Icon(Icons.search, color: Colors.black),
                            label: Text("Search by Order Number",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black))))),
              ),
              SizedBox(height: 100,),
            ]));
  }
}
