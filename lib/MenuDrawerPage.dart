import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:t3leleh_v1/DashboardPage.dart';
import 'package:t3leleh_v1/FavoritesPage.dart';
import 'package:t3leleh_v1/FilterPage.dart';
import 'package:t3leleh_v1/OwnedPlacespage.dart';
import 'package:t3leleh_v1/ProfilePage.dart';
import 'package:t3leleh_v1/SettingsPage.dart';
import 'package:t3leleh_v1/SignInPage.dart';
import 'package:t3leleh_v1/Statisticspage.dart';
import 'package:t3leleh_v1/Users/Users.dart';

class MenuDrawerPage extends StatefulWidget {
  @override
  _MenuDrawerPageState createState() => _MenuDrawerPageState();
}

class _MenuDrawerPageState extends State<MenuDrawerPage> {
  final _auth= FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            Color(0xff02ECB9),
            Color(0xff0C89C3)
          ], // red to yellow
          tileMode: TileMode.repeated,
        )),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        Navigator.pop(context);
                      });
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25.0, bottom: 60),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return SafeArea(child: ProfilePage());
                          }));
                        });
                      },
                      child: CircleAvatar(
                        radius: 35,
                      //  backgroundImage: widget.t3user.image,//todo
                        backgroundColor: Color(0x00ffffff),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                       // widget.t3user.username,
                        '',//todo
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text('',//todo
                        //widget.t3user.usercity,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                        )),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: MenuContainer(
                      Icons.dashboard,
                      userType == usertype.user
                          ? DashboardPage()
                          : OwnedPlacesPage(),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: MenuContainer(Icons.person, ProfilePage(currentuserid: '8bWwS1DBijgvirpsgJUw8EBNH9m2',)),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: userType == usertype.user
                          ? MenuContainer(Icons.favorite, FavoritesPage())
                          : MenuContainer(
                              FontAwesomeIcons.chartLine, StatisticPage())),
                  Expanded(
                    flex: 1,
                    child: MenuContainer(Icons.settings, SettingPage()),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: userType == usertype.user
                        ? MenuContainer(Icons.explore, FilterPage())
                        : GestureDetector(
                        onTap: (){
                          _auth.signOut();
                        },
                        child: MenuContainer(Icons.logout, SignInPage())),
                  ),
                  Expanded(
                    flex: 1,
                    child: userType == usertype.user
                        ? GestureDetector(
                        onTap: (){
                          _auth.signOut();
                        },
                        child: MenuContainer(Icons.logout, SignInPage()))
                        : Container(),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0, left: 40),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Contact us',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 50.0),
                        child: Text(
                          '+962787654321',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 50.0),
                        child: Text(
                          'T3leleh@gmail.com',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuContainer extends StatefulWidget {
  MenuContainer(this.icon, this.nextpage);
  IconData icon;
  Widget nextpage;
  @override
  _MenuContainerState createState() => _MenuContainerState();
}

class _MenuContainerState extends State<MenuContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return SafeArea(child: widget.nextpage);
          }));
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            color: Color(0x52ffffff),
          ),
          height: 90,
          child: Icon(
            widget.icon,
            color: Colors.white,
            size: 23,
          ),
        ),
      ),
    );
  }
}
