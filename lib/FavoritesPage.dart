import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:t3leleh_v1/DashboardPage.dart';
import 'package:t3leleh_v1/Tamplets/Templates.dart';
import 'package:t3leleh_v1/Users/Users.dart';
import 'lists/Lists.dart';
class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return DashboardTemplate(
      Color(0xb8E1D0C1),
      Color(0xb83AAEC2),
      'image/petra.jpg',
      'Favorites',
      Icons.dashboard,
      DashboardPage(),
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
                      children: favlist1,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: favlist2,
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
