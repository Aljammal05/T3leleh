import 'package:flutter/material.dart';
import 'package:t3leleh_v1/AddPlace.dart';
import 'package:t3leleh_v1/OwnedPlacespage.dart';
import 'package:t3leleh_v1/Place.dart';
import 'package:t3leleh_v1/ProfilePage.dart';
import 'package:t3leleh_v1/Services/StorageService.dart';
import 'package:t3leleh_v1/Tamplets/Templates.dart';
import 'package:t3leleh_v1/Users/Users.dart';
import 'package:t3leleh_v1/constans/constans.dart';
import 'package:t3leleh_v1/lists/Lists.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:t3leleh_v1/models/placemodel.dart';

class EditPlace extends StatefulWidget {
  EditPlace(this.currentplaceID,this.AVGcost);
  String currentplaceID='';
  RangeValues AVGcost=RangeValues(0,20);
  @override
  _EditPlaceState createState() => _EditPlaceState();
}

class _EditPlaceState extends State<EditPlace> {
  @override
String? _name='',_description='',_phoneNo='',_websiteURL='';


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
        }
PlaceModel placeModel=PlaceModel.fromdoc(snapshot.data);
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
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          placeID--;
                          // widget.t3user.profownedlist.removeLast();//todo
                          // widget.t3user.ownedlist1.removeLast();
                          // widget.t3user.statisticlist.removeLast();
                          placeslist.removeLast();
                          dashlist1.removeLast();
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                                return SafeArea(child: OwnedPlacesPage());
                              }));
                        });
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
                          final PickedFile? image = await ImagePicker()
                              .getImage(source: ImageSource.camera);
                          File img = File(image!.path);
                          String url=await StorageService.uploadPlacePicture(placeModel.placepicURl, img);
                          setState(() {
                            placesref.doc(widget.currentplaceID).update({
                            'placepicURL':url,
                            });
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
                        String url=await StorageService.uploadPlacePicture(placeModel.placepicURl, img);
                        setState(() {
                          placesref.doc(widget.currentplaceID).update({
                            'placepicURL':url,
                          });
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
                    keyboardType: TextInputType.multiline,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                    decoration: InputDecoration(
                      fillColor: Color(0x33ffffff),
                      filled: true,
                      hintText: placeModel.name,
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
                    onChanged: (val) {
                      setState(() {
                        _name=val;
                      });
                    },
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
                          borderSide:
                          BorderSide(color: Color(0x22ffffff), width: 3.0)),
                      hintText: placeModel.description,
                      hintStyle: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    onChanged: (val) {
                      setState(() {
                       _description=val;
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
                        widget.AVGcost.start.round().toString() +
                            ' - ' +
                            widget.AVGcost.end.round().toString(),
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
                    values:widget.AVGcost,
                    min: 0,
                    max: 150,
                    divisions: 15,
                    activeColor: Color(0xff3AAEC2),
                    inactiveColor: Color(0xffffffff),
                    onChanged: (newval) {
                      setState(() {
                        widget.AVGcost=newval;
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
                          borderSide:
                          BorderSide(color: Color(0x22ffffff), width: 3.0)),
                    ),
                    onChanged: (val) {
                      setState(() {
                       _phoneNo=val;
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
                          borderSide:
                          BorderSide(color: Color(0x22ffffff), width: 3.0)),
                    ),
                    onChanged: (val) {
                      setState(() {
                          _websiteURL=val;
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
                    onTap: () {
                      setState(() {
                        placesref.doc(widget.currentplaceID).update({
                          'name':_name==''?placeModel.name:_name,
                          'description':_description==''?placeModel.description:_description,
                          'min':widget.AVGcost.start.round().toString(),
                          'max':widget.AVGcost.end.round().toString(),
                          'phoneNo':_phoneNo==''?placeModel.phoneNo:_phoneNo,
                          'websiteURL':_websiteURL==''?placeModel.websiteURL:_websiteURL,
                        });
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return SafeArea(child:ProfilePage(currentuserid: '8bWwS1DBijgvirpsgJUw8EBNH9m2',));
                                  // OwnedPlacesPage());
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
    );
  }
}
