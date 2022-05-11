import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:t3leleh_v1/constans/constans.dart';

class StatisticPage extends StatefulWidget {
  StatisticPage({required this.currentuserid});
  String currentuserid;

  @override
  _StatisticPageState createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  List<Color> gradientColors = [
    const Color(0xff0C89C3),
    const Color(0xff02d39a),
  ];
  List <PlaceStatisticWidget> statistic=[];
  bool showAvg = false;

  @override
  void initState() {
    super.initState();
    fillOwnedPlaces();
  }

  void fillOwnedPlaces() async {
    List ownedid = await usersref.doc(widget.currentuserid).get().then((value) {
      return value.data()!['ownedplaces'];
    });
    statistic=[];
    ownedid.reversed.forEach((place) async{
      String placename=await placesref.doc(place).get().then((value) => value.data()!['name']);
      setState(() {
          statistic.add(PlaceStatisticWidget(name: placename,));
      });
    });
  }
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[Color(0xff02ECB9), Color(0xff0C89C3)],
            // red to yellow
            tileMode: TileMode.repeated,
          )),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Align(
                        child: GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              Navigator.pop(context);
                            });
                          },
                        ),
                        alignment: Alignment.topLeft,
                      ),
                    ),
                    Expanded(
                      flex: 15,
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.only(right: 60.0),
                        child: Text(
                          'Statistic',
                          style: TextStyle(color: Colors.white, fontSize: 28),
                        ),
                      )),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  ' Chart-Line ',
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
                Container(
                  height: 15,
                  child: Divider(
                    color: Colors.white,
                    thickness: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 8),
                  child: Text(
                    'Show the (check in) Statistic in the last 5 months',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: <Widget>[
                      AspectRatio(
                        aspectRatio: 1.70,
                        child: Container(
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(18),
                              ),
                              color: Color(0xff232d37)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 18.0, left: 12.0, top: 24, bottom: 12),
                            child: LineChart(
                              mainData(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 23.481,
                ),
                Text(
                  ' Places Statistic ',
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
                Container(
                  height: 15,
                  child: Divider(
                    color: Colors.white,
                    thickness: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 8),
                  child: Text(
                    'Show the check in and click on of your owned places in the last month',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children:statistic
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles:(context, value) => TextStyle(color: Color(0xffffffff),fontWeight: FontWeight.bold,fontSize: 15,),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return 'APR';
              case 3:
                return 'MAY';
              case 5:
                return 'JUN';
              case 7:
                return 'JUL';
              case 9:
                return 'AUG';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles:(context, value)=>
            TextStyle(
              color: Color(0xffffffff),
              fontWeight: FontWeight.bold,
              fontSize: 14,),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '100';
              case 3:
                return '300';
              case 5:
                return '500';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 10,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 0),
            FlSpot(1, 0),
            FlSpot(3, 2.5),
            FlSpot(5, 4),
            FlSpot(7, 2.5),
            FlSpot(9, 3.5),
            FlSpot(10, 3.0),
          ],
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }
}

class PlaceStatisticWidget extends StatelessWidget {
  PlaceStatisticWidget({required this.name});
  String name;
final random =Random();
late int s,f;
  @override
  Widget build(BuildContext context) {
    f=random.nextInt(10);
    s=random.nextInt(35)+f;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 185,
        width: 150,
        decoration: BoxDecoration(
            color: Color(0x66ffffff),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                name,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                'Click On',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$f',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                  f >= 5
                      ? Icon(
                          Icons.arrow_drop_up,
                          color: Colors.green,
                          size: 30,
                        )
                      :
                  Icon(
                          Icons.arrow_drop_down,
                          color: Colors.red,
                          size: 30,
                        )
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                'Check In',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$s',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                   s>= 18
                      ? Icon(
                          Icons.arrow_drop_up,
                          color: Colors.green,
                          size: 30,
                        )
                      :
                  Icon(
                          Icons.arrow_drop_down,
                          color: Colors.red,
                          size: 30,
                        )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
