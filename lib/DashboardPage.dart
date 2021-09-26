import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:t3leleh_v1/FilterPage.dart';
import 'package:t3leleh_v1/Place.dart';
import 'package:t3leleh_v1/Tamplets/Templates.dart';
import 'package:t3leleh_v1/Users/Users.dart';
import 'package:t3leleh_v1/lists/Lists.dart';
class DashboardPage extends StatefulWidget {
  DashboardPage();
  @override
  _DashboardPageState createState() => _DashboardPageState();
}
late User loggedinUser;
class _DashboardPageState extends State<DashboardPage> {

  final _auth = FirebaseAuth.instance;
  void initState() {
  super.initState();
  getcurrentuser();
  placeslist[0].image=AssetImage('image/alkhazneh.jpg');
  placeslist[0].location=LatLng(30.328960, 35.444832);
  placeslist[0].AVGcost=RangeValues(0, 0);
  placeslist[1].image=AssetImage('image/alqal3ah.jpg');
  placeslist[1].location=LatLng(31.9543571, 35.9348363);
  placeslist[1].AVGcost=RangeValues(0, 0);
  placeslist[2].image=AssetImage('image/deadsea.jpg');
  placeslist[2].location=LatLng(31.5752376, 35.5528751);
  placeslist[2].AVGcost=RangeValues(0, 0);
  placeslist[3].image=AssetImage('image/romani.jpg');
  placeslist[3].location=LatLng(31.9522159, 35.9393253);
  placeslist[3].AVGcost=RangeValues(0, 0);
  dashlist2[0].height=230;
  dashlist2[1].height=230;

  }
  void getcurrentuser() async {
  try {
  final user = await _auth.currentUser;
  if (user != null) loggedinUser = user;
  } catch (e) { print(e); }
  }
  @override

  Widget build(BuildContext context) {
    return DashboardTemplate(
      Color(0xb8E1D0C1),
      Color(0xb83AAEC2),
      'image/waterfall-wallpaper.jpg',
      'Dashboard',
      Icons.explore,
      FilterPage(),
      Padding( padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: dashlist1,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: dashlist2,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
