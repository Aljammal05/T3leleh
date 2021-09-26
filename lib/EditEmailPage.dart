import 'package:flutter/material.dart';
import 'package:t3leleh_v1/SignInPage.dart';
import 'package:t3leleh_v1/Tamplets/Templates.dart';
import 'package:t3leleh_v1/Users/Users.dart';

class EditEmailPage extends StatefulWidget {
  @override
  _EditEmailPageState createState() => _EditEmailPageState();
}

class _EditEmailPageState extends State<EditEmailPage> {
  @override
  Widget build(BuildContext context) {
    return SignInPageTemplate(
      true,
      'Change Email',
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 30.0, left: 30),
                child: Text(
                  'New Email',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: BuildTextField(
                Icons.email,
               // widget.t3user.useremail,
                '',//todo
                false,
                (val) {
                 // widget.t3user.useremail = val;//todo

                },
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 30),
                child: Text(
                  'Enter your password',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: BuildTextField(
                Icons.lock,
                'Password',
                true,
                (val) {
                },
                showText: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 160.0),
              child: GestureDetector(
                onTap: (){
                  setState(() {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return SafeArea(child:SignInPage(),);
                    }));
                  });
                },
                child: LinearColorBottom('CHANGE'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
