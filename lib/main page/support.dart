import 'package:flutter/material.dart';
import 'package:social_media_buttons/social_media_buttons.dart';
import 'package:url_launcher/url_launcher.dart';

class Suport extends StatelessWidget {
  const Suport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text("Get Help & Support", style : TextStyle(color : Colors.white)),
          backgroundColor: Color(0xffff79ac),
          iconTheme: IconThemeData(
              color : Colors.white
          ),
        ),
      body : Column(
        children : [
          ListTile(
            leading: SocialMediaButton.whatsapp(
              onTap: () {
                print('or just use onTap callback');
              },
              size: 35,
              color: Colors.green,
            ),
            title: Text("Whatsapp"),
            onTap: () async {
              final Uri _url = Uri.parse(
                  'https://wa.me/917978097489');
              if (!await launchUrl(_url)) {
                throw Exception('Could not launch $_url');
              }
            },
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
            leading: SocialMediaButton.skype(
              onTap: () {
                print('or just use onTap callback');
              },
              size: 35,
              color: Colors.blue,
            ),
            title: Text("Phone call"),
            onTap: () async {
              final Uri _url = Uri.parse(
                  'tel:7978097489');
              if (!await launchUrl(_url)) {
                throw Exception('Could not launch $_url');
              }
            },
            subtitle: Text("Call us directly"),
            trailing: Icon(
              Icons.arrow_forward_ios_sharp,
              color: Colors.blue,
              size: 20,
            ),
            splashColor: Colors.orange.shade300,
            tileColor: Colors.grey.shade50,
          ),
        ]
      )
    );
  }
}
