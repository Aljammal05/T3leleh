import 'package:flutter/material.dart';
import 'package:t3leleh_v1/SignInPage.dart';
import 'package:t3leleh_v1/Tamplets/Templates.dart';

class PasswordRecoveryPage extends StatefulWidget {
  @override
  _PasswordRecoveryPageState createState() => _PasswordRecoveryPageState();
}

class _PasswordRecoveryPageState extends State<PasswordRecoveryPage> {
  String newpassword = '', confirmpassword = '';
  @override
  Widget build(BuildContext context) {
    return SignInPageTemplate(
      true,
      'Recovery',
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: BuildTextField(
                Icons.lock,
                'New Password',
                true,
                (val) {
                  newpassword = val;
                },
                showText: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child:
                  BuildTextField(Icons.lock, 'Confirm Password', true, (val) {
                confirmpassword = val;
              }, showText: false),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 170.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SafeArea(child: SignInPage());
                    }));
                  });
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
