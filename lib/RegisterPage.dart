import 'package:flutter/material.dart';
import 'package:t3leleh_v1/SignInPage.dart';
import 'package:t3leleh_v1/Tamplets/Templates.dart';
import 'package:t3leleh_v1/Services/auth_service.dart';
import 'Dialogs/Dialogs.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  int _toggleValue = 0;
  String _regname = '',
      _regemail = '',
      _regpassword = '',
      _regphoneNO = '',
      _regcity = '';
  var _reg1city;
  @override
  Widget build(BuildContext context) {
    return SignInPageTemplate(
      true,
      'Register',
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Container(
                height: 330,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Material(
                            elevation: 4,
                            shadowColor: Colors.grey,
                            borderRadius: BorderRadius.all(Radius.circular(90)),
                            child: AnimatedToggle(
                                _toggleValue==0?true:false,
                                ['Owner', 'User'], (value) {
                              setState(() {
                                _toggleValue = value;
                              });
                            }, const Color(0xFFffffff), const Color(0xffffffff),
                                300, 40, 20, 45, 20),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 36.0),
                          child: BuildTextField(Icons.person, 'Fullname', false,
                              (val) {
                            _regname = val;
                          }),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: BuildTextField(Icons.email, 'Email', false,
                              (val) {
                            _regemail = val;
                          }),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: BuildTextField(
                            Icons.lock,
                            'Password',
                            true,
                            (val) {
                              _regpassword = val;
                            },
                            showText: false,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: BuildTextField(
                              Icons.phone, 'Phone number', false, (val) {
                            _regphoneNO = val;
                          }),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Material(
                            elevation: 6,
                            shadowColor: Colors.grey,
                            borderRadius: BorderRadius.all(Radius.circular(90)),
                            child: Container(
                              height: 60,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 45, right: 28),
                                  child: DropdownButton(
                                    underline: Container(
                                      height: 0,
                                    ),
                                    icon: Icon(Icons.keyboard_arrow_down),
                                    iconSize: 30,
                                    style: TextStyle(
                                      color: Colors.grey.shade700,
                                      fontSize: 22,
                                    ),
                                    isExpanded: true,
                                    menuMaxHeight: 200,
                                    dropdownColor: Color(0xffffffff),
                                    iconEnabledColor: Colors.grey,
                                    hint: Text(
                                      'Select Your City',
                                      style: TextStyle(
                                          color: Colors.grey.shade700,
                                          fontSize: 16),
                                    ),
                                    items: ['Amman', 'Zarqa', 'Irbid', 'Aqaba']
                                        .map((String item) =>
                                            DropdownMenuItem<String>(
                                                child: Text(item), value: item))
                                        .toList(),
                                    onChanged: (val) {
                                      setState(() {
                                        _reg1city = val;
                                        _regcity = val.toString();
                                      });
                                    },
                                    value: _reg1city,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, left: 20, right: 20),
              child: GestureDetector(
                onTap: () {
                  if (_regemail.isEmpty ||
                      _regpassword.isEmpty ||
                      _regname.isEmpty ||
                      _regphoneNO.isEmpty ||
                      _regcity.isEmpty) {
                    showDialog<void>(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => ErrorDialog(
                              title: 'Sorry',
                              text:
                                  'All of fields are required,\nplease fill all of them.',
                            ));
                  }
                  else
                    if(_regpassword.length<8) {
                      showDialog<void>(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => ErrorDialog(
                            title: 'Invalid Password',
                            text:
                            'Please make sure your password \ncontain 8 digits or more',
                          ) );
                    }
                    else
                  try {
                    setState(() async {
                      showDialog<void>(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => WaitingDialog());
                      bool isvalid = await auth_service.signUp(
                          _regname,
                          _regemail,
                          _regpassword,
                          _regphoneNO,
                          _regcity,
                          _toggleValue == 0 ? 'owner' : 'user',
                          context);
                      if (isvalid) {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      } else {
                        print('something wrong');
                      }
                    });
                  } catch (e) {
                    print(e);
                  }
                },
                child: LinearColorBottom('REGISTER'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: FooterText(
                  'Already a member ? ',
                  'Login',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
