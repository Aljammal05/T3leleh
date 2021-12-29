import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:t3leleh_v1/SignInPage.dart';
import 'package:t3leleh_v1/Tamplets/Templates.dart';
import 'package:t3leleh_v1/constans/constans.dart';
import 'Dialogs/Dialogs.dart';

class ChangePasswordPage extends StatefulWidget {
  ChangePasswordPage({this.currentuserid=''});
  String currentuserid;
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}
class _ChangePasswordPageState extends State<ChangePasswordPage> {
  String  oldpass='',newpass = '', confirmpass = '';
  @override
  void _changePassword(String currentPassword, String newPassword) async {
    final user = FirebaseAuth.instance.currentUser;
    String email=await usersref.doc(widget.currentuserid).get().then((value) {return value.data()!['email'];});
    final cred = EmailAuthProvider.credential(
        email:email , password: currentPassword);

    showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) => WaitingDialog()
    );
    user!.reauthenticateWithCredential(cred).then((value) {
      user.updatePassword(newPassword).then((_) {
       usersref.doc(widget.currentuserid).update({
         'password':newPassword
       });
       Navigator.pop(context);
       Navigator.push(context,
           MaterialPageRoute(builder: (context) {
             return SafeArea(child: SignInPage());
           }));//Success, do something
      }).catchError((error) {
        Navigator.pop(context);
        showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (context) => ErrorDialog(
              title: 'Invalid Password',
              text: 'The password you entered is invalid.\nMake sure it have 8 digits or more.',
            ));
      });
    }).catchError((err) {
      Navigator.pop(context);
      showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (context) => ErrorDialog(
            title: 'Incorrect Password',
            text: 'Your old password is incorrect.\nPlease try again.',
          ));
    });}
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
                'Old Password',
                true,
                    (val) {
                  oldpass = val;
                },
                showText: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 21.0),
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
              padding: const EdgeInsets.only(top: 105.0),
              child: GestureDetector(
                onTap: () {
                  if(newpass.length<8) {
                    showDialog<void>(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => ErrorDialog(
                          title: 'Invalid Password',
                          text:
                          'Please make sure your password \ncontain 8 digits or more',
                        ) );
                  }else
                  if (newpass==confirmpass) {
                    _changePassword(oldpass, newpass);
                  }
                  else
                  showDialog<void>(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => ErrorDialog(
                        title: 'Doesn\'t Match',
                        text: 'Please make sure your passwords \nare match',
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
