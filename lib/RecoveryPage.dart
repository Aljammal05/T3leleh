import 'package:flutter/material.dart';
import 'package:t3leleh_v1/RecoveryCodePage.dart';
import 'package:t3leleh_v1/Tamplets/Templates.dart';
import 'package:t3leleh_v1/constans/constans.dart';
import 'SignInPage.dart';
import 'package:email_auth/email_auth.dart';
import 'package:t3leleh_v1/Dialogs/Dialogs.dart';

class RecoveryPage extends StatefulWidget {
  @override
  _RecoveryPageState createState() => _RecoveryPageState();
}

class _RecoveryPageState extends State<RecoveryPage> {
  String recemail = '';
  var emailAuth;
  @override
  void initState() {
    super.initState();
    // Initialize the package
    emailAuth = new EmailAuth(
      sessionName: "anything",
    );
  }

  void sendOtp(String email) async {
    String userid = '';
    usersref.where('email', isEqualTo: recemail).get().then(
      (value) async {
        showDialog<void>(
          context: context,
          builder: (context) => WaitingDialog()
      );
        if (value.docs.isNotEmpty) {

          bool result =
              await emailAuth.sendOtp(recipientMail: email, otpLength: 6);

          if (result) {
            userid = value.docs[0].reference.id;
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return SafeArea(
                  child: RecoveryCodePage(
                currentuserid: userid,
                email: recemail,
              ));
            }));
          }
        } else {
          Navigator.pop(context);
          showDialog<void>(
            context: context,
            builder: (context) => ErrorDialog(
              title: 'Invalid Email',
              text:
                  'This email address is not available.\nChoose a different address.',
            ),
          );
        }
      },
    );
  }

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
                child: BuildTextField(
                  Icons.email,
                  'Email',
                  false,
                  (val) {
                    recemail = val;
                  },
                ),
              ),
              SizedBox(
                height: 140,
              ),
              GestureDetector(
                onTap: () {
                  sendOtp(recemail);
                },
                child: LinearColorBottom('SEND'),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SafeArea(
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
