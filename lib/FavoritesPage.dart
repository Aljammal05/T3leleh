import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:t3leleh_v1/DashboardPage.dart';
import 'package:t3leleh_v1/Tamplets/Templates.dart';
import 'package:t3leleh_v1/constans/constans.dart';

class FavoritesPage extends StatefulWidget {
  FavoritesPage({this.currentuserid = ''});
  String currentuserid;

  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {

  void initState() {
    super.initState();
    fillFavoritePlaces();
  }

  void fillFavoritePlaces() async {
    List favid = await usersref.doc(widget.currentuserid).get().then((value) {
      return value.data()!['favoriteplaces'];
    });
    fav1 = [];
    fav2 = [];
    favid.reversed.forEach((place) {
        setState(() {
          if (fav1.length <= fav2.length) if (fav1.length % 2 == 0)
            fav1.add(PlaceWidget(currentuserid: widget.currentuserid,currentplaceID: place,height: 230,));
          else
            fav1.add(PlaceWidget(currentuserid: widget.currentuserid,currentplaceID: place));
          else if (fav2.length % 2 == 1)
            fav2.add(PlaceWidget( currentuserid: widget.currentuserid,currentplaceID: place, height: 230,));
          else
            fav2.add(PlaceWidget(currentuserid: widget.currentuserid,currentplaceID: place));
        });
      });
  }

  List<PlaceWidget> fav1 = [];
  List<PlaceWidget> fav2 = [];
  Widget build(BuildContext context) {
    return DashboardTemplate(
      widget.currentuserid,
      Color(0xb8E1D0C1),
      Color(0xb83AAEC2),
      'image/petra.jpg',
      'Favorites',
      Icons.dashboard,
      DashboardPage(currentuserid: widget.currentuserid,),
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
                      children: fav1,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: fav2,
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
