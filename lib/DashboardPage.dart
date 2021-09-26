import 'package:flutter/material.dart';
import 'package:t3leleh_v1/FilterPage.dart';
import 'package:t3leleh_v1/Tamplets/Templates.dart';
import 'package:t3leleh_v1/constans/constans.dart';
class DashboardPage extends StatefulWidget {
  DashboardPage({this.currentuserid=''});
  String currentuserid;

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  List <PlaceWidget> dash1 =[];
  void fun ()async{
    var db=await placesref.where('city',isEqualTo: 'Amman').get();
    dash1 =[];
    db.docs.forEach((doc) {dash1.add(PlaceWidget(currentplaceID: doc.id,));});

  }
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
                      children: [GestureDetector(
                          onTap:(){setState(() {
                            fun();
                          });},
                          child: Container(height: 100,width: 100,color: Colors.white,))],
                      //children: dashlist1,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: dash1,
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
