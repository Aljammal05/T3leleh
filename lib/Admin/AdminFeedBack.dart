
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:t3leleh_v1/Dialogs/Dialogs.dart';
import 'package:t3leleh_v1/constans/constans.dart';
import 'package:t3leleh_v1/models/usermodel.dart';

class AdminFeedBack extends StatefulWidget {
  const AdminFeedBack({Key? key}) : super(key: key);

  @override
  _AdminFeedBackState createState() => _AdminFeedBackState();
}
class _AdminFeedBackState extends State<AdminFeedBack> {
int _selectedtap=0;
var _stream=feedbackref.where('rating',isEqualTo:'Terrible' ).snapshots();
Query(int index){
  setState(() {
    switch(index){
      case 0: _stream=feedbackref.where('rating',isEqualTo:'Terrible' ).snapshots();break;
      case 1: _stream=feedbackref.where('rating',isEqualTo:'Bad' ).snapshots();break;
      case 2: _stream=feedbackref.where('rating',isEqualTo:'Okay' ).snapshots();break;
      case 3: _stream=feedbackref.where('rating',isEqualTo:'Good' ).snapshots();break;
      case 4: _stream=feedbackref.where('rating',isEqualTo:'Great' ).snapshots();break;
    }
  });
}
List<Widget> l=[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream:_stream ,
        builder: (context,AsyncSnapshot snapshot){
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            );
          }
          l=[];
          snapshot.data!.docs.forEach((element) async{
            l.add(FeedBackWidget(id: element.id, feedback: element.data()['feedback']));
          });
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.only(bottomLeft:Radius.circular(45) ),
                shadowColor: Colors.grey,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomLeft:Radius.circular(45) ),
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
                              padding: const EdgeInsets.all(20.0),
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
                            'FeedBack',
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
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 22.0, horizontal: 15),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children:l
                  ),
                ),
              ),
            )
          ],
        );
        }
      ),
      bottomNavigationBar: BottomNavigationBar(

        onTap: (index) {
          setState(() {
            _selectedtap = index;
          });
          Query(_selectedtap);
        },
        currentIndex: _selectedtap,
        fixedColor: Colors.white,
        backgroundColor: Color(0xff08AFBF),
        items: [
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.solidAngry,size: 45,),
              title: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  'Terrible',
                  style: TextStyle(fontSize: 16),
                ),
              )),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.solidFrown,size: 45,),
              title: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  'Bad',
                  style: TextStyle(fontSize: 16),
                ),
              )),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.solidMeh,size: 45,),
              title: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  'Okay',
                  style: TextStyle(fontSize: 16),
                ),
              )),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.solidSmile,size: 45,),
              title: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  'Good',
                  style: TextStyle(fontSize: 16),
                ),
              )),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.solidGrin,size: 45,),
              title: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  'Great',
                  style: TextStyle(fontSize: 16),
                ),
              )),
        ],
      ),
    );
  }
}

class FeedBackWidget extends StatefulWidget {
  const FeedBackWidget({
    Key? key,
    required this.id,
    required this.feedback,
  }) : super(key: key);

  final String id;
  final String feedback;

  @override
  _FeedBackWidgetState createState() => _FeedBackWidgetState();
}

class _FeedBackWidgetState extends State<FeedBackWidget> {
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: usersref.doc(widget.id).get(),
      builder: (context,AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
          );
        }
        UserModel userModel=UserModel.fromdoc(snapshot.data);
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: GestureDetector(
            onTap: (){
              showDialog<void>(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => FeedbackDialog(userModel.name,widget.feedback,userModel.userType)
              );
            },
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: CircleAvatar(
                          radius: 18,
                          backgroundImage: userModel.ProfilePicURL.isEmpty ? AssetImage(
                              'image/profile-default-pic.jpg') : NetworkImage(
                              userModel.ProfilePicURL) as ImageProvider,
                          backgroundColor: Color(0x00ffffff),
                        ),
                      ),
                      Text(userModel.name, style: TextStyle(fontSize: 24),),
                      Text(' ('+userModel.userType+')',
                        style: TextStyle(fontSize: 18, color: Colors.grey),),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 30),
                    child: Text(
                      widget.feedback.length >= 100 ? widget.feedback.substring(
                          0, 100) + " ..." : widget.feedback,
                      style: TextStyle(fontSize: 18, color: Colors.grey),),
                  ),

                ],
              ),
            ),
          ),
        );
      }
    );
  }
}



