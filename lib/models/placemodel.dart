import 'package:cloud_firestore/cloud_firestore.dart';

class PlaceModel {
  String ID,
      ownerID,
      name,
      description,
      category,
      city,
      area,
      phoneNo,
      websiteURL,
      placepicURl,
      status;
  double lat, lng,cost_per_person;
  PlaceModel({
    this.ID = '',
    this.ownerID = '',
    this.name = '',
    this.description = '',
    this.category = '',
    this.cost_per_person=0,
    this.city = '',
    this.area = '',
    this.lat = 31.963158,
    this.lng = 35.930359,
    this.phoneNo = '',
    this.websiteURL = '',
    this.placepicURl = '',
    this.status='pending',
  });
  factory PlaceModel.fromdoc(DocumentSnapshot doc) {
    return PlaceModel(
      ID: doc.id,
      ownerID: doc['ownerID'],
      name: doc['name'],
      description: doc['description'],
      category: doc['category'],
      cost_per_person: doc['cost per person'],
      city: doc['city'],
      area: doc['area'],
      lat: doc['lat'],
      lng: doc['lng'],
      phoneNo: doc['phoneNo'],
      websiteURL: doc['websiteURL'],
      placepicURl: doc['placepicURL'],
      status: doc['status'],
    );
  }
}
