import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:t3leleh_v1/SettingsPage.dart';
import 'package:t3leleh_v1/Tamplets/Templates.dart';
import 'package:t3leleh_v1/Users/Users.dart';

class RatingPage extends StatefulWidget {

  @override
  _RatingPageState createState() => _RatingPageState();
}

int rateapp = 0,
    terribleapp = 3,
    badapp = 1,
    okayapp = 1,
    goodapp = 4,
    greatapp = 13;

class _RatingPageState extends State<RatingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 750,
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
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 30,
                        ),
                        onTap: () {
                          setState(() {
                            Navigator.pop(context);
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                Text(
                  ' Rate your experience',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
                Container(
                  height: 15,
                  child: Divider(
                    color: Colors.white,
                    thickness: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    ' Please rate your experience by using T3leleh App',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.5),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              ratepalance(1);
                              rateapp = rateapp == 1 ? 0 : 1;
                            });
                          },
                          child: Ratingbutton(
                              FontAwesomeIcons.solidAngry,
                              'Terrible',
                              rateapp == 1 ? Colors.white : Color(0x99ffffff))),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              ratepalance(2);
                              rateapp = rateapp == 2 ? 0 : 2;
                            });
                          },
                          child: Ratingbutton(
                              FontAwesomeIcons.solidFrown,
                              'Bad',
                              rateapp == 2 ? Colors.white : Color(0x99ffffff))),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              ratepalance(3);
                              rateapp = rateapp == 3 ? 0 : 3;
                            });
                          },
                          child: Ratingbutton(FontAwesomeIcons.solidMeh, 'Okay',
                              rateapp == 3 ? Colors.white : Color(0x99ffffff))),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              ratepalance(4);
                              rateapp = rateapp == 4 ? 0 : 4;
                            });
                          },
                          child: Ratingbutton(
                              FontAwesomeIcons.solidSmile,
                              'Good',
                              rateapp == 4 ? Colors.white : Color(0x99ffffff))),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              ratepalance(5);
                              rateapp = rateapp == 5 ? 0 : 5;
                            });
                          },
                          child: Ratingbutton(
                              FontAwesomeIcons.solidGrinBeam,
                              'Great',
                              rateapp == 5 ? Colors.white : Color(0x99ffffff))),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.solidGrinBeam,
                                size: 17,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: 5,
                                width: 200.0 *
                                    calculateratepercentageapp(greatapp),
                                color: Colors.white,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.solidSmile,
                                size: 17,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: 5,
                                width:
                                    200.0 * calculateratepercentageapp(goodapp),
                                color: Colors.white,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.solidMeh,
                                size: 17,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: 5,
                                width:
                                    200.0 * calculateratepercentageapp(okayapp),
                                color: Colors.white,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.solidFrown,
                                size: 17,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: 5,
                                width:
                                    200.0 * calculateratepercentageapp(badapp),
                                color: Colors.white,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.solidAngry,
                                size: 17,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: 5,
                                width: 200.0 *
                                    calculateratepercentageapp(terribleapp),
                                color: Colors.white,
                              )
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            calculaterateapp().toStringAsFixed(1),
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              rateiconapp(),
                              color: Colors.white,
                              size: 50,
                            ),
                          ),
                          Text(
                            ratetitleapp(),
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                Text(
                  ' Feedback',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
                Container(
                  height: 15,
                  child: Divider(
                    color: Colors.white,
                    thickness: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 4,
                    maxLength: 500,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                    decoration: InputDecoration(
                      fillColor: Color(0x33ffffff),
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          borderSide: BorderSide(
                            color: Color(0x66ffffff),
                          )),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide:
                              BorderSide(color: Color(0x66ffffff), width: 3.0)),
                      hintText: 'please give us your feedback',
                      hintStyle: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: GestureDetector(
                      onTap: (){
                        setState(() {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return SafeArea(child:SettingPage() );
                          }));
                        });
                      },
                      child: LinearColorBottom('SUBMIT')
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Ratingbutton extends StatelessWidget {
  Ratingbutton(this.icon, this.title, this.color);
  IconData icon;
  String title;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            icon,
            color: color,
            size: 50,
          ),
        ),
        Text(
          title,
          style: TextStyle(fontSize: 18, color: Colors.white),
        )
      ],
    );
  }
}

void ratepalance(int x) {
  switch (rateapp) {
    case 1:
      terribleapp--;
      break;
    case 2:
      badapp--;
      break;
    case 3:
      okayapp--;
      break;
    case 4:
      goodapp--;
      break;
    case 5:
      greatapp--;
      break;
  }
  if (x == rateapp) return;
  switch (x) {
    case 1:
      terribleapp++;
      break;
    case 2:
      badapp++;
      break;
    case 3:
      okayapp++;
      break;
    case 4:
      goodapp++;
      break;
    case 5:
      greatapp++;
      break;
  }
}

double calculateratepercentageapp(int val) {
  return val / (terribleapp + badapp + okayapp + goodapp + greatapp);
}

double calculaterateapp() {
  return calculateratesumapp() /
      (terribleapp + badapp + okayapp + goodapp + greatapp);
}

int calculateratesumapp() {
  return (terribleapp +
      (badapp * 2) +
      (okayapp * 3) +
      (goodapp * 4) +
      (greatapp * 5));
}

IconData rateiconapp() {
  switch (calculaterateapp().floor()) {
    case 1:
      return FontAwesomeIcons.solidAngry;
    case 2:
      return FontAwesomeIcons.solidFrown;
    case 3:
      return FontAwesomeIcons.solidMeh;
    case 4:
      return FontAwesomeIcons.solidSmile;
    case 5:
      return FontAwesomeIcons.solidGrinBeam;
    default:
      return FontAwesomeIcons.solidMeh;
  }
}

String ratetitleapp() {
  switch (calculaterateapp().floor()) {
    case 1:
      return 'Terrible';
    case 2:
      return 'Bad';
    case 3:
      return 'Okay';
    case 4:
      return 'Good';
    case 5:
      return 'Great';
    default:
      return '';
  }
}
