import 'package:cloud_firestore/cloud_firestore.dart';

class PlaceModel {
  String ID,
      ownerID,
      budgetmin,
      budgetmax,
      name,
      description,
      category,
      city,
      area,
      phoneNo,
      websiteURL,
      placepicURl;
  double lat, lng;
  PlaceModel({
    this.ID = '',
    this.ownerID = '',
    this.name = '',
    this.description = '',
    this.category = '',
    this.budgetmin = '',
    this.budgetmax = '',
    this.city = '',
    this.area = '',
    this.lat = 31.963158,
    this.lng = 35.930359,
    this.phoneNo = '',
    this.websiteURL = '',
    this.placepicURl = '',
  });
  factory PlaceModel.fromdoc(DocumentSnapshot doc) {
    return PlaceModel(
      ID: doc.id,
      ownerID: doc['ownerID'],
      name: doc['name'],
      description: doc['description'],
      category: doc['category'],
      budgetmin: doc['min'],
      budgetmax: doc['max'],
      city: doc['city'],
      area: doc['area'],
      lat: doc['lat'],
      lng: doc['lng'],
      phoneNo: doc['phoneNo'],
      websiteURL: doc['websiteURL'],
      placepicURl: doc['placepicURL'],
    );
  }
}
