import 'package:flutter/material.dart';
import 'package:t3leleh_v1/SignInPage.dart';
import 'package:t3leleh_v1/Tamplets/Templates.dart';
import 'package:t3leleh_v1/OwnedPlacespage.dart';
import 'package:t3leleh_v1/Users/Users.dart';
import 'DashboardPage.dart';
class ChangePasswordPage extends StatefulWidget {
  ChangePasswordPage();
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}
class _ChangePasswordPageState extends State<ChangePasswordPage> {
  String  newpass = '', confirmpass = '';
  @override
  // void _changePassword(String password) async{
  //   if (widget.t3user.type==usertype.owner){
  //   loggedinUse.updatePassword(password).then((_){
  //     print("Successfully changed password");
  //   }).catchError((error){
  //     print("Password can't be changed" + error.toString());
  //   });}
  //   else{
  //     loggedinUser.updatePassword(password).then((_){
  //       print("Successfully changed password");
  //     }).catchError((error){
  //       print("Password can't be changed" + error.toString());
  //     });
  //   }
  // }
  Widget build(BuildContext context) {
    return SignInPageTemplate(
      true,
      'Change Password',
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: BuildTextField(
                Icons.lock,
                'New Password',
                true,
                (val) {
                  newpass = val;
                },
                showText: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 21.0),
              child: BuildTextField(
                Icons.lock,
                'Confirm Password',
                true,
                (val) {
                  confirmpass = val;
                },
                showText: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 185.0),
              child: GestureDetector(
                onTap: () {
                  if (newpass ==confirmpass) {
                  //  _changePassword(newpass);//todo
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                          return SafeArea(child: SignInPage());
                        }));
                  }
                },
                child: LinearColorBottom('SAVE'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
