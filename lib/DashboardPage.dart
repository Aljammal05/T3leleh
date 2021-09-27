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
  fun ()async{

    var db=await placesref.where('city',isEqualTo: 'Amman').get();
    dash1 =[];
    dash2=[];
    db.docs.forEach((doc) {
      setState(() {
        if(dash1.length<=dash2.length)
          dash1.add(PlaceWidget(currentplaceID: doc.id,));
        else
          dash2.add(PlaceWidget(currentplaceID: doc.id,));

      });
    });
  }
  List <PlaceWidget> dash1 =[];
  List <PlaceWidget> dash2 =[];
  Widget build(BuildContext context) {
fun();
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
  }
}
