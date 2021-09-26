import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:t3leleh_v1/GoogleMapSetLocation.dart';
import 'package:t3leleh_v1/OwnedPlacespage.dart';
import 'package:t3leleh_v1/Place.dart';
import 'package:t3leleh_v1/Services/AddplaceServies.dart';
import 'package:t3leleh_v1/Services/StorageService.dart';
import 'package:t3leleh_v1/Statisticspage.dart';
import 'package:t3leleh_v1/Tamplets/Templates.dart';
import 'package:t3leleh_v1/ProfilePage.dart';
import 'package:t3leleh_v1/Users/Users.dart';
import 'package:t3leleh_v1/lists/Lists.dart';

class AddPlace extends StatefulWidget {
  AddPlace(this.placepos);
  LatLng placepos = LatLng(31.963158, 35.930359);
  @override
  _AddPlaceState createState() => _AddPlaceState();
}

int placeID = 4;

class _AddPlaceState extends State<AddPlace> {
  RangeValues totalbudget = RangeValues(0, 20);

  String placecity = '',
      placearea = '',
      placename = '',
      placedescription = '',
      placephoneNO = '',
      placeURL = '',
      placepicURL='',
      placecategory = '';
  Color gamingcolor = Color(0x55ffffff),
      relaxcolor = Color(0x55ffffff),
      tourismcolor = Color(0x55ffffff);
  @override
  // XFile? img;
  // Future getimage() async {
  //   final XFile? image =
  //       await ImagePicker().pickImage(source: ImageSource.gallery);
  //   setState(() {
  //     img = image!;
  //   });
  // }
  //
  // Future takeimage() async {
  //   final XFile? image =
  //       await ImagePicker().pickImage(source: ImageSource.camera);
  //   setState(() {
  //     img = image!;
  //   });
  // }

  Widget build(BuildContext context) {
    return ImageContainerStackTemplate(
     placepicURL.isEmpty
          ? AssetImage('image/default.png')
          : NetworkImage(placepicURL)as ImageProvider,
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
                Container()
              ],
            ),
          ),
          SizedBox(
            height: 105,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: GestureDetector(
                    onTap: () async {
                      final PickedFile? image = await ImagePicker()
                          .getImage(source: ImageSource.camera);
                      File img = File(image!.path);
                      String url=await StorageService.uploadPlacePicture(placepicURL, img);
                      setState(() {
                        placepicURL=url;
                      });
                    },
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    final PickedFile? image = await ImagePicker()
                        .getImage(source: ImageSource.gallery);
                    File img = File(image!.path);
                    String url=await StorageService.uploadPlacePicture(placepicURL, img);
                    setState(() {
                      placepicURL=url;
                    });
                  },
                  child: Icon(
                    Icons.add_photo_alternate,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ' Information',
              style: TextStyle(fontSize: 22, color: Colors.white),
            ),
            Container(
              height: 15,
              child: Divider(
                color: Colors.white,
                thickness: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 20),
              child: Text(
                ' Name',
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (val) {
                  setState(() {
                    placename = val;
                  });
                },
                keyboardType: TextInputType.multiline,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 18),
                decoration: InputDecoration(
                  fillColor: Color(0x33ffffff),
                  filled: true,
                  hintText: 'Your Place Name',
                  hintStyle: TextStyle(color: Colors.white, fontSize: 20),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(90),
                      ),
                      borderSide: BorderSide(
                        color: Color(0x66ffffff),
                      )),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(90),
                      borderSide:
                          BorderSide(color: Color(0x22ffffff), width: 3.0)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 20),
              child: Text(
                ' Description',
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (val) {
                  setState(() {
                    placedescription = val;
                  });
                },
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                maxLength: 500,
                style: TextStyle(color: Colors.white, fontSize: 18),
                decoration: InputDecoration(
                  fillColor: Color(0x33ffffff),
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                      borderSide: BorderSide(
                        color: Color(0x66ffffff),
                      )),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide:
                          BorderSide(color: Color(0x22ffffff), width: 3.0)),
                  hintText: 'Write description of your place',
                  hintStyle: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            Text(
              ' Category',
              style: TextStyle(fontSize: 22, color: Colors.white),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          gamingcolor = Color(0xb83AAEC2);
                          placecategory = 'gaming';
                          if (tourismcolor == Color(0xb83AAEC2) ||
                              relaxcolor == Color(0xb83AAEC2))
                            tourismcolor = relaxcolor = Color(0x55ffffff);
                        });
                      },
                      child: Categoryaddplace(
                          'image/gaming-category.png', gamingcolor)),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          tourismcolor = Color(0xb83AAEC2);
                          placecategory = 'tourism';
                          if (gamingcolor == Color(0xb83AAEC2) ||
                              relaxcolor == Color(0xb83AAEC2))
                            gamingcolor = relaxcolor = Color(0x55ffffff);
                        });
                      },
                      child: Categoryaddplace(
                          'image/tourism-category.png', tourismcolor)),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          relaxcolor = Color(0xb83AAEC2);
                          placecategory = 'relax';
                          if (tourismcolor == Color(0xb83AAEC2) ||
                              gamingcolor == Color(0xb83AAEC2))
                            tourismcolor = gamingcolor = Color(0x55ffffff);
                        });
                      },
                      child: Categoryaddplace(
                          'image/relax-category.png', relaxcolor)),
                ],
              ),
            ),
            Text(
              ' AVG Cost',
              style: TextStyle(fontSize: 22, color: Colors.white),
            ),
            Container(
              height: 15,
              child: Divider(
                color: Colors.white,
                thickness: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    totalbudget.start.round().toString() +
                        ' - ' +
                        totalbudget.end.round().toString(),
                    style: TextStyle(color: Colors.white, fontSize: 33),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'JD',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            RangeSlider(
                values: totalbudget,
                min: 0,
                max: 150,
                divisions: 15,
                activeColor: Color(0xff3AAEC2),
                inactiveColor: Color(0xffffffff),
                onChanged: (newval) {
                  setState(() {
                    totalbudget = newval;
                  });
                }),
            Text(
              ' Location',
              style: TextStyle(fontSize: 22, color: Colors.white),
            ),
            Container(
              height: 15,
              child: Divider(
                color: Colors.white,
                thickness: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Dropdownbox(
                ['Amman', 'Zarqa', 'Aqaba', 'Irbid'],
                'Select your City',
                (val) {
                  setState(() {
                    placecity = val;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Dropdownbox(
                city(placecity),
                'Select your Area',
                (val) {
                  placearea = val;
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 12),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SafeArea(child: MapSetLocation());
                    }));
                  });
                },
                child: LinearColorBottom('SET LOCATION'),
              ),
            ),
            Text(
              ' Contact Us',
              style: TextStyle(fontSize: 22, color: Colors.white),
            ),
            Container(
              height: 15,
              child: Divider(
                color: Colors.white,
                thickness: 1,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (val) {
                  setState(() {
                    placephoneNO = val;
                  });
                },
                keyboardType: TextInputType.multiline,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 18),
                decoration: InputDecoration(
                  fillColor: Color(0x33ffffff),
                  filled: true,
                  hintText: 'Phone NO',
                  hintStyle: TextStyle(color: Colors.white, fontSize: 20),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(90),
                      ),
                      borderSide: BorderSide(
                        color: Color(0x66ffffff),
                      )),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(90),
                      borderSide:
                          BorderSide(color: Color(0x22ffffff), width: 3.0)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (val) {
                  setState(() {
                    placeURL = val;
                  });
                },
                keyboardType: TextInputType.multiline,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 18),
                decoration: InputDecoration(
                  fillColor: Color(0x33ffffff),
                  filled: true,
                  hintText: 'Website / FB Page URL',
                  hintStyle: TextStyle(color: Colors.white, fontSize: 20),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(90),
                      ),
                      borderSide: BorderSide(
                        color: Color(0x66ffffff),
                      )),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(90),
                      borderSide:
                          BorderSide(color: Color(0x22ffffff), width: 3.0)),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    //   placeslist.add(Place(
                    //   name: placename,
                    //   description: placedescription,
                    //   category: placecategory,
                    //   city: placecity,
                    //   area: placearea,
                    //   phoneNO: placephoneNO,
                    //   URL: placeURL,
                    // ));
                    //   placeslist[placeID].location=widget.placepos;
                    //   placeslist[placeID].AVGcost=totalbudget;
                    //   placeslist[placeID].image= img==null?AssetImage('image/default.png'):Image.file(File(img!.path)).image;
                    //   placeslist[placeID].placeid=placeID;
                    //   //widget.t3user.ownedlist1.add(PlaceWidget(placeslist[placeID],widget.t3user));
                    //   //widget.t3user.profownedlist.add(RecentWidget(placeslist[placeID],widget.t3user));
                    //  // dashlist1.add(PlaceWidget(placeslist[placeID],widget.t3user));
                    //   //widget.t3user.statisticlist.add(PlaceStatisticWidget(placeslist[placeID]));
                    //   //todo
                    //   placeID++;
                    AddPlace_Services.add_Place(
                        '8bWwS1DBijgvirpsgJUw8EBNH9m2',
                        totalbudget,
                        widget.placepos.latitude,
                        widget.placepos.longitude,
                        placename,
                        placedescription,
                        placecity,
                        placearea,
                        placephoneNO,
                        placeURL,
                        placepicURL,
                        placecategory);

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SafeArea(child:OwnedPlacesPage());
                    }));
                  });
                },
                child: LinearColorBottom('SAVE'),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<String> city(String s) {
    switch (s) {
      case 'Amman':
        return Amman;
      case 'Zarqa':
        return Zarqa;
      case 'Irbid':
        return Irbid;
      case 'Aqaba':
        return Aqaba;
      default:
        return ['please select city'];
    }
  }
}
