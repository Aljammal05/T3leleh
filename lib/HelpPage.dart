import 'dart:ui';
import 'package:flutter/material.dart';
import 'Users/Users.dart';

class HelpPage extends StatefulWidget {
  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1,
            child: Material(
              elevation: 4,
              shadowColor: Colors.grey,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(45)),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(45)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[
                        Color(0xff02ECB9),
                        Color(0xff0C89C3)
                      ], // red to yellow
                      tileMode: TileMode.repeated,
                    )),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Align(
                        child: GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              Navigator.pop(context);
                            });
                          },
                        ),
                        alignment: Alignment.topLeft,
                      ),
                    ),
                    Expanded(
                      flex: 15,
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.only(right: 60.0),
                        child: Text(
                          'Help',
                          style: TextStyle(color: Colors.white, fontSize: 28),
                        ),
                      )),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: HelpQuestion('How can I delete my account ?',
                        'dashboard > menu > profile > delete account'),
                  ),
                  HelpQuestion('How can I change my password ?',
                      'dashboard > menu > settings > security'),
                  userType == usertype.user
                      ? HelpQuestion('Can I specify my requirement ?',
                          'yes you can\ndashboard > filter')
                      : HelpQuestion('How can I manage my owned places ?',
                          'dashboard > menu > profile > owned places'),
                  HelpQuestion('How can I change my information ?',
                      'dashboard > menu > settings > me'),
                  HelpQuestion('Can I rate the Application ?',
                      'yes you can\ndashboard > menu > settings > rate us'),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Contact us',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    '+962787654321\nT3leleh@gmail.com',
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class HelpQuestion extends StatelessWidget {
  HelpQuestion(this.question, this.answer);
  final String question;
  final String answer;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 16),
              child: Text(
                question,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 42, bottom: 12),
              child: Text(
                answer,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade400,
                ),
              ),
            ),
            Divider(
              color: Colors.grey.shade400,
              thickness: 1,
            ),
          ],
        ),
      ),
    );
  }
}
