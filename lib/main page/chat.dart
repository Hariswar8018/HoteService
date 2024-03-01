import 'package:easy_upi_payment/easy_upi_payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfwebcheckoutpayment.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfenums.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfexceptions.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfsession/cfsession.dart';
import 'package:page_transition/page_transition.dart';
import 'package:starwish/models/usermodel.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:starwish/second/custom_amount.dart';
import 'package:starwish/second/pay_order.dart';
import 'package:url_launcher/url_launcher.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => ChatState();
}

class ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffff79ac),
          automaticallyImplyLeading: false,
          title: Text(
            "Pay Us",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Column(children: [
          ListTile(
              leading: Icon(Icons.local_shipping_rounded,
                  color: Color(0xffff79ac), size: 30),
              title: Text("Pay for Order",
                  style: TextStyle(fontWeight: FontWeight.w900)),
              subtitle: Text("Use this if you have Order In Transit with us"),
              trailing: Icon(Icons.arrow_forward_ios,
                  color: Color(0xffff79ac), size: 20),
              tileColor: Colors.white70,
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: Pay_Order(),
                        type: PageTransitionType.rightToLeft,
                        duration: Duration(milliseconds: 200)));
              }),
          ListTile(
            leading: Icon(Icons.money, color: Color(0xffff79ac), size: 30),
            title: Text("Pay for Security Deposit",
                style: TextStyle(fontWeight: FontWeight.w900)),
            subtitle: Text("Pay INR 500 so that a new order would start"),
            trailing: Icon(Icons.arrow_forward_ios,
                color: Color(0xffff79ac), size: 20),
            tileColor: Colors.white70,
            onTap: () async {
              try {
                final res = await EasyUpiPaymentPlatform.instance.startPayment(
                  EasyUpiPaymentModel(
                    payeeVpa: '8093426959@kotak',
                    payeeName: 'AYUSMAN SAMASI',
                    amount: 500.0,
                    description: 'Security Deposit',
                  ),
                );
                // TODO: add your success logic here
                print(res);
              } on EasyUpiPaymentException {
                // TODO: add your exception logic here
              }
            },
          ),
          ListTile(
            leading:
                Icon(Icons.credit_card, color: Color(0xffff79ac), size: 30),
            title: Text("Pay custom Amount",
                style: TextStyle(fontWeight: FontWeight.w900)),
            subtitle: Text("Pay any Amount you may be opted for"),
            trailing: Icon(Icons.arrow_forward_ios,
                color: Color(0xffff79ac), size: 20),
            tileColor: Colors.white70,
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      child: Pay_Order1(),
                      type: PageTransitionType.rightToLeft,
                      duration: Duration(milliseconds: 200)));
            },
          ),
          ListTile(
            leading:
            Icon(Icons.account_balance, color: Color(0xffff79ac), size: 30),
            title: Text("Pay online",
                style: TextStyle(fontWeight: FontWeight.w900)),
            subtitle: Text("Pay any Amount online in Razorpay"),
            trailing: Icon(Icons.arrow_forward_ios,
                color: Color(0xffff79ac), size: 20),
            tileColor: Colors.white70,
            onTap: () async {
              webCheckout();
            },
          ),
        ]));
  }
  CFPaymentGatewayService cfPaymentGatewayService =
  CFPaymentGatewayService(); // Cashfree Payment Instance
  bool? isSuccess;

  webCheckout() async {
    try {
      var session = await createSession();
      var cfWebCheckout =
      CFWebCheckoutPaymentBuilder().setSession(session!).build();
      cfPaymentGatewayService.doPayment(cfWebCheckout);
    } on CFException catch (e) {
      print(e.message);
    }
  }
  Future<CFSession?> createSession() async {
    try {
      double gh = 100 ;
      double df = ( 2 / 100 ) * gh ;
      double fg = gh - df ;
      String st = "Order_" + DateTime.now().millisecondsSinceEpoch.toString() + "_Ou1";
      final mySessionIDData = await createSessionID(
          st, fg); // This will create session id from flutter itself
      // Now we will se some parameter like orderID ,environment,payment sessionID
      // after that we wil create the checkout session
      // which will launch through which user can pay.
      var session = CFSessionBuilder()
          .setEnvironment(CFEnvironment.PRODUCTION)
          .setOrderId(mySessionIDData["order_id"])
          .setPaymentSessionId(mySessionIDData["payment_session_id"])
          .build();
      return session;
    } on CFException catch (e) {
      print(e.message);
    }
    return null;
  }

}


createSessionID(String orderID, double dr) async {
  var headers = {
    'Content-Type': 'application/json',
    'X-Client-Id': "62913184b0eddf29804c30248b131926",
    'X-Client-Secret': "cfsk_ma_prod_06633b81134de7b786922c3a0a0a986b_464bf578",
    'X-Api-Version': '2023-08-01', // This is latest version for API
    'x-request-id': 'com.heavenonthisearth.starwish'
  };
  print(headers);
  var request =
  http.Request('POST', Uri.parse('https://api.cashfree.com/pg/orders'));
  request.body = json.encode({
    "order_amount": dr, // Order Amount in Rupees
    "order_id": orderID, // OrderiD created by you it must be unique
    "order_currency": "INR", // Currency of order like INR,USD
    "customer_details": {
      "customer_id": "customer_id", // Customer id
      "customer_name": "Ayusman Samasi", // Name of customer
      "customer_email": "flutterwings304@gmail.com", // Email id of customer
      "customer_phone": "+917737366393" // Phone Number of customer
    },
    "order_meta": {
      "notify_url": "https://b8af79f41056.eu.ngrok.io?order_id=order_123"
    },
    "order_note": "some order note here" // If you want to store something extra
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    // If All the details is correct it will return the
    // response and you can get sessionid for checkout
    return jsonDecode(await response.stream.bytesToString());
  } else {
    print(await response.stream.bytesToString());
    print(response.reasonPhrase);
  }
}
