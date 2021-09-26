import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:t3leleh_v1/DashboardPage.dart';
import 'package:t3leleh_v1/OwnedPlacespage.dart';
import 'package:t3leleh_v1/RecoveryPage.dart';
import 'package:t3leleh_v1/RegisterPage.dart';
import 'package:t3leleh_v1/Tamplets/Templates.dart';
import 'package:t3leleh_v1/Users/Users.dart';
import 'package:t3leleh_v1/lists/Lists.dart';
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
                try {
                  await _auth.signInWithEmailAndPassword(
                      email: email, password: password);
                  User? logged = _auth.currentUser;
                  if (logged != null) {
                   /* if (logged.email.toString() == '3bood20003li@gmail.com')
                      setState(() {
                        userType = usertype.owner;
                      });
                    else
                      setState(() {
                        userType = usertype.user;
                      });*/
                    // for(int i=0;i<=userslist.length;i++){
                    //   if(logged.email.toString()==userslist[i].useremail){
                    //     setState(() {
                    //       userType=userslist[i].type;
                    //     });
                    //     Navigator.push(context,
                    //         MaterialPageRoute(builder: (context) {
                    //           return SafeArea(
                    //             child: userType == usertype.user
                    //                 ? DashboardPage()
                    //                 : OwnedPlacesPage(),
                    //           );
                    //         }));
                    //   }
                    //
                    // }
                    /*Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SafeArea(
                        child: userType == usertype.user
                            ? DashboardPage()
                            : OwnedPlacesPage(),
                      );
                    }));*/
                  }
                } catch (e) {
                  print(e);
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
