import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:t3leleh_v1/ChangePasswordPage.dart';
import 'package:t3leleh_v1/EditInfoPage.dart';
import 'package:t3leleh_v1/GeneralSettings.dart';
import 'package:t3leleh_v1/HelpPage.dart';
import 'package:t3leleh_v1/MenuDrawerPage.dart';
import 'package:t3leleh_v1/ProfilePage.dart';
import 'package:t3leleh_v1/RatingPage.dart';
import 'package:t3leleh_v1/Users/Users.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuDrawerPage(),
      body: Builder(
        builder: (context) => Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Color(0xff02ECB9),
                Color(0xff0C89C3)
              ], // red to yellow
              tileMode: TileMode.repeated,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25.0, top: 35),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            Scaffold.of(context).openDrawer();
                          });
                        },
                        child: Icon(
                          Icons.menu,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 15,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 55.0),
                          child: Text(
                            'Settings',
                            style: TextStyle(fontSize: 27, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 80, left: 25, right: 25),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 125),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SettingsContainer(
                                Icons.edit, EditInfoPage(), 'Me','',//todo
                          // widget.t3user.username
                          ),
                            SettingsContainer(Icons.person, ProfilePage(),
                                'Profile','',//todo
                              // widget.t3user.useremail.substring(0,15)
                            ),
                            SettingsContainer(Icons.star_rate_rounded,
                                RatingPage(), 'Rate Us', 'Feedback , ...'),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 125),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SettingsContainer(Icons.settings, GeneralSettings(),
                                'General', 'Clear history , ...'),
                            SettingsContainer(Icons.lock, ChangePasswordPage(),
                                'Security', 'Change Password '),
                            SettingsContainer(
                                Icons.help, HelpPage(), 'Help', 'Questions ?'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsContainer extends StatefulWidget {
  SettingsContainer(this.icon, this.nextpage, this.text1, this.text2);
  IconData icon;
  Widget nextpage;
  String text1;
  String text2;
  @override
  _SettingsContainerState createState() => _SettingsContainerState();
}

class _SettingsContainerState extends State<SettingsContainer> {
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
        padding: const EdgeInsets.all(7.5),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            color: Color(0x52ffffff),
          ),
          height: 110,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  widget.icon,
                  color: Colors.white,
                  size: 23,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  widget.text1,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  widget.text2,
                  style: TextStyle(fontSize: 13, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
