import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:t3leleh_v1/DashboardPage.dart';
import 'package:t3leleh_v1/Tamplets/Templates.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:t3leleh_v1/Users/Users.dart';
import 'lists/Lists.dart';

class FilterPage extends StatefulWidget {
  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  RangeValues totalbudget = RangeValues(0, 20);
  int numofperson = 1;
  String city = '', area = '';
  @override
  Widget build(BuildContext context) {
    return DashboardTemplate(
      Color(0xb8E1D0C1),
      Color(0xb83AAEC2),
      'image/petra.jpg',
      'Filter',
      Icons.dashboard,
      DashboardPage(),
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
                  CategoryWidget('image/gaming-category.png'),
                  CategoryWidget('image/tourism-category.png'),
                  CategoryWidget('image/relax-category.png'),
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
                                  numofperson >= 25 ? null : numofperson++;
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
                                  numofperson <= 1 ? null : numofperson--;
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
                        totalbudget.start.round().toString() +
                            ' - ' +
                            totalbudget.end.round().toString(),
                        style: TextStyle(color: Colors.white, fontSize: 33),
                      ),
                    ),
                  ],
                ),
              ),
              RangeSlider(
                  values: totalbudget,
                  min: 0,
                  max: 150,
                  divisions: 15,
                  activeColor: Color(0xff3AAEC2),
                  inactiveColor: Color(0xffffffff),
                  onChanged: (newval) {
                    setState(() {
                      totalbudget = newval;
                    });
                  }),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return SafeArea(child: DashboardPage());
                      }));
                    });
                  },
                  child: LinearColorBottom('SAVE'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  List<String> fcity (String s){
    switch(s){
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
