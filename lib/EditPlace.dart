import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:t3leleh_v1/Dialogs/Dialogs.dart';
import 'package:t3leleh_v1/GeneralSettings.dart';
import 'package:t3leleh_v1/OwnedPlacespage.dart';
import 'package:t3leleh_v1/Services/StorageService.dart';
import 'package:t3leleh_v1/Tamplets/Templates.dart';
import 'package:t3leleh_v1/constans/constans.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:t3leleh_v1/models/placemodel.dart';

class EditPlace extends StatefulWidget {
  EditPlace(this.currentplaceID, this.cost_per_person,this.currentuserid);
  String currentplaceID ,currentuserid;
  double cost_per_person ;
  _EditPlaceState createState() => _EditPlaceState();
}

class _EditPlaceState extends State<EditPlace> {
  String? _description = '', _phoneNo = '', _websiteURL = '';
  String _placepicurl = '';
  File? _img;
  initState() {
    super.initState();
    getplace();
  }

  getplace() async {
    var place = await placesref.doc(widget.currentplaceID).get();
    _placepicurl = place.data()!['placepicURL'];
  }

  displayimage() {
    if (_img == null) {
      return NetworkImage(_placepicurl);
    } else {
      return FileImage(_img!);
    }
  }

  Widget build(BuildContext context) {
    return FutureBuilder(
        future: placesref.doc(widget.currentplaceID).get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.black,
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            );
          }
          PlaceModel placeModel = PlaceModel.fromdoc(snapshot.data);
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
                      GestureDetector(
                        onTap: () {
                          try {
                            placesref.doc(widget.currentplaceID).delete();
                            usersref.doc(widget.currentuserid).update({
                              'ownedplaces':FieldValue.arrayRemove([widget.currentplaceID])
                            });
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                                  return SafeArea(
                                      child: OwnedPlacesPage(
                                        currentuserid: widget.currentuserid,
                                      ));
                                }));
                          }catch(e){
                            print(e);
                          }
                        },
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 27,
                        ),
                      ),
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
                            final PickedFile? pickedimage = await ImagePicker()
                                .getImage(source: ImageSource.camera);

                            setState(() {
                              _img = File(pickedimage!.path);
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
                          final PickedFile? pickedimage = await ImagePicker()
                              .getImage(source: ImageSource.gallery);
                          setState(() {
                            _img = File(pickedimage!.path);
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
                      ' Description',
                      style: TextStyle(fontSize: 22, color: Colors.white),
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
                              Radius.circular(30),
                            ),
                            borderSide: BorderSide(
                              color: Color(0x66ffffff),
                            )),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide(
                                color: Color(0x22ffffff), width: 3.0)),
                        hintText: placeModel.description,
                        hintStyle: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      onChanged: (val) {
                        setState(() {
                          _description = val;
                        });
                      },
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
                          currencytoggle ==0?widget.cost_per_person.round().toString() :(widget.cost_per_person.round()*1.4).toStringAsFixed(1),
                          style: TextStyle(fontSize: 35, color: Colors.white),
                        ),
                        Text(
                          currencytoggle ==0?' JD':' USD',
                          style: TextStyle(fontSize: 25, color: Colors.white,fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Slider(
                      value: widget.cost_per_person,
                      min: 0,
                      max: 25,
                      divisions: 25,
                      activeColor: Color(0xff3AAEC2),
                      inactiveColor: Color(0xffffffff),
                      onChanged: (newval) {
                        setState(() {
                          widget.cost_per_person = newval;
                        });
                      }),
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
                      keyboardType: TextInputType.multiline,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                      decoration: InputDecoration(
                        fillColor: Color(0x33ffffff),
                        filled: true,
                        hintText: placeModel.phoneNo,
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
                            borderSide: BorderSide(
                                color: Color(0x22ffffff), width: 3.0)),
                      ),
                      onChanged: (val) {
                        setState(() {
                          _phoneNo = val;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                      decoration: InputDecoration(
                        fillColor: Color(0x33ffffff),
                        filled: true,
                        hintText: placeModel.websiteURL,
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
                            borderSide: BorderSide(
                                color: Color(0x22ffffff), width: 3.0)),
                      ),
                      onChanged: (val) {
                        setState(() {
                          _websiteURL = val;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: GestureDetector(
                      onTap: () async {
                        if (widget.cost_per_person ==
                                placeModel.cost_per_person &&
                            _phoneNo == '' &&
                            _websiteURL == '' &&
                            _description == '' &&
                            _img == null)
                          showDialog<void>(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => ErrorDialog(
                                    title: 'Nothing\'s Changed',
                                    text:
                                        'You have not make any changes,\nno effect will applied.',
                                  ));
                        else {
                          if (_img != null) {
                            showDialog<void>(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => WaitingDialog());
                            _placepicurl =
                                await StorageService.uploadPlacePicture(
                                    _placepicurl, _img!);
                            placesref.doc(widget.currentplaceID).update({
                              'placepicURL': _placepicurl,
                            });
                            Navigator.pop(context);
                          }
                          setState(() {
                            placesref.doc(widget.currentplaceID).update({
                              'description': _description == ''
                                  ? placeModel.description
                                  : _description,
                              'cost per person': widget.cost_per_person ==
                                      placeModel.cost_per_person
                                  ? placeModel.cost_per_person.round() / 1.0
                                  : widget.cost_per_person,
                              'phoneNo': _phoneNo == ''
                                  ? placeModel.phoneNo
                                  : _phoneNo,
                              'websiteURL': _websiteURL == ''
                                  ? placeModel.websiteURL
                                  : _websiteURL,
                            });
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return SafeArea(
                                  child: OwnedPlacesPage(currentuserid: widget.currentuserid,));
                              // OwnedPlacesPage());
                            }));
                          });
                        }
                      },
                      child: LinearColorBottom('SAVE'),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
