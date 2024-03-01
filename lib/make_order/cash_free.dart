import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:page_transition/page_transition.dart';
import 'package:read_more_text/read_more_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:starwish/main%20page/learn.dart';
import 'package:starwish/models/order.dart';
import 'package:simple_progress_indicators/simple_progress_indicators.dart';
import 'package:starwish/second/card_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfcard/cfcardlistener.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfcard/cfcardwidget.dart';
import 'package:flutter_cashfree_pg_sdk/api/cferrorresponse/cferrorresponse.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfcard.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfcardpayment.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfdropcheckoutpayment.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfnetbanking.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfnetbankingpayment.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfupi.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfupipayment.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfwebcheckoutpayment.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentcomponents/cfpaymentcomponent.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfsession/cfsession.dart';
import 'package:flutter_cashfree_pg_sdk/api/cftheme/cftheme.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfenums.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfexceptions.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfupi/cfupiutils.dart';

class CashFreePayment extends StatefulWidget {
  String str;

  double dr;

  CashFreePayment({super.key, required this.dr, required this.str});

  @override
  State<CashFreePayment> createState() => _CashFreePaymentState();
}

class _CashFreePaymentState extends State<CashFreePayment> {
  CFPaymentGatewayService cfPaymentGatewayService =
      CFPaymentGatewayService(); // Cashfree Payment Instance
  bool? isSuccess;

  @override
  void initState() {
    super.initState();
    // Attach events when payment is success and when error occured
    cfPaymentGatewayService.setCallback(verifyPayment, onError);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cashfree Payment Gateaway'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                    "https://cashfreelogo.cashfree.com/cf-og.png")),
            SizedBox(height: 40),
            Text(
              "Payment Status : $isSuccess",
              style: const TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
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
                          onPressed: pay,
                          icon: Icon(Icons.credit_card, color: Colors.black),
                          label: Text("Start Payment",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black))))),
            ),
          ],
        ),
      ),
    );
  } // When payment is done successfully

  void verifyPayment(String orderId) {
    // Here we will only print the statement
    // to check payment is done or not
    isSuccess = true;
    setState(() {});
    print("Verify Payment $orderId");
  }

// If some error occur during payment this will trigger
  void onError(CFErrorResponse errorResponse, String orderId) {
    // printing the error message so that we can show
    // it to user or checkourselves for testing
    isSuccess = false;
    setState(() {});
    print(errorResponse.getMessage());
    print("Error while making payment");
  }

  String orderId = "my_order_id4";

  Future<CFSession?> createSession() async {
    try {
      final mySessionIDData = await createSessionID(
          widget.str, widget.dr); // This will create session id from flutter itself
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

  pay() async {
    try {
      var session = await createSession();
      List<CFPaymentModes> components = <CFPaymentModes>[];
      // If you want to set paument mode to be shown to customer
      var paymentComponent =
          CFPaymentComponentBuilder().setComponents(components).build();
      // We will set theme of checkout session page like fonts, color
      var theme = CFThemeBuilder()
          .setNavigationBarBackgroundColorColor("#FF0000")
          .setPrimaryFont("Menlo")
          .setSecondaryFont("Futura")
          .build();
      // Create checkout with all the settings we have set earlier
      var cfDropCheckoutPayment = CFDropCheckoutPaymentBuilder()
          .setSession(session!)
          .setPaymentComponent(paymentComponent)
          .setTheme(theme)
          .build();
      // Launching the payment page

      cfPaymentGatewayService.doPayment(cfDropCheckoutPayment);
    } on CFException catch (e) {
      print(e.message);
    }
  }



/*
// */
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
