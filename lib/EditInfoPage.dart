import 'package:flutter/material.dart';
import 'package:t3leleh_v1/ProfilePage.dart';
import 'package:t3leleh_v1/Tamplets/Templates.dart';
import 'package:t3leleh_v1/Users/Users.dart';

class EditInfoPage extends StatefulWidget {
  @override
  _EditInfoPageState createState() => _EditInfoPageState();
}

class _EditInfoPageState extends State<EditInfoPage> {
  var reg1city;
  @override
  Widget build(BuildContext context) {
    return SignInPageTemplate(
      true,
      'Edit Info',
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 30.0, left: 30),
                child: Text(
                  'Full Name',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: BuildTextField(Icons.person, //widget.t3user.username//todo
                  '', false, (val) {
                //widget.t3user.username = val;//todo
              }),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 30),
                child: Text(
                  'City / Area',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Material(
                elevation: 6,
                shadowColor: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(90)),
                child: Container(
                  height: 60,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 45,right: 28),
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
                          'Select New City',
                          style: TextStyle(color: Colors.grey.shade700, fontSize: 16),
                        ),
                        items: ['Amman','Zarqa','Irbid','Aqaba']
                            .map((String item) =>
                            DropdownMenuItem<String>(child: Text(item), value: item))
                            .toList(),
                        onChanged: (val) {
                          setState(() {
                            reg1city = val;
                          //  widget.t3user.usercity=val.toString();//todo
                          },
                          );
                        },
                        value: reg1city,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 160.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SafeArea(child: ProfilePage());
                    }));
                  });
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
