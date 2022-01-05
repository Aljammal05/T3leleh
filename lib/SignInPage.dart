import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:t3leleh_v1/Admin/AdminDashBoard.dart';
import 'package:t3leleh_v1/DashboardPage.dart';
import 'package:t3leleh_v1/OwnedPlacespage.dart';
import 'package:t3leleh_v1/RecoveryPage.dart';
import 'package:t3leleh_v1/RegisterPage.dart';
import 'package:t3leleh_v1/Services/auth_service.dart';
import 'package:t3leleh_v1/Tamplets/Templates.dart';
import 'package:t3leleh_v1/constans/constans.dart';
import 'Dialogs/Dialogs.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _auth = FirebaseAuth.instance;
  String _email = '', _password = '';
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
            Padding(
                padding: const EdgeInsets.only(top: 40),
                child: BuildTextField(Icons.email, 'Email', false, (val) {
                  _email = val;
                })),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: BuildTextField(
                Icons.lock,
                'Password',
                true,
                (val) {
                  _password = val;
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
              child: Text(
                'Forgot password ?',
                style: TextStyle(
                  color: Color(0xff08AFBF),
                ),
              ),
            ),
            SizedBox(
              height: 140,
            ),
            GestureDetector(
              onTap: () async {
                if (_email.isEmpty || _password.isEmpty) {
                  showDialog<void>(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => ErrorDialog(
                            title: 'Sorry',
                            text:
                                'All of fields are required,\nplease fill all of them.',
                          ));
                } else {
                  showDialog<void>(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => WaitingDialog());
                  bool isvalid = await auth_service.signIn(_email, _password);
                  String currentuserid;

                  if (isvalid) {
                    SharedPreferences pref = await SharedPreferences.getInstance();
                    pref.setString('email', _email);
                    pref.setString('password', _password);
                     currentuserid = await _auth.currentUser!.uid;
                    pref.setString('userID', currentuserid);
                  var db = await usersref.doc(currentuserid).get();
                    pref.setString('userType',db['userType']);
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SafeArea(
                        child: db['userType'] == 'user'
                            ? DashboardPage(
                                currentuserid: currentuserid,
                              )
                             : db['userType'] == 'owner'
                                ? OwnedPlacesPage(
                                    currentuserid: currentuserid,
                                  )
                                : AdminDashBoard(),
                      );
                    }));
                  } else {
                    Navigator.pop(context);
                    showDialog<void>(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => ErrorDialog(
                              title: 'Wrong Input',
                              text:
                                  'This email or password is wrong.\nPlease try again.',
                            ));
                  }
                }
              },
              child: LinearColorBottom(
                'LOGIN',
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SafeArea(child: RegisterPage());
                    }));
                  },
                  child: FooterText(
                    'Don\'t have an account ? ',
                    'Register',
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
