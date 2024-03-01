import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart' ;
import 'package:starwish/firebase_options.dart';
import 'package:starwish/first/onboarding.dart';
import 'package:starwish/main%20page/navigation.dart';
import 'package:starwish/providers/declare.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(); //initilization of Firebase app
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        title: 'Hote Service',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: FirebaseAuth.instance.currentUser == null ? TestScreen() : Home(),
      ),
    );
  }
}
