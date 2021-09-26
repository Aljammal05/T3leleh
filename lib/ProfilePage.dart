import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:t3leleh_v1/AddPlace.dart';
import 'package:t3leleh_v1/DashboardPage.dart';
import 'package:t3leleh_v1/EditEmailPage.dart';
import 'package:t3leleh_v1/EditPlace.dart';
import 'package:t3leleh_v1/Place.dart';
import 'package:t3leleh_v1/PlaceMainPage.dart';
import 'package:t3leleh_v1/Services/StorageService.dart';
import 'package:t3leleh_v1/Tamplets/Templates.dart';
import 'package:t3leleh_v1/Users/Users.dart';
import 'package:t3leleh_v1/lists/Lists.dart';
import 'package:t3leleh_v1/models/placemodel.dart';
import 'package:t3leleh_v1/models/usermodel.dart';
import 'dart:io';
import 'constans/constans.dart';

class ProfilePage extends StatefulWidget {
  String currentuserid;
  ProfilePage({this.currentuserid = ''});
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: usersref.doc(widget.currentuserid).get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.black,
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            );
          }
          UserModel userModel = UserModel.fromdoc(snapshot.data);
          ownedplacesw=[];
          for(int i=0;i<userModel.ownedplaces.length;i++){
            ownedplacesw.add(RecentWidget(currentplaceID:userModel.ownedplaces[i]));
          }
          return ImageContainerStackTemplate(
              userModel.ProfilePicURL.isNotEmpty
                  ? NetworkImage(userModel.ProfilePicURL)
                  : AssetImage('image/profile-default-pic.jpg')
                      as ImageProvider,
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
                              String url=await StorageService.uploadProfilePicture(userModel.ProfilePicURL, img);
                              setState(() {
                                usersref.doc(widget.currentuserid).update({
                                  'ProfilePicURL':url
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
                        Column(
                          children: [
                            Text(
                              userModel.name,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 22),
                            ),
                            Text(userModel.city,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16))
                          ],
                        ),
                        GestureDetector(
                          onTap: () async {
                            final PickedFile? image = await ImagePicker()
                                .getImage(source: ImageSource.gallery);
                            File img = File(image!.path);
                            String url=await StorageService.uploadProfilePicture(userModel.ProfilePicURL, img);
                            setState(() {
                              usersref.doc(widget.currentuserid).update({
                                'ProfilePicURL':url
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
                padding: const EdgeInsets.only(top: 20.0, right: 10, left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      ' Email Address',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    Container(
                      height: 15,
                      child: Divider(
                        color: Colors.white,
                        thickness: 1,
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 14.0, horizontal: 12),
                          child: Text(
                            ' ' + userModel.email,
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return SafeArea(
                                  child: EditEmailPage(),
                                );
                              }));
                            });
                          },
                          child: Icon(
                            Icons.edit,
                            size: 22,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      ' Phone NO.',
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 14.0, horizontal: 12),
                      child: Text(
                        ' ' + userModel.phoneNO,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    userType == usertype.user
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ' Recent',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                              Container(
                                height: 15,
                                child: Divider(
                                  color: Colors.white,
                                  thickness: 1,
                                ),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return SafeArea(
                                              child: DashboardPage(),
                                            );
                                          }));
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 125,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              color: Color(0x66ffffff),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          child: Icon(
                                            Icons.add,
                                            size: 40,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: profreclist,
                                    )
                                  ],
                                ),
                              ),
                              Text(
                                ' Favorite',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                              Container(
                                height: 15,
                                child: Divider(
                                  color: Colors.white,
                                  thickness: 1,
                                ),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return SafeArea(
                                              child: DashboardPage(),
                                            );
                                          }));
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 125,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              color: Color(0x66ffffff),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          child: Icon(
                                            Icons.add,
                                            size: 40,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: proffavlist,
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        : Container(),
                    userType == usertype.owner
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ' Owned Places',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                              Container(
                                height: 15,
                                child: Divider(
                                  color: Colors.white,
                                  thickness: 1,
                                ),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return SafeArea(
                                              child: AddPlace(
                                                  LatLng(31.963158, 35.930359)),
                                            );
                                          }));
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 125,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              color: Color(0x66ffffff),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          child: Icon(
                                            Icons.add,
                                            size: 40,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Row(
                                        //todo

                                         children:ownedplacesw.reversed.toList(),
                                        )
                                  ],
                                ),
                              )
                            ],
                          )
                        : Container(),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 30, right: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Delete Account',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          Icon(Icons.delete, size: 25, color: Colors.white)
                        ],
                      ),
                    )
                  ],
                ),
              ));
        },
      ),
    );
  }
}
List <RecentWidget> ownedplacesw=[];
class RecentWidget extends StatefulWidget {
  RecentWidget({this.currentplaceID=''});
  String currentplaceID;

  @override
  _RecentWidgetState createState() => _RecentWidgetState();
}

class _RecentWidgetState extends State<RecentWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:placesref.doc(widget.currentplaceID).get(),
      builder: (BuildContext context,AsyncSnapshot snapshot){
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.black,
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
          );
        }
        PlaceModel placeModel=PlaceModel.fromdoc(snapshot.data);
      return GestureDetector(
        onTap: () {
          setState(() {
            RangeValues AVGcost=RangeValues(double.parse(placeModel.budgetmin), double.parse(placeModel.budgetmax));
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return SafeArea(
                child: EditPlace( widget.currentplaceID,AVGcost),
                //PlaceMainPage(currentplaceID: widget.currentplaceID,),
                // child: userType == usertype.user//todo
                //     ? PlaceMainPage(widget.place)
                //     : EditPlace(widget.place),
              );
            }));
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 125,
            width: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                image: DecorationImage(
                    image: NetworkImage(placeModel.placepicURl),
                    colorFilter: new ColorFilter.mode(
                        Colors.white.withOpacity(0.80), BlendMode.dstATop),
                    fit: BoxFit.cover)),
          ),
        ),
      );

      }
    );
  }
}
