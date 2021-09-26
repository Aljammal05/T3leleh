import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:t3leleh_v1/DashboardPage.dart';
import 'package:t3leleh_v1/OwnedPlacespage.dart';
import 'package:t3leleh_v1/Tamplets/Templates.dart';
import 'package:t3leleh_v1/Users/Users.dart';
import 'package:t3leleh_v1/lists/Lists.dart';

class GeneralSettings extends StatefulWidget {
  @override
  _GeneralSettingsState createState() => _GeneralSettingsState();
}
int currencytoggle = 1;
class _GeneralSettingsState extends State<GeneralSettings> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1,
            child: Material(
              elevation: 4,
              shadowColor: Colors.grey,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(45)),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(45)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[
                        Color(0xff02ECB9),
                        Color(0xff0C89C3)
                      ], // red to yellow
                      tileMode: TileMode.repeated,
                    )),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Align(
                        child: GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
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
                        alignment: Alignment.topLeft,
                      ),
                    ),
                    Expanded(
                      flex: 15,
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.only(right: 60.0),
                        child: Text(
                          'General',
                          style: TextStyle(color: Colors.white, fontSize: 28),
                        ),
                      )),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 32.0, top: 32),
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          //todo
                          // if (widget.t3user.type==usertype.owner){
                          // widget.t3user.ownedlist1.clear();
                          // widget.t3user.ownedlist2.clear();
                          // widget.t3user.profownedlist.clear();
                          // Navigator.push(context, MaterialPageRoute(builder: (context) {
                          //   return SafeArea(
                          //     child: OwnedPlacesPage(),
                          //   );
                          // }));}
                          // else{
                          //   profreclist.clear();
                          //   proffavlist.clear();
                          //   favlist1.clear();
                          //   favlist2.clear();Navigator.push(context, MaterialPageRoute(builder: (context) {
                          //     return SafeArea(
                          //       child: DashboardPage(),
                          //     );
                          //   }));
                          // }

                        });
                      },
                      child: Text(
                        userType == usertype.user
                            ? 'Clear History'
                            : 'Clear Data',
                        style: TextStyle(
                          fontSize: 22,
                          color: Color(0xff2BCEC6),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 52.0, vertical: 20),
                    child: Text(
                      userType == usertype.user
                          ? 'delete all places you have recently checked in ,\nowned , mark as favorite'
                          : 'delete all places you owned, clear all statistic .',
                      style: TextStyle(color: Colors.grey.shade500),
                    ),
                  ),
                 /* Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Divider(
                      color: Colors.grey.shade400,
                      thickness: 1,
                    ),
                  ),
                  userType == usertype.user
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 35),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Temperature unit',
                                style: TextStyle(
                                    color: Colors.grey.shade600, fontSize: 20),
                              ),
                              Material(
                                elevation: 4,
                                shadowColor: Colors.grey,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(90)),
                                child: AnimatedToggle(['F°', 'C°'], (value) {
                                  setState(() {
                                    _toggleValue = value;
                                    print(_toggleValue);
                                  });
                                },
                                    const Color(0xFFffffff),
                                    const Color(0xFFffffff),
                                    118,
                                    25.5,
                                    17,
                                    14,
                                    20),
                              ),
                            ],
                          ),
                        )
                      : Container(),*/

                       Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Divider(
                            color: Colors.grey.shade400,
                            thickness: 1,
                          ),
                        )
                      ,
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 35),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Currency',
                          style: TextStyle(
                              color: Colors.grey.shade600, fontSize: 20),
                        ),
                        Material(
                          elevation: 4,
                          shadowColor: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(90)),
                          child: AnimatedToggle(['USD', 'J.D'], (value) {
                            setState(() {
                              currencytoggle = value;
                            });
                          }, const Color(0xFFffffff), const Color(0xffffffff),
                              118, 25.5, 17, 14, 20),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
