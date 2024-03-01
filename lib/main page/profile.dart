
import 'package:starwish/first/login.dart';
import 'package:starwish/main%20page/support.dart';
import 'package:starwish/models/usermodel.dart';

import 'package:starwish/providers/declare.dart';
import 'package:starwish/update/user_profile_before_update.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';


class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  initState() {
    super.initState();
    vq();
  }

  vq() async {
    UserProvider _userprovider = Provider.of(context, listen: false);
    await _userprovider.refreshuser();
  }

  @override
  Widget build(BuildContext context) {
    UserModel? _user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height : 230,
                width : MediaQuery.of(context).size.width,
                decoration : BoxDecoration(
                  color : Colors.white,
                  image : DecorationImage(
                      image : NetworkImage("https://img.freepik.com/free-vector/gradient-ui-ux-background_23-2149065783.jpg"), opacity: 0.8,
                    fit: BoxFit.cover,
                  ), 
                ),
                child: Center(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      "https://pbs.twimg.com/profile_images/859219500461432833/8UFODUcB_400x400.jpg",
                    ),
                    minRadius: 50,
                    maxRadius: 60,
                  ),
                ),
              ),
              SizedBox(height : 15),
              ListTile(
                leading: Icon(Icons.account_circle_sharp, color: Colors.black, size: 30,),
                title: Text("My Account"),
                onTap: () {
                  Navigator.push(
                      context, PageTransition(
                      child: Before_Update(), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 500)
                  ));
                },
                subtitle: Text("See your Account, Edit or Delete It"),
                splashColor: Colors.orange.shade200, trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.black, size: 20,),
                tileColor: Colors.grey.shade50,
              ),
              ListTile(
                leading: Icon(Icons.info, color: Colors.redAccent, size: 30),
                title: Text("Learn More"),
                onTap: () async {
                  final Uri _url = Uri.parse('https://ayush.starwish.fun/');
                  if (!await launchUrl(_url)) {
                    throw Exception('Could not launch $_url');
                  }
                },
                subtitle: Text("Learn More about us & the App"),
                splashColor: Colors.orange.shade300, trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.redAccent, size: 20,),
                tileColor: Colors.grey.shade50,
              ),
              ListTile(
                leading: Icon(Icons.privacy_tip, color: Colors.purpleAccent, size: 30),
                title: Text("Privacy"),
                onTap: () async {
                  final Uri _url = Uri.parse('https://sites.google.com/view/hote-app/home');
                  if (!await launchUrl(_url)) {
                  throw Exception('Could not launch $_url');
                  }
                },
                subtitle: Text("Check how Privacy is Managed"), trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.purpleAccent, size: 20,),
                splashColor: Colors.orange.shade300,
                tileColor: Colors.grey.shade50,
              ),
              ListTile(
                leading: Icon(Icons.waving_hand, color: Colors.orange, size: 30),
                title: Text("Whatsapp Connect"),
                onTap: () async {
                  final Uri _url = Uri.parse('https://wa.me/917978097489');
                  if (!await launchUrl(_url)) {
                    throw Exception('Could not launch $_url');
                  }
                },
                subtitle: Text("Connect on Whatsapp"), trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.orange, size: 20,),
                splashColor: Colors.orange.shade300,
                tileColor: Colors.grey.shade50,
              ),
              ListTile(
                leading: Icon(Icons.support, color: Colors.green, size: 30),
                title: Text("Support"),
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: Suport(),
                          type: PageTransitionType.rightToLeft,
                          duration: Duration(milliseconds: 400)));
                },
                subtitle: Text("Contact Help and Support"), trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.green, size: 20,),
                splashColor: Colors.orange.shade300,
                tileColor: Colors.grey.shade50,
              ),
              ListTile(
                leading: Icon(Icons.logout, color: Colors.redAccent, size: 30),
                title: Text("Log Out"),
                onTap: () async {
                  FirebaseAuth auth = FirebaseAuth.instance;
                  auth.signOut().then((res) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  });
                },
                subtitle: Text("Log Out from this App"),
                splashColor: Colors.orange.shade300, trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.redAccent, size: 20,),
                tileColor: Colors.grey.shade50,
              ),
              SizedBox(height: 20,),
              Text("HOTE Service", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, fontStyle: FontStyle.italic)),
              Text("Made by Ayusman Samasi ❤️ ", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
              SizedBox(height: 10,),
              Image.network("https://ayush.starwish.fun/wp-content/uploads/2024/01/cropped-e9262fa54ea154d5861d895269a72c06-1.png", height: 80,),
              Text("HOTE Version version : 1.0", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w200)),
              SizedBox(height: 70,),
            ],
          ),
        ),
      ),
    );
  }
}
