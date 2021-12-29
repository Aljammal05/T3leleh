import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:t3leleh_v1/DashboardPage.dart';
import 'package:t3leleh_v1/Tamplets/Templates.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'lists/Lists.dart';

class FilterPage extends StatefulWidget {
  FilterPage({this.currentuserid = ''});
  String currentuserid;
  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  double cost_per_person = 0;
  int numofperson = 1;
  String city = '', area = '', relax = '', gaming = '', tourism = '';
  @override
  Widget build(BuildContext context) {
    return DashboardTemplate(
      widget.currentuserid,
      Color(0xb8E1D0C1),
      Color(0xb83AAEC2),
      'image/petra.jpg',
      'Filter',
      Icons.dashboard,
      DashboardPage(
        currentuserid: widget.currentuserid,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Dropdownbox(
                  ['Amman', 'Zarqa', 'Aqaba', 'Irbid'],
                  'Select your City',
                  (val) {
                    setState(() {
                      city = val;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Dropdownbox(
                  fcity(city),
                  'Select your Area',
                  (val) {
                    area = val;
                  },
                ),
              ),
              Container(
                height: 30,
                child: Divider(
                  color: Colors.white,
                  thickness: 1,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CategoryWidget('image/gaming-category.png', () {
                    gaming = gaming.isEmpty ? 'gaming' : '';
                  }),
                  CategoryWidget('image/tourism-category.png', () {
                    tourism = tourism.isEmpty ? 'tourism' : '';
                  }),
                  CategoryWidget('image/relax-category.png', () {
                    relax = relax.isEmpty ? 'relax' : '';
                  }),
                ],
              ),
              Container(
                height: 30,
                child: Divider(
                  color: Colors.white,
                  thickness: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  children: [
                    Text(
                      'Num of persons : ',
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 9.0),
                      child: Text(
                        '$numofperson',
                        style: TextStyle(color: Colors.white, fontSize: 37),
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          height: 30,
                          child: FloatingActionButton(
                              heroTag: 'h1',
                              child: Icon(Icons.add),
                              backgroundColor: Color(0xb83AAEC2),
                              onPressed: () {
                                setState(() {
                                  numofperson = numofperson >= 25
                                      ? numofperson
                                      : ++numofperson;
                                });
                              }),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 30,
                          child: FloatingActionButton(
                              heroTag: 'h2',
                              child: Icon(
                                FontAwesomeIcons.minus,
                                size: 14,
                              ),
                              backgroundColor: Color(0xb83AAEC2),
                              onPressed: () {
                                setState(() {
                                  numofperson = numofperson <= 1
                                      ? numofperson
                                      : --numofperson;
                                });
                              }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8),
                child: Row(
                  children: [
                    Text(
                      'Total budget : ',
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 9.0),
                      child: Text(
                        cost_per_person.round().toString() + ' JD ',
                        style: TextStyle(color: Colors.white, fontSize: 33),
                      ),
                    ),
                  ],
                ),
              ),
              Slider(
                  value: cost_per_person,
                  min: 0,
                  max: 150,
                  divisions: 30,
                  activeColor: Color(0xff3AAEC2),
                  inactiveColor: Color(0xffffffff),
                  onChanged: (newval) {
                    setState(() {
                      cost_per_person = newval;
                    });
                  }),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return SafeArea(
                            child: DashboardPage(
                          currentuserid: widget.currentuserid,
                          area: area,
                          city: city,
                          gaming: gaming,
                          relax: relax,
                          tourism: tourism,
                          cost_per_person: cost_per_person != 0
                              ? cost_per_person / numofperson
                              : 0,
                        ));
                      }));
                    });
                  },
                  child: LinearColorBottom('SEARCH'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<String> fcity(String s) {
    switch (s) {
      case 'Amman':
        return Amman;
      case 'Zarqa':
        return Zarqa;
      case 'Irbid':
        return Irbid;
      case 'Aqaba':
        return Aqaba;
      default:
        return ['please select city'];
    }
  }
}
