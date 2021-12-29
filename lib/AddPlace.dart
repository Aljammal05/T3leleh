import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:t3leleh_v1/Dialogs/Dialogs.dart';
import 'package:t3leleh_v1/GoogleMapSetLocation.dart';
import 'package:t3leleh_v1/OwnedPlacespage.dart';
import 'package:t3leleh_v1/Services/AddplaceServies.dart';
import 'package:t3leleh_v1/Services/StorageService.dart';
import 'package:t3leleh_v1/Tamplets/Templates.dart';
import 'package:t3leleh_v1/lists/Lists.dart';

class AddPlace extends StatefulWidget {
  AddPlace(
      {this.placepos = const LatLng(31.963158, 35.930359),
      required this.currentuserid});
  LatLng placepos;
  String currentuserid;
  @override
  _AddPlaceState createState() => _AddPlaceState();
}

class _AddPlaceState extends State<AddPlace> {
  double cost_per_person = 0;
  File? _img;
  String placecity = '',
      placearea = '',
      placename = '',
      placedescription = '',
      placephoneNO = '',
      placeURL = '',
      _placepicurl = '',
      placecategory = '';
  Color gamingcolor = Color(0x55ffffff),
      relaxcolor = Color(0x55ffffff),
      tourismcolor = Color(0x55ffffff);
  @override
  void updatePos(LatLng pos) {
    setState(() => widget.placepos = pos);
  }

  void moveToGoogleSetLocation() async {
    final pos = await Navigator.push(
      context,
      CupertinoPageRoute(
          fullscreenDialog: true, builder: (context) => MapSetLocation()),
    );
    updatePos(pos);
  }

  displayimage() {
    if (_img == null) {
      return AssetImage('image/default.png');
    } else {
      return FileImage(_img!);
    }
  }

  Widget build(BuildContext context) {
    return ImageContainerStackTemplate(
      displayimage(),
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
                      setState(() {
                        _img = File(image!.path);
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
                    setState(() {
                      _img = File(image!.path);
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
              ' AVG Cost Per Person',
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
                    cost_per_person.round().toString(),
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
            Slider(
                value: cost_per_person,
                min: 0,
                max: 25,
                divisions: 25,
                activeColor: Color(0xff3AAEC2),
                inactiveColor: Color(0xffffffff),
                onChanged: (newval) {
                  setState(() {
                    cost_per_person = newval;
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
                onTap: moveToGoogleSetLocation,
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
                onTap: () async {
                  if (cost_per_person != 0 &&
                      placename.isNotEmpty &&
                      placedescription.isNotEmpty &&
                      placecategory.isNotEmpty &&
                      placecity.isNotEmpty &&
                      placearea.isNotEmpty &&
                      placephoneNO.isNotEmpty &&
                      placeURL.isNotEmpty &&
                      widget.placepos.longitude != 35.93035900000001 &&
                      widget.placepos.latitude != 31.963158 &&
                      _img != null) {
                    showDialog<void>(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => WaitingDialog());
                    _placepicurl = await StorageService.uploadPlacePicture(
                        _placepicurl, _img!);
                    AddPlace_Services.add_Place(
                        widget.currentuserid,
                        cost_per_person,
                        widget.placepos.latitude,
                        widget.placepos.longitude,
                        placename,
                        placedescription,
                        placecity,
                        placearea,
                        placephoneNO,
                        placeURL,
                        _placepicurl,
                        placecategory);
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SafeArea(
                          child: OwnedPlacesPage(
                        currentuserid: widget.currentuserid,
                      ));
                    }));
                  } else {
                    if (cost_per_person == 0 ||
                        placename.isEmpty ||
                        placedescription.isEmpty ||
                        placecategory.isEmpty ||
                        placecity.isEmpty ||
                        placearea.isEmpty ||
                        placephoneNO.isEmpty ||
                        placeURL.isEmpty)
                      showDialog<void>(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => ErrorDialog(
                                title: 'Sorry',
                                text:
                                    'All of fields are required,\nPlease fill all of them.',
                              ));
                    else if (_img == null)
                      showDialog<void>(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => ErrorDialog(
                                title: 'Invalid Image',
                                text:
                                    'Please select image from gallery ,\nOr take one from camera.',
                              ));
                    else
                      showDialog<void>(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => ErrorDialog(
                                title: 'Invalid Location',
                                text:
                                    'Please mark a place location\non the map "Set Location" .',
                              ));
                  }
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
