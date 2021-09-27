import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:t3leleh_v1/FilterPage.dart';
import 'package:t3leleh_v1/Tamplets/Templates.dart';
import 'package:t3leleh_v1/constans/constans.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({this.currentuserid = ''});
  final String currentuserid;

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<PlaceWidget> dash1 = [];
  List<PlaceWidget> dash2 = [];
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: placesref.where('city', isEqualTo: 'Amman').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.black,
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            );
          }
          dash1 = [];
          dash2 = [];
          snapshot.data!.docs.forEach((doc) {
            if (dash1.length <= dash2.length)
              dash1.add(PlaceWidget(
                currentplaceID: doc.id,
              ));
            else
              dash2.add(PlaceWidget(
                currentplaceID: doc.id,
              ));
          });
          return DashboardTemplate(
            Color(0xb8E1D0C1),
            Color(0xb83AAEC2),
            'image/waterfall-wallpaper.jpg',
            'Dashboard',
            Icons.explore,
            FilterPage(),
            Padding(
              padding: const EdgeInsets.all(8.0),
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
                            children: dash1,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: dash2,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
