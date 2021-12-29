import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:t3leleh_v1/SignInPage.dart';
import 'package:t3leleh_v1/Tamplets/Templates.dart';
import 'package:t3leleh_v1/constans/constans.dart';
import 'Dialogs/Dialogs.dart';

class EditEmailPage extends StatefulWidget {
  EditEmailPage({this.currentuserid = '', this.email: ''});
  final String currentuserid, email;
  @override
  _EditEmailPageState createState() => _EditEmailPageState();
}

class _EditEmailPageState extends State<EditEmailPage> {
  String _email = '', _password = '';
  void changeEmail(String newEmail, String currentPassword) {
    final user = FirebaseAuth.instance.currentUser;
    final cred = EmailAuthProvider.credential(
        email: widget.email, password: currentPassword);
    showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) => WaitingDialog());
    user!.reauthenticateWithCredential(cred).then((value) {
      user.updateEmail(newEmail).then((_) {
        usersref.doc(widget.currentuserid).update({'email': newEmail});
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return SafeArea(
            child: SignInPage(),
          );
        }));
      }).catchError((error) {
        Navigator.pop(context);
        showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (context) => ErrorDialog(
                  title: 'Invalid Email',
                  text:
                      'This email address is not available.\nChoose a different address.',
                ));
      });
    }).catchError((err) {
      Navigator.pop(context);
      showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (context) => ErrorDialog(
                title: 'Incorrect Password',
                text: 'Password you entered is incorrect.\nPlease try again.',
              ));
    });
  }

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
                widget.email,
                false,
                (val) {
                  _email = val;
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
                  _password = val;
                },
                showText: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 160.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    if (_email.isEmpty || _password.isEmpty) {
                      ErrorDialog(
                        title: 'Sorry',
                        text:
                            'All of fields are required,\nplease fill all of them.',
                      );
                    } else {
                      changeEmail(_email, _password);
                    }
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
