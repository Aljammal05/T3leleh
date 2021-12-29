import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:t3leleh_v1/Admin/AdminShowPlace.dart';
import 'package:t3leleh_v1/constans/constans.dart';
import 'package:t3leleh_v1/models/placemodel.dart';
class AdminPlaceWidget extends StatelessWidget {
  AdminPlaceWidget({this.currentplaceid = '', required this.child});
  String currentplaceid;
  Widget child;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: placesref.doc(currentplaceid).get(),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
          );
        }
        PlaceModel placeModel = PlaceModel.fromdoc(snapshot.data);
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SafeArea(
                    child: AdminShowPlace(
                        placeModel: placeModel,
                        currentplaceID:  currentplaceid));
              }));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 170,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(placeModel.placepicURl),
                        fit: BoxFit.cover,
                        colorFilter: new ColorFilter.mode(
                            Colors.white.withOpacity(0.85), BlendMode.dstATop),
                      ),
                      color: Color(0x99ffffff),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              placeModel.name,
                              style:
                              TextStyle(color: Colors.white, fontSize: 23),
                            ),
                            Text(
                              placeModel.city + ',' + placeModel.area,
                              style:
                              TextStyle(color: Colors.white, fontSize: 18),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: child,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class AcceptDeclinePlace extends StatelessWidget {
  AcceptDeclinePlace({required this.currentplaceid});
  String currentplaceid;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: TextButton(
              child: Text(
                'Accept',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              onPressed: () {
                placesref.doc(currentplaceid).update({'status': 'accepted'});
              },
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: TextButton(
              child: Text(
                'Decline',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              onPressed:  () async {
                usersref
                    .doc(
                    await placesref.doc(currentplaceid).get().then((value) {
                      return value.data()!['ownerID'];
                    }))
                    .update({
                  'ownedplaces': FieldValue.arrayRemove([currentplaceid])
                });
                placesref.doc(currentplaceid).delete();
              },
            ),
          ),
        ),
      ],
    );
  }
}

class DeletePlace extends StatelessWidget {
  DeletePlace({required this.currentplaceid});
  String currentplaceid;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: TextButton(
              child: Text(
                'Delete',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              onPressed: () async {
                usersref
                    .doc(
                    await placesref.doc(currentplaceid).get().then((value) {
                      return value.data()!['ownerID'];
                    }))
                    .update({
                  'ownedplaces': FieldValue.arrayRemove([currentplaceid])
                });
                placesref.doc(currentplaceid).delete();
              },
            ),
          ),
        ),
      ],
    );
  }
}
