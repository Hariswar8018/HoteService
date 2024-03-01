import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:starwish/main%20page/navigation.dart';

class Make_O extends StatelessWidget {
  const Make_O({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Success", style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xffff79ac),
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body : Column(
        children: [
          Image.network("https://img.freepik.com/free-vector/order-confirmed-concept-illustration_114360-1486.jpg"),
          SizedBox(height : 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SocialLoginButton(
                backgroundColor:  Color(0xffff79ac),
                height: 40,
                text: 'Go Back !',
                borderRadius: 20,
                fontSize: 21,
                buttonType: SocialLoginButtonType.generalLogin,
                onPressed: () async {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: Home(),
                          type: PageTransitionType.rightToLeft,
                          duration: Duration(milliseconds: 800)));
                }
            ),
          ),
        ],
      )
    );
  }
}
