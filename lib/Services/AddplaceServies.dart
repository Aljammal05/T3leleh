import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:t3leleh_v1/constans/constans.dart';

class AddPlace_Services {
  static Future<bool> add_Place(
      String userID,
      double cost_per_person,
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
        'cost per person':cost_per_person,
        'city': city,
        'area': area,
        'lat': lat,
        'lng': lng,
        'phoneNo': phoneNo,
        'websiteURL': websiteURL,
        'placepicURL': placepicURL,
        'status' : 'pending'
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
