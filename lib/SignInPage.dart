import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:t3leleh_v1/DashboardPage.dart';
import 'package:t3leleh_v1/OwnedPlacespage.dart';
import 'package:t3leleh_v1/RecoveryPage.dart';
import 'package:t3leleh_v1/RegisterPage.dart';
import 'package:t3leleh_v1/Services/auth_service.dart';
import 'package:t3leleh_v1/Tamplets/Templates.dart';
import 'package:t3leleh_v1/constans/constans.dart';
class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}
class _SignInPageState extends State<SignInPage> {
  final _auth = FirebaseAuth.instance;
  String email = '', password = '';
  @override
  Widget build(BuildContext context) {
    return SignInPageTemplate(
      false,
      'Login',
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding( padding: const EdgeInsets.only(top: 40),
                child: BuildTextField(Icons.email, 'Email', false, (val) {
                  email = val; })
            ),
            Padding( padding: const EdgeInsets.only(top: 16),
              child: BuildTextField(Icons.lock,'Password',true,(val) {
                  password = val;
                },
                showText: false,
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SafeArea(child: RecoveryPage());
                      },
                    ),
                  );
                });
              },
              child: Text('Forgot password ?', style:
              TextStyle(color: Color(0xff08AFBF),),),
            ),
            SizedBox(height: 140,),
            GestureDetector(
              onTap: () async {
                bool isvalid =await auth_service.signIn(email, password);
                String currentuserid;
                currentuserid=await _auth.currentUser!.uid;
              var db=  await usersref.doc(currentuserid).get();
                 if (isvalid) {
                     Navigator.push(context,
                         MaterialPageRoute(builder: (context) {
                           return SafeArea(
                             child: db['userType']=='user'
                                 ? DashboardPage()
                                 :db['userType']=='owner'? OwnedPlacesPage():Container(),
                           );
                         }));
                 } else {
                   print('something wrong');
                 }
              },
              child: LinearColorBottom(
                'LOGIN',
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: () { Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                      return SafeArea(child: RegisterPage());
                    }));
                  },
                  child: FooterText( 'Don\'t have an account ? ','Register',),
                )),
          ],
        ),
      ),
    );
  }
}
