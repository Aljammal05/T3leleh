import 'package:flutter/material.dart';
import 'package:t3leleh_v1/Dialogs/Dialogs.dart';
import 'package:t3leleh_v1/PasswordRecoveryPage.dart';
import 'package:t3leleh_v1/RecoveryPage.dart';
import 'package:t3leleh_v1/Tamplets/Templates.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:email_auth/email_auth.dart';

class RecoveryCodePage extends StatefulWidget {
  RecoveryCodePage({this.currentuserid='',this.email=''});
  String currentuserid,email;
  @override
  _RecoveryCodePageState createState() => _RecoveryCodePageState();
}

class _RecoveryCodePageState extends State<RecoveryCodePage> {
  String _code='';
  var emailAuth;
  @override
  void initState() {
    super.initState();
    // Initialize the package
    emailAuth = new EmailAuth(
      sessionName: "Sample session",
    );
  }

  bool verify(String email,String OTP) {
    bool result = emailAuth.validateOtp(
        recipientMail: email,
        userOtp: OTP);
    return result;
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
                'Please enter your 6-digit recovery\n'
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
                    widget.email,
                    style: TextStyle(fontSize: 17.0, color: Colors.blue),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child:
              PinCodeTextField(
                appContext: context,
                length: 6,
                obscureText: false,
                animationType: AnimationType.fade,
                cursorColor:Colors.white ,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.underline,
                 borderWidth: 2,
                 selectedColor: Colors.black,
                 selectedFillColor: Color(0x00ffffff),
                 inactiveFillColor: Color(0x00ffffff),
                 inactiveColor: Colors.grey,
                 activeColor: Colors.grey,
                 // borderRadius: BorderRadius.circular(5),
                 //  fieldHeight: 50,
                 //  fieldWidth: 40,
                   activeFillColor:Color(0x00ffffff),
                ),
                animationDuration: Duration(milliseconds: 300),
                enableActiveFill: true,
                // errorAnimationController: errorController,
                // controller: textEditingController,
                onChanged: (value) {
                  setState(() {
                       _code = value;
                  });
                },
                beforeTextPaste: (text) {
                  // print("Allowing to paste $text");
                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                  return true;
                },
              )
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
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
                  if(_code.length==6) {
                    if(verify(widget.email,_code))
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) {
                      return SafeArea(child: PasswordRecoveryPage(currentuserid: widget.currentuserid,email: widget.email,));
                    }));
                    else showDialog<void>(
                      context: context,
                      builder: (context) => ErrorDialog(
                        title: 'Wrong Code',
                        text:
                        'Please make sure the code you \nentered is correct and try again.',
                      ),
                    );
                  }
                  else showDialog<void>(
                    context: context,
                    builder: (context) => ErrorDialog(
                      title: 'Invalid Code',
                      text:
                      'Make sure you fill the all 6 digits, \nThen press \"Verify\". ',
                    ),
                  );
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