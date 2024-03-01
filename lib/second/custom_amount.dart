import 'package:starwish/main%20page/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:easy_upi_payment/easy_upi_payment.dart';
import 'package:starwish/make_order/cash_free.dart';

import '../make_order/cash.dart';

class Pay_Order1 extends StatefulWidget {

  Pay_Order1(
      {super.key,
      });

  @override
  State<Pay_Order1> createState() => _Pay_OrderState();
}

class _Pay_OrderState extends State<Pay_Order1> {
  int s = 500;

  Razorpay _razorpay = Razorpay();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text("Pay Custom Amount"),
          elevation: 0,
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18),
                child: TextFormField(
                  keyboardType: TextInputType.number, maxLength: 4,
                  decoration: InputDecoration(
                    labelText: "Your Price",
                    isDense: true,
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      s = value as int ;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 20,
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
                            onPressed: () async {
                              try {
                                final res = await EasyUpiPaymentPlatform.instance.startPayment(
                                  EasyUpiPaymentModel(
                                    payeeVpa: '8093426959@kotak',
                                    payeeName: 'AYUSMAN SAMASI',
                                    amount: s.toDouble(),
                                    description: 'Custom Order',
                                  ),
                                );
                                print(res);
                              } on EasyUpiPaymentException {
                                // TODO: add your exception logic here
                              }
                            },
                            icon: Icon(Icons.account_balance, color: Colors.black),
                            label: Text("Pay by UPI",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black))))),
              ),
              SizedBox(
                height: 20,
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
                            onPressed: () async {
                              double gh = s.toDouble() ;
                              double df = ( 2 / 100 ) * gh ;
                              double fg = gh - df ;
                              String st = "Order_" + DateTime.now().millisecondsSinceEpoch.toString() + "_Ou1";
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => CashFreePayment(
                                  dr: fg, str: st,
                                )),
                              );
                            },
                            icon: Icon(Icons.credit_card, color: Colors.black),
                            label: Text("Pay by Cashfree",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black))))),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                    border: Border.all(color: Colors.black), // Black border
                  ),
                  child: ListTile(
                    leading : Icon(Icons.trending_up, color : Colors.orange, size : 55),
                    title : Text("Get 2 % Discount on Payment", style : TextStyle(fontSize : 19, fontWeight : FontWeight.w800)),
                    subtitle : Text("As A new service, We are giving 2% Payment Discount on all Payment done through CashFree Payment Gateaway")
                  ),
                ),
              )
            ]
        )
    );
  }
}
