import 'package:starwish/first/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';


class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  TestScreenState createState() => TestScreenState();
}

class TestScreenState extends State<TestScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => LoginScreen()),
    );
  }

  Widget _buildFullscreenImage() {
    return Image.asset(
      'assets/heaven_on_this_earth_logo.jpeg',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.network('$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(1.0, 0.0, 1.0, 8.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return Center(
      child: IntroductionScreen(
        key: introKey, pagesAxis: Axis.horizontal,
        globalBackgroundColor: Colors.white,
        allowImplicitScrolling: true,
        autoScrollDuration: 4000,
        infiniteAutoScroll: true,
        globalHeader: Align(
          alignment: Alignment.topRight,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 12, right: 12),
              child: Image.asset('assets/heaven_on_this_earth_logo.jpeg',  height : 50),
            ),
          ),
        ),
        globalFooter: SizedBox(
          width: double.infinity,
          height: 60,
          child: MaterialButton(
            color: Color(0xffff79ac),
            textColor: Colors.white,
            child: const Text(
              'Let\'s go right away !',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            onPressed: () => _onIntroEnd(context),
          ),
        ),
        pages: [
          PageViewModel(
            title: "Check your orders",
            body:
            "Check your Order with me, and even track it",
            image: _buildImage('https://cdni.iconscout.com/illustration/premium/thumb/order-confirmation-5365232-4500195.png?f=webp'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Contact me directly",
            body:
            "Contact me with ease",
            image: _buildImage('https://cdni.iconscout.com/illustration/premium/thumb/contact-us-5795988-4849052.png'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Pay Directly",
            body:
            "No hassle of errors. With App you are definitely paying to us",
            image: _buildImage('https://img.freepik.com/premium-vector/man-paying-takeaway-coffee-with-mobile-phone-cafe-cashier-checkout_81894-7059.jpg'),
            decoration: pageDecoration,
          ),
        ],
        onDone: () => _onIntroEnd(context),
        onSkip: () => _onIntroEnd(context), // You can override onSkip callback
        showSkipButton: true,
        skipOrBackFlex: 0,
        nextFlex: 0,
        showBackButton: false,
        //rtl: true, // Display as right-to-left
        back: const Icon(Icons.arrow_back),
        skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xffff79ac))),
        next: const Icon(CupertinoIcons.forward, color: Color(0xffff79ac)),
        done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xffff79ac),)),
        curve: Curves.fastLinearToSlowEaseIn,
        controlsMargin: const EdgeInsets.all(2),
        controlsPadding: kIsWeb
            ? const EdgeInsets.all(12.0)
            : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
        dotsDecorator: const DotsDecorator(
          size: Size(10.0, 10.0),
          color: Colors.white,
          activeSize: Size(22.0, 10.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
        dotsContainerDecorator: const ShapeDecoration(
          color: Colors.white12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
        ),
      ),
    );
  }
}