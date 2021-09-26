import 'package:flutter/material.dart';
import 'package:t3leleh_v1/PasswordRecoveryPage.dart';
import 'package:t3leleh_v1/RecoveryPage.dart';
import 'package:t3leleh_v1/Tamplets/Templates.dart';

class RecoveryCodePage extends StatefulWidget {
  @override
  _RecoveryCodePageState createState() => _RecoveryCodePageState();
}

class _RecoveryCodePageState extends State<RecoveryCodePage> {
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
                'Please enter your 4-digit recovery\n'
                'code that you received at your',
                style: TextStyle(fontSize: 18.0, color: Colors.grey.shade600),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'email : ',
                  style: TextStyle(fontSize: 18.0, color: Colors.grey.shade600),
                ),
                GestureDetector(
                  child: Text(
                    'sample12345@gmail.com',
                    style: TextStyle(fontSize: 18.0, color: Colors.blue),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SafeArea(child: RecoveryPage());
                    }));
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  VerifyTextField(),
                  VerifyTextField(),
                  VerifyTextField(),
                  VerifyTextField(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return SafeArea(
                          child: RecoveryPage(),
                        );
                      }));
                    },
                    child: FooterText('Not received ? ', 'Resend'),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 90,
            ),
            GestureDetector(
              onTap: (){
                setState(() {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SafeArea(child:  PasswordRecoveryPage());
                  }));
                });
              },
              child: LinearColorBottom('Verify'),
            ),
          ],
        ),
      ),
    );
  }
}

class VerifyTextField extends StatelessWidget {
  VerifyTextField();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 50,
        child: TextField(
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            style: TextStyle(
                color: Colors.black,
                fontSize: 30.0,
                fontWeight: FontWeight.bold),
            maxLength: 1,
            cursorColor: Theme.of(context).primaryColor,
            decoration: InputDecoration(
              hintText: "*",
              counterText: '',
              hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold),
            )),
      ),
    );
  }
}
