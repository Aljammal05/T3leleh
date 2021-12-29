import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:t3leleh_v1/ChangePasswordPage.dart';
import 'package:t3leleh_v1/EditInfoPage.dart';
import 'package:t3leleh_v1/GeneralSettings.dart';
import 'package:t3leleh_v1/HelpPage.dart';
import 'package:t3leleh_v1/MenuDrawerPage.dart';
import 'package:t3leleh_v1/ProfilePage.dart';
import 'package:t3leleh_v1/RatingPage.dart';
import 'package:t3leleh_v1/constans/constans.dart';

class SettingPage extends StatefulWidget {
  SettingPage({this.currentuserid=''});
  String currentuserid;
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String _name='',_email='',_usertype='';
  @override
  void initState(){
    super.initState();
    getuser();
  }
  getuser()async{
    var user = await usersref.doc(widget.currentuserid).get();
    setState(() {
      _name=user.data()!['name'];
      _email=user.data()!['email'];
      _usertype=user.data()!['userType'];
    });

  }
  Widget build(BuildContext context) {
    if (_usertype.isEmpty) {
      return Center(
        child: CircularProgressIndicator(
          backgroundColor: Color(0x00ffffff),
          valueColor: AlwaysStoppedAnimation( Color(0x00ffffff)),
        ),
      );
    }
    return Scaffold(
      drawer: MenuDrawerPage(currentuserid: widget.currentuserid,),
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
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 35,
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
                                Icons.edit, EditInfoPage(currentuserid: widget.currentuserid,name: _name,), 'Me',_name.length>15?_name.substring(0,15)+'...':_name
                          ),
                            SettingsContainer(Icons.person, ProfilePage(currentuserid: widget.currentuserid,),
                                'Profile',_email.length>15?_email.substring(0,15)+'...':_email
                            ),
                            SettingsContainer(Icons.star_rate_rounded,
                                RatingPage(currentuserID: widget.currentuserid,), 'Rate Us', 'Feedback , ...'),
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
                            SettingsContainer(Icons.settings, GeneralSettings(currentuserid: widget.currentuserid,type: _usertype,),
                                'General', 'Clear history , ...'),
                            SettingsContainer(Icons.lock, ChangePasswordPage(currentuserid: widget.currentuserid,),
                                'Security', 'Change Password '),
                            SettingsContainer(
                                Icons.help, HelpPage(type: _usertype,), 'Help', 'Questions ?'),
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
