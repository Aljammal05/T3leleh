import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:t3leleh_v1/Dialogs/Dialogs.dart';
import 'package:t3leleh_v1/Services/auth_service.dart';
import 'package:t3leleh_v1/SignInPage.dart';
import 'package:t3leleh_v1/Tamplets/Templates.dart';
import 'package:t3leleh_v1/constans/constans.dart';

class PasswordRecoveryPage extends StatefulWidget {
  PasswordRecoveryPage({this.currentuserid = '', this.email = ''});
  String currentuserid, email;
  @override
  _PasswordRecoveryPageState createState() => _PasswordRecoveryPageState();
}

class _PasswordRecoveryPageState extends State<PasswordRecoveryPage> {
  String newpassword = '', confirmpassword = '';
  @override
  void _changePassword(String newPassword) async {

    showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) => WaitingDialog());
    String currentpass =
        await usersref.doc(widget.currentuserid).get().then((value) {
      return value.data()!['password'];
    });
    auth_service.signIn(widget.email, currentpass);
    final user = FirebaseAuth.instance.currentUser;
    final cred = EmailAuthProvider.credential(
        email: widget.email, password: currentpass);

    user!.reauthenticateWithCredential(cred).then((value) {
      user.updatePassword(newPassword).then((_) {
        usersref.doc(widget.currentuserid).update({'password': newPassword});
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return SafeArea(child: SignInPage());
        })); //Success, do something
      }).catchError((error) {
        print('fail'); //Error, show something todo
      });
    }).catchError((err) {
      print(err);
    });
  }

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
                  if (newpassword.length < 8) {
                    showDialog<void>(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => ErrorDialog(
                              title: 'Invalid Password',
                              text:
                                  'Please make sure your password \ncontain 8 digits or more',
                            ));
                  } else if (newpassword == confirmpassword) {
                    _changePassword(newpassword);
                  } else
                    showDialog<void>(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => ErrorDialog(
                              title: 'Doesn\'t Match',
                              text:
                                  'Please make sure your passwords \nare match',
                            ));
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
