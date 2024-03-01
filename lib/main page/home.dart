import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_buttons/social_media_buttons.dart';
import 'package:starwish/first/login.dart';
import 'package:webview_flutter/webview_flutter.dart' ;
import 'package:url_launcher/url_launcher.dart';

class Home1 extends StatefulWidget {
  Home1({super.key});

  @override
  State<Home1> createState() => _Home1State();
}

class _Home1State extends State<Home1> {
  late final WebViewController controller;
  double progress = 0.0;

  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progres) {
            setState(() {
              progress = progres / 100;
            });
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://ayush.starwish.fun/6/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://ayush.starwish.fun/'));
    setState(() {

    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime? _lastPressedAt;

  int c = 0;

  @override
  Widget build(BuildContext context) {
    int backButtonPressCount = 0;
    return WillPopScope(
      onWillPop: () async {
        if (_lastPressedAt == null || DateTime.now().difference(_lastPressedAt!) > Duration(seconds: 2)) {
          // If it's the first press or more than 2 seconds since the last press
          if (await controller.canGoBack()) {
            controller.goBack();
          } else {
            _lastPressedAt = DateTime.now();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Press back again to exit'),
                duration: Duration(seconds: 2),
              ),
            );
          }
          return false; // Do not exit the app
        } else {
          return true; // Allow exit the app
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        key: _scaffoldKey,
        drawer : buildDrawer(context),
        appBar: AppBar(
          title: Text("Home", style : TextStyle(color : Colors.white)),
          backgroundColor: Color(0xffff79ac),
          iconTheme: IconThemeData(
              color : Colors.white
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(4.0), // Set the desired height
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xffff79ac)),
            ),
          ),
        ),
        body: WebViewWidget(controller: controller,
        ),
      ),
    );
  }

  Future<void> _refreshWebView() async {
    await controller.reload();
  }

  Widget buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            color : Colors.white,
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: Image.asset(
                  "assets/Untitled design (1).png",)),
          ListTile(
            leading: Icon(
              Icons.language,
              color: Colors.black,
              size: 30,
            ),
            title: Text("Our Website"),
            onTap: () async {
              final Uri _url = Uri.parse('https://ayush.starwish.fun');
              if (!await launchUrl(_url)) {
                throw Exception('Could not launch $_url');
              }
            },
            splashColor: Colors.orange.shade200,
            trailing: Icon(
              Icons.arrow_forward_ios_sharp,
              color: Colors.black,
              size: 20,
            ),
            tileColor: Colors.grey.shade50,
          ),
          ListTile(
            leading: Icon(Icons.map, color: Colors.greenAccent, size: 30),
            title: Text("Locate on Map"),
            onTap: () async {
              final Uri _url = Uri.parse(
                  'https://www.google.com/maps?q=15.2803236,73.9558804');
              if (!await launchUrl(_url)) {
                throw Exception('Could not launch $_url');
              }
            },
            trailing: Icon(
              Icons.arrow_forward_ios_sharp,
              color: Colors.greenAccent,
              size: 20,
            ),
            splashColor: Colors.orange.shade300,
            tileColor: Colors.grey.shade50,
          ),
          ListTile(
            leading: Icon(Icons.mail, color: Colors.redAccent, size: 30),
            title: Text("Mail Us"),
            onTap: () async {
              final Uri _url = Uri.parse(
                  'mailto:hariswarsamasi@gmail.com?subject=Known_more_about_services&body=New%20Message');
              if (!await launchUrl(_url)) {
                throw Exception('Could not launch $_url');
              }
            },
            splashColor: Colors.orange.shade300,
            trailing: Icon(
              Icons.arrow_forward_ios_sharp,
              color: Colors.redAccent,
              size: 20,
            ),
            tileColor: Colors.grey.shade50,
          ),
          ListTile(
            leading: SocialMediaButton.whatsapp(
              onTap: () async {
                final Uri _url = Uri.parse('https://wa.me/917978097489');
                if (!await launchUrl(_url)) {
                  throw Exception('Could not launch $_url');
                }
              },
              size: 35,
              color: Colors.green,
            ),
            title: Text("Whatsapp"),
            subtitle: Text("Inquire in Whatsapp"),
            trailing: Icon(
              Icons.arrow_forward_ios_sharp,
              color: Colors.green,
              size: 20,
            ),
            splashColor: Colors.orange.shade300,
            tileColor: Colors.grey.shade50,
          ),

          ListTile(
            leading: SocialMediaButton.instagram(
              onTap: () {
                print('or just use onTap callback');
              },
              size: 35,
              color: Colors.red,
            ),
            title: Text("Instagram"),
            onTap: () async {
              final Uri _url = Uri.parse(
                  'https://www.instagram.com/ayushmansamasi');
              if (!await launchUrl(_url)) {
                throw Exception('Could not launch $_url');
              }
            },
            subtitle: Text("Follow on Instagram"),
            trailing: Icon(
              Icons.arrow_forward_ios_sharp,
              color: Colors.red,
              size: 20,
            ),
            splashColor: Colors.orange.shade300,
            tileColor: Colors.grey.shade50,
          ),
          ListTile(
            leading: SocialMediaButton.facebook(
              onTap: () {
                print('or just use onTap callback');
              },
              size: 35,
              color: Colors.blue,
            ),
            title: Text("Facebook"),
            onTap: () async {
              final Uri _url = Uri.parse(
                  'https://www.facebook.com/ayusmansamasi');
              if (!await launchUrl(_url)) {
                throw Exception('Could not launch $_url');
              }
            },
            subtitle: Text("Check Profile"),
            trailing: Icon(
              Icons.arrow_forward_ios_sharp,
              color: Colors.blue,
              size: 20,
            ),
            splashColor: Colors.orange.shade300,
            tileColor: Colors.grey.shade50,
          ),
          ListTile(
            leading: SocialMediaButton.facebook(
              onTap: () {
                print('or just use onTap callback');
              },
              size: 35,
              color: Colors.green,
            ),
            title: Text("Fiverr"),
            onTap: () async {
              final Uri _url = Uri.parse(
                  'https://www.fiverr.com/weallareone673?up_rollout=true');
              if (!await launchUrl(_url)) {
                throw Exception('Could not launch $_url');
              }
            },
            subtitle: Text("Check Fiverr Profile"),
            trailing: Icon(
              Icons.arrow_forward_ios_sharp,
              color: Colors.green,
              size: 20,
            ),
            splashColor: Colors.orange.shade300,
            tileColor: Colors.grey.shade50,
          ),
          ListTile(
            leading: SocialMediaButton.linkedin(
              onTap: () {
                print('or just use onTap callback');
              },
              size: 35,
              color: Colors.blueAccent,
            ),
            title: Text("LinkedIn"),
            onTap: () async {
              final Uri _url = Uri.parse(
                  'https://www.linkedin.com/in/ayusman-samasi-28947b1b8');
              if (!await launchUrl(_url)) {
                throw Exception('Could not launch $_url');
              }
            },
            subtitle: Text("Check LinkedIn"),
            trailing: Icon(
              Icons.arrow_forward_ios_sharp,
              color: Colors.blueAccent,
              size: 20,
            ),
            splashColor: Colors.orange.shade300,
            tileColor: Colors.grey.shade50,
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Colors.red,
              size: 30,
            ),
            title: Text("Log Out"),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              print('User signed out');
              // Navigate to the login screen
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            splashColor: Colors.orange.shade200,
            trailing: Icon(
              Icons.arrow_forward_ios_sharp,
              color: Colors.black,
              size: 20,
            ),
            tileColor: Colors.grey.shade50,
            subtitle: Text("Log out "),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}