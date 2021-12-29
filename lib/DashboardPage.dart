import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:t3leleh_v1/FilterPage.dart';
import 'package:t3leleh_v1/Tamplets/Templates.dart';
import 'package:t3leleh_v1/constans/constans.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage(
      {this.currentuserid = '',
      this.city = '*',
      this.area = '',
      this.cost_per_person = 0,
      this.gaming = '',
      this.relax = '',
      this.tourism = ''});
  String currentuserid;
  String city, area, relax, gaming, tourism;
  double cost_per_person;
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<PlaceWidget> _dash1 = [];
  List<PlaceWidget> _dash2 = [];
  var _query = placesref.where('city',isEqualTo: '',).where('status',isEqualTo: 'accepted');
  var _stream = placesref.where( 'city',isEqualTo: '',).where('status',isEqualTo: 'accepted') .snapshots();
  initState() {
    super.initState();
    getdata();
  }
  getdata() async {
    String city = await usersref.doc(widget.currentuserid).get().then((value) {
      return value.data()!['city'].toString();
    });
    setState(() {
      if (widget.city == '*')
        _query = placesref.where('city', isEqualTo: city);
      else if (widget.city.isNotEmpty)
        _query = placesref.where('city', isEqualTo: widget.city);
      if (widget.city.isEmpty) _query = placesref;
      if (widget.area.isNotEmpty)
        _query = _query.where('area', isEqualTo: widget.area);
      if (widget.gaming.isNotEmpty ||
          widget.relax.isNotEmpty ||
          widget.tourism.isNotEmpty)
        _query = _query.where('category',
            whereIn: [widget.tourism, widget.relax, widget.gaming]);
      if (widget.cost_per_person != 0)
        _query = _query.where('cost per person',
            isLessThanOrEqualTo: widget.cost_per_person);
      _stream = _query.where('status',isEqualTo: 'accepted').snapshots();
    });
  }

  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _stream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.black,
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            );
          }
          _dash1 = [];
          _dash2 = [];
          snapshot.data!.docs.forEach((doc) {
            if (_dash1.length <= _dash2.length) if (_dash1.length % 2 == 0)
              _dash1.add(PlaceWidget(currentuserid: widget.currentuserid,currentplaceID: doc.id, height: 230));
            else
              _dash1.add(PlaceWidget(currentuserid: widget.currentuserid,currentplaceID: doc.id));
            else if (_dash2.length % 2 == 1)
              _dash2.add(PlaceWidget(currentuserid: widget.currentuserid,currentplaceID: doc.id, height: 230));
            else
              _dash2.add(PlaceWidget(currentuserid: widget.currentuserid,currentplaceID: doc.id));
          });
          _dash1.shuffle();
          _dash2.shuffle();
          return DashboardTemplate(
            widget.currentuserid,
            Color(0xb8E1D0C1),
            Color(0xb83AAEC2),
            'image/waterfall-wallpaper.jpg',
            'Dashboard',
            Icons.explore,
            FilterPage(
              currentuserid: widget.currentuserid,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: _dash1,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: _dash2,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
