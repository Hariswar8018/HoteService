import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:starwish/second/track.dart';

import '../models/order.dart' ;

class No_M extends StatelessWidget {
  SessionModel user ;
  No_M({super.key, required this.user});

  String sy(String g) {

    DateTime dateTime = DateTime.parse(g);
    String formattedDate = DateFormat('dd, MMM yy').format(dateTime);
    String formattedTime = DateFormat('hh:mm a').format(dateTime);
    print(formattedDate); // Output: 28, Jan 22
    return formattedDate + " At " + formattedTime;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffff79ac),
        title: Text(
          "Order : "+ user.Name,
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(
          color : Colors.white
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 25,),
            Text("   # Customer Details :-" , style : TextStyle(fontWeight: FontWeight.w500, fontSize: 25)),
            ListTile(
              title: Text( user.User_Name , style : TextStyle(fontWeight: FontWeight.w800, fontSize: 21)),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(user.User_Pic),
              ),
              tileColor: Colors.white,
              subtitle: Text(user.User_Phone, style : TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
              trailing: Text("Order done on :" + user.User_Time),
              splashColor: Colors.orange.shade300,
            ),
            SizedBox(height: 25,),
            Text("   # Customer Details :-" , style : TextStyle(fontWeight: FontWeight.w500, fontSize: 25)),
            ListTile(
              title: Text( "Status : " + user.Update_Status ,maxLines: 1, style : TextStyle(fontWeight: FontWeight.w800, fontSize: 21)),
              leading:  Icon(Icons.local_shipping_rounded, color : Color(0xffff79ac), size : 35),
              tileColor: Colors.white,
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Ship(id: user.id)),
                );
              },
              subtitle: Text(" Last Updated on : " + sy(user.Last_Update), style : TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
              trailing: Icon(Icons.arrow_forward_ios_rounded,  color : Color(0xffff79ac)),
              splashColor: Colors.orange.shade300,
            ),
            SizedBox(height: 25,),
            Text("   # Order Details :-" , style : TextStyle(fontWeight: FontWeight.w500, fontSize: 25)),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Card(
                color: Colors.white,
                child: Container(color: Colors.white,
                  width : MediaQuery.of(context).size.width,
                  child : Column(
                    children: [
                      SizedBox(height : 20),
                      Container(
                        width : MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children : [
                           s(true, user.U1, user.U2, user.U3),
                            s( true, user.F1, user.F2, user.F3),
                            s( false , user.A1, user.A2,user.A3)
        
                          ]
                        ),
                      ),
                      SizedBox(height : 15),
                      Container(
                        width : MediaQuery.of(context).size.width,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children : [
                              s(false, user.B1,user.B2, user.B3),
                              s(false, "https://static.vecteezy.com/system/resources/previews/024/043/961/original/money-clipart-transparent-background-free-png.png", "Price", "₹" + user.C3),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.network("https://pbs.twimg.com/media/DSvpLf0VQAAQRro.jpg", width : 50, height : 50),
                                  Text("Made fot" , style : TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
                                  Text(user.D3 , style : TextStyle(fontWeight: FontWeight.w900, fontSize: 19)),
                                ],
                              )
                            ]
                        ),
                      ),
                      SizedBox(height : 25),
                    ],
                  )
                ),
              ),
            ),
            SizedBox(height: 25,),
            Text("   # Developer Details :-" , style : TextStyle(fontWeight: FontWeight.w500, fontSize: 25)),
            ListTile(
              title: Text( "Ayusman Samasi" , style : TextStyle(fontWeight: FontWeight.w800, fontSize: 21)),
              leading: CircleAvatar(
                backgroundImage: NetworkImage("https://i.pinimg.com/736x/77/9a/f5/779af5eed8cdce11a8f4cb86c8b4db46.jpg"),
              ),
              tileColor: Colors.white,
              subtitle: user.U2 == "Flutter" ? Text("Frontend & Backend Developed", style : TextStyle(fontWeight: FontWeight.w600, fontSize: 15)) :
              Text("Sketch & Illustrator", style : TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
              splashColor: Colors.orange.shade300,
            ),
            SizedBox(height: 25,),
          ],
        ),
      ),
      persistentFooterButtons: [
        Padding(
          padding: const EdgeInsets.all(1.0),
          child: SocialLoginButton(
            backgroundColor: Color(0xff50008e),
            height: 40,
            text: 'Check Order Status',
            borderRadius: 20,
            fontSize: 21,
            buttonType: SocialLoginButtonType.generalLogin,
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Ship(id: user.id)),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget s( bool b , String s1, String s2, String s3){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.network(s1, width : 50, height : 50),
       b ?  Text(s2  + " Version"  , style : TextStyle(fontWeight: FontWeight.w500, fontSize: 14)) :
       Text(s2  , style : TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
        Text(s3 , style : TextStyle(fontWeight: FontWeight.w900, fontSize: 19)),
      ],
    );
  }
}
