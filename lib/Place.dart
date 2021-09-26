import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Place {
  RangeValues AVGcost = RangeValues(0, 20);
  int placeid = 0;
  bool isfav = false;
  int checkinTM = 0, checkinLM = 0, clickonTM = 0, clickonLM = 0;
  ImageProvider image = AssetImage('image/default.png');
  IconData ratingicon = FontAwesomeIcons.solidMeh;
  LatLng location = LatLng(31.963158, 35.930359);
  String city, area, name, description, phoneNO, URL, category;
  Place(
      {this.name = '',
      this.description = '',
      this.category = '',
      this.city = '',
      this.area = '........',
      this.phoneNO = '',
      this.URL = ''});
}
