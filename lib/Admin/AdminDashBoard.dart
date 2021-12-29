import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:t3leleh_v1/Admin/AcceptedPlaces.dart';
import 'package:t3leleh_v1/Admin/AdminFeedBack.dart';
import 'package:t3leleh_v1/Admin/PendingPlaces.dart';
import 'package:t3leleh_v1/SignInPage.dart';

class AdminDashBoard extends StatefulWidget {
  const AdminDashBoard({Key? key}) : super(key: key);

  @override
  _AdminDashBoardState createState() => _AdminDashBoardState();
}

class _AdminDashBoardState extends State<AdminDashBoard> {
  int _selectedtap = 1;
  List<Widget> _dashboard = [
    AcceptedPlaces(),
    PendingPlaces(),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(15.0),
            child: IconButton(
              onPressed: () {
                final _auth = FirebaseAuth.instance;
                _auth.signOut();
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SafeArea(child: SignInPage());
                }));
              },
              icon: Icon(
                Icons.logout,
                size: 30,
              ),
            ),
          ),
          backgroundColor: Color(0xff08AFBF),
          toolbarHeight: 80,
          title: Text(
            'DashBoard',
            style: TextStyle(fontSize: 25),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SafeArea(child: AdminFeedBack());
                  }));
                },
                icon: Icon(
                  Icons.feedback,
                  size: 30,
                ),
              ),
            )
          ],
          automaticallyImplyLeading: false,
        ),
        body: _dashboard.elementAt(_selectedtap),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              _selectedtap = index;
            });
          },
          currentIndex: _selectedtap,
          fixedColor: Colors.white,
          backgroundColor: Color(0xff08AFBF),
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.check_circle),
                title: Text(
                  'accepted',
                  style: TextStyle(fontSize: 14),
                )),
            BottomNavigationBarItem(
                icon: Icon(Icons.pending),
                title: Text(
                  'pending',
                  style: TextStyle(fontSize: 14),
                )),
          ],
        ),
      ),
    );
  }
}
