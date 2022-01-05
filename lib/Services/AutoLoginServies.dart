import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:t3leleh_v1/Admin/AdminDashBoard.dart';
import 'package:t3leleh_v1/DashboardPage.dart';
import 'package:t3leleh_v1/OwnedPlacespage.dart';
import 'package:t3leleh_v1/SignInPage.dart';
import 'package:t3leleh_v1/WelcomePage.dart';
import 'package:t3leleh_v1/constans/constans.dart';

class AutoLoginServies extends StatefulWidget {
  const AutoLoginServies({Key? key}) : super(key: key);

  @override
  _AutoLoginServiesState createState() => _AutoLoginServiesState();
}

class _AutoLoginServiesState extends State<AutoLoginServies> {
  var _email ,_password,_userID,_userType;
  @override
  void initState() {
    super.initState();
    a();
    Timer(Duration(seconds: 3), (){
      print("hi");
      if(_email==null||_password==null||_userID==null) {

          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return   SafeArea(child: SignInPage() );}));

      }
    });
  }
 void a()async{
   SharedPreferences preferences = await SharedPreferences.getInstance();

   _email = preferences.getString('email')! ;
   _password = preferences.getString('password')!;
   _userID = preferences.getString('userID')!;
   _userType= preferences.getString('userType');
   print(_email+_password+_userID+"========================================================");
 }



  Widget build(BuildContext context) {
    return FutureBuilder(future:usersref.doc(_userID).get() ,builder:(context,snapshot){
      if(_email==null||_password==null||_userID==null||!snapshot.hasData){
        print("sign");
        return WelcomePage();
      }else{
        print("dash");
        return _userType == 'user'
            ? DashboardPage(
          currentuserid: _userID,
        )
            : _userType == 'owner'
            ? OwnedPlacesPage(
          currentuserid: _userID,
        )
            : AdminDashBoard();
      }
    });

  }

}

