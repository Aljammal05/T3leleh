import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:t3leleh_v1/constans/constans.dart';

class AddPlace_Services {
  static Future<bool> add_Place(
      String userID,
      RangeValues min_max,
      double lat,
      double lng,
      String name,
      String description,
      String city,
      String area,
      String phoneNo,
      String websiteURL,
      String placepicURL,
      String category,
      ) async {
    try {
      placesref.doc(name + '-' + area).set({
        'ownerID':userID,
        'name': name,
        'description': description,
        'category': category,
        'min': min_max.start.round().toString(),
        'max': min_max.end.round().toString(),
        'city': city,
        'area': area,
        'lat': lat,
        'lng': lng,
        'phoneNo': phoneNo,
        'websiteURL': websiteURL,
        'placepicURL': placepicURL,
      });
      usersref.doc(userID).update({
        'ownedplaces':FieldValue.arrayUnion([name+'-'+area])
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
