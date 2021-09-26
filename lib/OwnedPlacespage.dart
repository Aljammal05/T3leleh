import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:t3leleh_v1/Statisticspage.dart';
import 'package:t3leleh_v1/Tamplets/Templates.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:t3leleh_v1/Users/Users.dart';
import 'package:t3leleh_v1/lists/Lists.dart';
import 'AddPlace.dart';
class OwnedPlacesPage extends StatefulWidget {
  _OwnedPlacesPageState createState() => _OwnedPlacesPageState();
}
late User loggedinUse;
class _OwnedPlacesPageState extends State<OwnedPlacesPage> {
  final _auth = FirebaseAuth.instance;
  void initState() {
    super.initState();
    getcurrentuser();
  }
  void getcurrentuser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) loggedinUse = user;
    } catch (e) { print(e); }
  }

  Widget build(BuildContext context) {
    return Stack(
      children: [
        DashboardTemplate(
          Color(0xb8E1D0C1),
          Color(0xb83AAEC2),
          'image/waterfall-wallpaper.jpg',
          'Owned Places',
          FontAwesomeIcons.chartLine,
          StatisticPage(),
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
                          children: [PlaceWidget(currentplaceID: '8bWwS1DBijgvirpsgJUw8EBNH9m2-home-Khalda',)],
                         // children: widget.t3user.ownedlist1,
                          //todo
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                         // children: widget.t3user.ownedlist2,
                          //todo
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
          right: 15,bottom: 15,
          child: FloatingActionButton(
            backgroundColor: Color(0xff3AAEC2),
            onPressed: () {
              setState(() {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                      return SafeArea(child:AddPlace(LatLng(31.963158, 35.930359)),);
                    }));});
            },
            child: Icon(Icons.add),
          ),
        )
      ],
    );
  }
}
