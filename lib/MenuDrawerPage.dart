import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:t3leleh_v1/DashboardPage.dart';
import 'package:t3leleh_v1/FavoritesPage.dart';
import 'package:t3leleh_v1/FilterPage.dart';
import 'package:t3leleh_v1/OwnedPlacespage.dart';
import 'package:t3leleh_v1/ProfilePage.dart';
import 'package:t3leleh_v1/SettingsPage.dart';
import 'package:t3leleh_v1/SignInPage.dart';
import 'package:t3leleh_v1/Statisticspage.dart';
import 'package:t3leleh_v1/constans/constans.dart';

class MenuDrawerPage extends StatefulWidget {
  MenuDrawerPage({this.currentuserid = ''});
  final String currentuserid;
  @override
  _MenuDrawerPageState createState() => _MenuDrawerPageState();
}

class _MenuDrawerPageState extends State<MenuDrawerPage> {
  final _auth = FirebaseAuth.instance;
  String _name = '', _city = '', _picurl = '', _usertype = '';
  @override
  void initState() {
    super.initState();
    getuser();
  }

  getuser() async {
    var user = await usersref.doc(widget.currentuserid).get();
    setState(() {
      _name = user.data()!['name'];
      _city = user.data()!['city'];
      _picurl = user.data()!['ProfilePicURL'];
      _usertype = user.data()!['userType'];
    });
  }

  Widget build(BuildContext context) {
    if (_usertype.isEmpty) {
      return Center(
        child: CircularProgressIndicator(
          backgroundColor: Color(0x00ffffff),
          valueColor: AlwaysStoppedAnimation(Color(0x00ffffff)),
        ),
      );
    }
    return Drawer(
      child: SingleChildScrollView(
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
                SizedBox(
                  height: 10,
                ),
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
                              return SafeArea(
                                  child: ProfilePage(
                                currentuserid: widget.currentuserid,
                              ));
                            }));
                          });
                        },
                        child: CircleAvatar(
                          radius: 35,
                          backgroundImage: _picurl.isEmpty
                              ? AssetImage('image/profile-default-pic.jpg')
                              : NetworkImage(_picurl) as ImageProvider,
                          backgroundColor: Color(0x00ffffff),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          _name,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(_city,
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
                          _usertype == 'user'
                              ? DashboardPage(
                                  currentuserid: widget.currentuserid,
                                )
                              : OwnedPlacesPage(
                                  currentuserid: widget.currentuserid,
                                ),
                          () {}),
                    ),
                    Expanded(
                      flex: 1,
                      child: MenuContainer(
                          Icons.person,
                          ProfilePage(
                            currentuserid: widget.currentuserid,
                          ),
                          () {}), //todo
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: _usertype == 'user'
                            ? MenuContainer(
                                Icons.favorite,
                                FavoritesPage(
                                  currentuserid: widget.currentuserid,
                                ),
                                () {})
                            : MenuContainer(FontAwesomeIcons.chartLine,
                                StatisticPage(), () {})),
                    Expanded(
                      flex: 1,
                      child: MenuContainer(
                          Icons.settings,
                          SettingPage(
                            currentuserid: widget.currentuserid,
                          ),
                          () {}),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: _usertype == 'user'
                          ? MenuContainer(
                              Icons.explore,
                              FilterPage(
                                currentuserid: widget.currentuserid,
                              ),
                              () {})
                          : MenuContainer(Icons.logout, SignInPage(), () async{
                            SharedPreferences pref =await SharedPreferences.getInstance();
                            pref.clear();
                            print(pref.getString('email'));
                              _auth.signOut();
                              print("hello");
                            }),
                    ),
                    Expanded(
                      flex: 1,
                      child: _usertype == 'user'
                          ? MenuContainer(Icons.logout, SignInPage(), () async{
                        SharedPreferences pref =await SharedPreferences.getInstance();
                        pref.clear();
                        print(pref.getString('email'));
                        _auth.signOut();
                        print("hello");
                            })
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
      ),
    );
  }
}

class MenuContainer extends StatefulWidget {
  MenuContainer(this.icon, this.nextpage, this.fun);
  final IconData icon;
  final Widget nextpage;
  Function fun;
  @override
  _MenuContainerState createState() => _MenuContainerState();
}

class _MenuContainerState extends State<MenuContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.fun();
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
