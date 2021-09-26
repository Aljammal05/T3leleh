import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:t3leleh_v1/AddPlace.dart';
import 'package:t3leleh_v1/EditPlace.dart';
import 'package:t3leleh_v1/OwnedPlacespage.dart';
import 'package:t3leleh_v1/ProfilePage.dart';
import 'package:t3leleh_v1/WelcomePage.dart';
import 'package:t3leleh_v1/lists/Lists.dart';
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
      home: SafeArea(child:// AddPlace(LatLng(31.963158, 35.930359))),
       // ProfilePage(currentuserid: '8bWwS1DBijgvirpsgJUw8EBNH9m2',)
        WelcomePage()
      ),
    );
  }
}
