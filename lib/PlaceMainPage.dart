import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:t3leleh_v1/GeneralSettings.dart';
import 'package:t3leleh_v1/GoogleMapGetDirection.dart';
import 'package:t3leleh_v1/Tamplets/Templates.dart';
import 'package:t3leleh_v1/constans/constans.dart';
import 'package:t3leleh_v1/models/placemodel.dart';

class PlaceMainPage extends StatefulWidget {
  PlaceMainPage({this.currentplaceID='',required this.currentuserID});
  String currentplaceID,currentuserID;
  @override
  _PlaceMainPageState createState() => _PlaceMainPageState();
}



class _PlaceMainPageState extends State<PlaceMainPage> {
  int rate = 0, terrible = 1, bad = 1, okay = 1, good = 1, great = 1;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: placesref.doc(widget.currentplaceID).get(),
      builder: (BuildContext context,AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.black,
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
          );
        };
        PlaceModel placeModel= PlaceModel.fromdoc(snapshot.data);

          if(placeModel.cost_per_person.round()%3==0)
            okay=16;
          else if(placeModel.cost_per_person.round()%3==1)
            good=16;
          else great=16;


        return ImageContainerStackTemplate(
          NetworkImage(placeModel.placepicURl),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
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
                    Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                      size: 30,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          placeModel.name,
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                        Text(placeModel.city + ',' + placeModel.area,
                            style: TextStyle(color: Colors.white, fontSize: 16))
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only( top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'AVG Cost : ',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Text(
                      currencytoggle ==0?placeModel.cost_per_person.round().toString() :(placeModel.cost_per_person.round()*1.4).toStringAsFixed(1),
                      style: TextStyle(fontSize: 35, color: Colors.white),
                    ),
                    Text(
                      currencytoggle ==0?' JD':' USD',
                      style: TextStyle(fontSize: 25, color: Colors.white,fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Text(
                ' Category',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              Container(
                height: 15,
                child: Divider(
                  color: Colors.white,
                  thickness: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      placeModel.category == 'relax' ? 'Cafe` and Chalets' :
                      placeModel.category == 'gaming'
                          ? 'Game Centers'
                          : 'Tourism Sites',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(placeModel.category == 'relax'
                                  ? 'image/relax-category.png'
                                  :
                              placeModel.category == 'gaming'
                                  ? 'image/gaming-category.png'
                                  : 'image/tourism-category.png',),
                              fit: BoxFit.cover)),
                    ),
                  ],
                ),
              ),
              Text(
                ' Description',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              Container(
                height: 15,
                child: Divider(
                  color: Colors.white,
                  thickness: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Text(
                  placeModel.description,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 40.0, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'For more information : \nCall : ' + placeModel.phoneNo +
                          '\nOr visit : ' +placeModel.websiteURL,
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Text(
                '    if you interest in visit this place :',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {

                      usersref.doc(widget.currentuserID).update(
                          {'recentlyvisited':FieldValue.arrayUnion([widget.currentplaceID])});
                      Navigator.push(context, MaterialPageRoute(builder: (
                          context) {
                        return SafeArea(child: MapGetDirection(LatLng(placeModel.lat,placeModel.lng),placeModel.name));
                      }));

                    });
                  },
                  child: LinearColorBottom('GET LOCATION'),
                ),
              ),
              Text(
                ' Rate your experience',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              Container(
                height: 15,
                child: Divider(
                  color: Colors.white,
                  thickness: 1,
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
                            rate = rate == 1 ? 0 : 1;
                          });
                        },
                        child: Ratingbutton(
                            FontAwesomeIcons.solidAngry, 'Terrible',
                            rate == 1 ? Colors.white : Color(0x99ffffff))),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            ratepalance(2);
                            rate = rate == 2 ? 0 : 2;
                          });
                        },
                        child: Ratingbutton(FontAwesomeIcons.solidFrown, 'Bad',
                            rate == 2 ? Colors.white : Color(0x99ffffff))),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            ratepalance(3);
                            rate = rate == 3 ? 0 : 3;
                          });
                        },
                        child: Ratingbutton(FontAwesomeIcons.solidMeh, 'Okay',
                            rate == 3 ? Colors.white : Color(0x99ffffff))),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            ratepalance(4);
                            rate = rate == 4 ? 0 : 4;
                          });
                        },
                        child: Ratingbutton(FontAwesomeIcons.solidSmile, 'Good',
                            rate == 4 ? Colors.white : Color(0x99ffffff))),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            ratepalance(5);
                            rate = rate == 5 ? 0 : 5;
                          });
                        },
                        child: Ratingbutton(
                            FontAwesomeIcons.solidGrinBeam, 'Great',
                            rate == 5 ? Colors.white : Color(0x99ffffff))),
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
                              width: 200.0 * calculateratepercentage(great),
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
                              width: 200.0 * calculateratepercentage(good),
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
                              width: 200.0 * calculateratepercentage(okay),
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
                              width: 200.0 * calculateratepercentage(bad),
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
                              width: 200.0 * calculateratepercentage(terrible),
                              color: Colors.white,
                            )
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          calculaterate().toStringAsFixed(1),
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            rateicon(),
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                        Text(
                          ratetitle(),
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }
    );
  }

  double calculateratepercentage(int val) {
    return val / (terrible + bad + okay + good + great);
  }

  double calculaterate() {
    return calculateratesum() / (terrible + bad + okay + good + great);
  }

  int calculateratesum() {
    return (terrible + (bad * 2) + (okay * 3) + (good * 4) + (great * 5));
  }

  IconData rateicon() {
    switch (calculaterate().round()) {
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

  String ratetitle() {
    switch (calculaterate().round()) {
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

  void ratepalance(int x) {
    switch (rate) {
      case 1:
        terrible--;
        break;
      case 2:
        bad--;
        break;
      case 3:
        okay--;
        break;
      case 4:
        good--;
        break;
      case 5:
        great--;
        break;
    }
    if (x == rate) return;
    switch (x) {
      case 1:
        terrible++;
        break;
      case 2:
        bad++;
        break;
      case 3:
        okay++;
        break;
      case 4:
        good++;
        break;
      case 5:
        great++;
        break;
    }
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
