import 'package:flutter/material.dart';
import 'package:t3leleh_v1/SettingsPage.dart';
import 'package:t3leleh_v1/Tamplets/Templates.dart';
import 'package:t3leleh_v1/constans/constans.dart';
import 'package:t3leleh_v1/Dialogs/Dialogs.dart';

class EditInfoPage extends StatefulWidget {
  EditInfoPage({this.currentuserid='',this.name=''});
  String name,currentuserid;
  @override
  _EditInfoPageState createState() => _EditInfoPageState();
}

class _EditInfoPageState extends State<EditInfoPage> {
  var reg1city;
  String _name='';
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
              child: BuildTextField(Icons.person,widget.name, false, (val) {
                _name=val;
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
                    if (_name.isEmpty&&reg1city==null)
                      showDialog<void>(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => ErrorDialog(title: 'Invalid Input',
                          text: 'You haven\'t make any changes,\nPlease try again. ',)
                      );
                      else {
                      showDialog<void>(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => WaitingDialog()
                      );
                      if (_name.isNotEmpty)
                        usersref.doc(widget.currentuserid).update({
                          'name': _name,
                        });
                      if (reg1city != null)
                        usersref.doc(widget.currentuserid).update({
                          'city': reg1city.toString()
                        });
                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return SafeArea(child: SettingPage(
                              currentuserid: widget.currentuserid,));
                          }));
                    }
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
