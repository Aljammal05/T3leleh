import 'package:flutter/material.dart';
import 'package:t3leleh_v1/Services/AutoLoginServies.dart';
import 'package:t3leleh_v1/WelcomePage.dart';
import 'package:firebase_core/firebase_core.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(child:
        //DashboardPage(currentuserid: '8bWwS1DBijgvirpsgJUw8EBNH9m2',)
       // WelcomePage()
        AutoLoginServies()
      ),
    );
  }
}
