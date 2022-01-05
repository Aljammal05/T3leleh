import 'package:flutter/material.dart';
import 'package:t3leleh_v1/Statisticspage.dart';
import 'package:t3leleh_v1/Tamplets/Templates.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:t3leleh_v1/constans/constans.dart';
import 'AddPlace.dart';

class OwnedPlacesPage extends StatefulWidget {
  OwnedPlacesPage({this.currentuserid=''});
  String currentuserid;
  _OwnedPlacesPageState createState() => _OwnedPlacesPageState();
}
class _OwnedPlacesPageState extends State<OwnedPlacesPage> {

  void initState() {
    super.initState();
    fillOwnedPlaces();
  }

  void fillOwnedPlaces() async {
    List ownedid = await usersref.doc(widget.currentuserid).get().then((value) {
      return value.data()!['ownedplaces'];
    });
    owned1 = [];
    owned2 = [];
    ownedid.reversed.forEach((place) {
      setState(() {
        if (owned1.length <= owned2.length) if (owned1.length % 2 == 0)
          owned1.add(PlaceWidget(currentuserid: widget.currentuserid,currentplaceID: place,height: 230,));
        else
          owned1.add(PlaceWidget(currentuserid: widget.currentuserid,currentplaceID: place));
        else if (owned2.length % 2 == 1)
          owned2.add(PlaceWidget(currentuserid: widget.currentuserid, currentplaceID: place, height: 230,));
        else
          owned2.add(PlaceWidget(currentuserid: widget.currentuserid,currentplaceID: place));
      });
    });
  }

  List<PlaceWidget> owned1 = [];
  List<PlaceWidget> owned2 = [];
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DashboardTemplate(
          widget.currentuserid,
          Color(0xb8E1D0C1),
          Color(0xb83AAEC2),
          'image/waterfall-wallpaper.jpg',
          'Owned Places',
          FontAwesomeIcons.chartLine,
          StatisticPage(currentuserid: widget.currentuserid,),
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
                          children: owned1
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: owned2
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
                      return SafeArea(child:AddPlace(currentuserid: widget.currentuserid,),);
                    }));});
            },
            child: Icon(Icons.add),
          ),
        )
      ],
    );
  }
}
