import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:t3leleh_v1/RecoveryCodePage.dart';
import 'package:t3leleh_v1/Tamplets/Templates.dart';
import 'SignInPage.dart';

class RecoveryPage extends StatefulWidget {
  @override
  _RecoveryPageState createState() => _RecoveryPageState();
}

class _RecoveryPageState extends State<RecoveryPage> {
  String recemail='';
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return SignInPageTemplate(
      true,
      'Recovery',
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Text(
                'Please enter your Email address to\n '
                'let us send you a recovery code.',
                style: TextStyle(fontSize: 18.0, color: Colors.grey.shade600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                'note : you will receive a code within\n '
                '1 minute',
                style: TextStyle(fontSize: 18.0, color: Colors.grey.shade600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: BuildTextField(Icons.email, 'Email', false,(val) {
                recemail =val;},),
            ),
            SizedBox(
              height: 140,
            ),
            GestureDetector(
              onTap: (){
                _auth.sendPasswordResetEmail(email: recemail);
                setState(() {
                  Navigator.push(context, MaterialPageRoute(builder: (context)
                  {return SafeArea(child:SignInPage() );
                  }));
                });
              },
              child: LinearColorBottom('SEND'),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)
                  {return SafeArea(
                      child: SignInPage(),
                    );
                  }));
                },
                child: FooterText('Already a member ? ', 'Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
