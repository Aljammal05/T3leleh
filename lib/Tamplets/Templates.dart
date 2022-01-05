import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:t3leleh_v1/EditPlace.dart';
import 'package:t3leleh_v1/MenuDrawerPage.dart';
import 'package:t3leleh_v1/PlaceMainPage.dart';
import 'package:t3leleh_v1/constans/constans.dart';
import 'package:t3leleh_v1/models/placemodel.dart';

class LinearColorBottom extends StatefulWidget {
  LinearColorBottom(this.bottomtext);
  String bottomtext;
  @override
  _LinearColorBottomState createState() => _LinearColorBottomState();
}

class _LinearColorBottomState extends State<LinearColorBottom> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      shadowColor: Colors.grey,
      borderRadius: BorderRadius.all(Radius.circular(90)),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(90)),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[
                Color(0xff02ECB9),
                Color(0xff0C89C3)
              ], // red to yellow
              tileMode: TileMode.repeated,
            )),
        height: 60,
        width: double.infinity,
        child: Center(
          child: Text(
            widget.bottomtext,
            style: TextStyle(fontSize: 22, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class SignInPageTemplate extends StatefulWidget {
  SignInPageTemplate(this.showheadericon, this.headertext, this.child);
  String headertext;
  bool showheadericon;
  Widget child;

  @override
  _SignInPageTemplateState createState() => _SignInPageTemplateState();
}

class _SignInPageTemplateState extends State<SignInPageTemplate> {
  IconData headericon = Icons.arrow_back;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Material(
              elevation: 4,
              shadowColor: Colors.grey,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(130)),
              child: Container(
                height: 239,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(130)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[
                        Color(0xff02ECB9),
                        Color(0xff0C89C3)
                      ], // red to yellow
                      tileMode: TileMode.repeated,
                    )),
                child: Column(
                  children: [
                    widget.showheadericon
                        ? Expanded(
                            flex: 1,
                            child: Align(
                              child: GestureDetector(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Icon(
                                    headericon,
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
                          )
                        : Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container(
                              height: 28,
                              width: 28,
                            ),
                          ),
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: Image.asset(
                          'image/T3leleh.png',
                          height: 90,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Align(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              widget.headertext,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                          alignment: Alignment.centerRight),
                    ),
                  ],
                ),
              ),
            ),
            widget.child
          ],
        ),
      ),
    );
  }
}

class BuildTextField extends StatefulWidget {
  BuildTextField(this.prefixIcon, this.text, this.showsuffixIcon, this.fun,
      {this.showText = true});

  IconData prefixIcon;
  String text;
  bool showsuffixIcon;
  Color color = Colors.grey;
  bool showText;
  Function fun;
  @override
  _BuildTextFieldState createState() => _BuildTextFieldState();
}

class _BuildTextFieldState extends State<BuildTextField> {
  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 6,
        shadowColor: Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(90)),
        child: TextField(
          onChanged: (String val) {
            widget.fun(val);
          },
          keyboardType: TextInputType.visiblePassword,
          obscureText: !widget.showText,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(90),
                ),
                borderSide: BorderSide(
                  color: Color(0x00ffff),
                )),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(90.0),
                borderSide: BorderSide(color: Color(0x00ffff), width: 3.0)),
            hintText: widget.text,
            prefixIcon: Padding(
              padding: const EdgeInsets.all(16),
              child: Icon(
                widget.prefixIcon,
                size: 30,
                color: Colors.grey,
              ),
            ),
            suffixIcon: widget.showsuffixIcon
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GestureDetector(
                      child: Icon(
                        Icons.visibility,
                        color: widget.color,
                      ),
                      onTap: () {
                        setState(() {
                          if (widget.color == Colors.grey) {
                            widget.color = Colors.blue;
                            widget.showText = true;
                          } else {
                            widget.color = Colors.grey;
                            widget.showText = false;
                          }
                        });
                      },
                    ),
                  )
                : Container(
                    height: 0,
                    width: 0,
                  ),
          ),
        ));
  }
}

class FooterText extends StatelessWidget {
  FooterText(this.question, this.action);
  String question;
  String action;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          question,
          style: TextStyle(
            color: Colors.grey.shade600,
          ),
        ),
        Text(
          action,
          style: TextStyle(
            fontSize: 18,
            color: Color(0xff08AFBF),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class DashboardTemplate extends StatefulWidget {
  DashboardTemplate(this.currentuserid,this.topcolor, this.bottomcolor, this.imagepath,
      this.pagename, this.icon, this.nextpage, this.child);
  Color topcolor;
  Color bottomcolor;
  String imagepath;
  String pagename;
  IconData icon;
  Widget nextpage;
  Widget child;
  String currentuserid;
  @override
  _DashboardTemplateState createState() => _DashboardTemplateState();
}

class _DashboardTemplateState extends State<DashboardTemplate> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: MenuDrawerPage(currentuserid: widget.currentuserid,),
        body: Builder(
          builder: (context) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(widget.imagepath),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                            Color(0xb802ECB9),
                            Color(0xb80C89C3)
                          ], // red to yellow
                          tileMode: TileMode.repeated,
                        ),
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(25))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                Scaffold.of(context).openDrawer();
                              });
                            },
                            child: Icon(
                              Icons.menu,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          Center(
                            child: Text(
                              widget.pagename,
                              style:
                                  TextStyle(fontSize: 27, color: Colors.white),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return widget.nextpage;
                                }));
                              });
                            },
                            child: Icon(
                              widget.icon,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                    height: 100,
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: <Color>[
                              widget.topcolor,
                              widget.bottomcolor,
                            ], // red to yellow
                            tileMode: TileMode.repeated,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 16),
                        child: SingleChildScrollView(child: widget.child),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AnimatedToggle extends StatefulWidget {
  final List<String> values;
  final ValueChanged onToggleCallback;
  final Color backgroundColor;
  final Color textColor;
  final double width, height, fontsize, padding, radius;
  bool initialPosition ;
  AnimatedToggle(
      this.initialPosition,
      this.values,
      this.onToggleCallback,
      this.backgroundColor,
      this.textColor,
      this.width,
      this.height,
      this.fontsize,
      this.padding,
      this.radius);
  @override
  _AnimatedToggleState createState() => _AnimatedToggleState();
}

class _AnimatedToggleState extends State<AnimatedToggle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(45))),
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              widget.initialPosition = !widget.initialPosition;
              var index = 0;
              if (!widget.initialPosition) {
                index = 1;
              }
              widget.onToggleCallback(index);
              setState(() {});
            },
            child: Container(
              width: widget.width,
              height: widget.height,
              decoration: ShapeDecoration(
                color: widget.backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(widget.radius),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  widget.values.length,
                  (index) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: widget.padding),
                    child: Text(
                      widget.values[index],
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: widget.fontsize,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff9e9e9e),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          AnimatedAlign(
            duration: const Duration(milliseconds: 250),
            curve: Curves.decelerate,
            alignment:
                widget.initialPosition ? Alignment.centerLeft : Alignment.centerRight,
            child: Container(
              width: widget.width * 0.5,
              height: widget.height,
              decoration: ShapeDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[
                    Color(0xff02ECB9),
                    Color(0xff0C89C3)
                  ], // red to yellow
                  tileMode: TileMode.repeated,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(widget.radius),
                ),
              ),
              child: Center(
                child: Text(
                  widget.initialPosition ? widget.values[0] : widget.values[1],
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: widget.fontsize,
                    color: widget.textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PlaceWidget extends StatefulWidget {
  PlaceWidget({required this.currentuserid,this.currentplaceID = '', this.height = 190});
  String currentplaceID,currentuserid;
  double height;

  @override
  _PlaceWidgetState createState() => _PlaceWidgetState();
}

class _PlaceWidgetState extends State<PlaceWidget> {
  String _usertype='';
  List favlist=[];
  void initState(){
    super.initState();
    _getUserData();
  }
  void _getUserData()async{
     favlist=await usersref.doc(widget.currentuserid).get().then((value) {return value.data()!['favoriteplaces'];});
    _usertype=await usersref.doc(widget.currentuserid).get().then((value) {return value.data()!['userType'];});
    setState(() {
      _usertype=_usertype;
    });
  }
  bool _isFavorate(){
    for(int i =0;i<favlist.length;i++){
      if(favlist[i]==widget.currentplaceID)
        return true;
    }
    return false;
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: placesref.doc(widget.currentplaceID).get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            );
          }
          PlaceModel placeModel;
          try {
            PlaceModel placeModel = PlaceModel.fromdoc(snapshot.data);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                          return SafeArea(
                            child: _usertype == 'user' ? PlaceMainPage(
                              currentplaceID: widget.currentplaceID,
                              currentuserID: widget.currentuserid,
                            ) : EditPlace(widget.currentplaceID,
                                placeModel.cost_per_person,
                                widget.currentuserid),
                          );
                        }));
                  });
                },
                child: Container(
                    height: widget.height,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      image: DecorationImage(
                        image: NetworkImage(placeModel.placepicURl),
                        colorFilter: new ColorFilter.mode(
                            Colors.white.withOpacity(0.85), BlendMode.dstATop),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              _usertype == 'user' ?
                              GestureDetector(
                                onTap: () {
                                  _getUserData();
                                  setState(() {
                                    if (_isFavorate()) {
                                      usersref.doc(widget.currentuserid).update(
                                          {
                                            'favoriteplaces': FieldValue
                                                .arrayRemove(
                                                [widget.currentplaceID])
                                          });
                                    } else {
                                      usersref.doc(widget.currentuserid).update(
                                          {
                                            'favoriteplaces': FieldValue
                                                .arrayUnion(
                                                [widget.currentplaceID])
                                          });
                                    }
                                  });
                                },
                                child: Icon(
                                  _isFavorate()
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Colors.white,
                                  size: 27,
                                ),
                              ) : Container()
                            ],
                          ),
                          Column(
                            children: [
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  placeModel.name,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Text(
                                    placeModel.city +
                                        ',' +
                                        (placeModel.area.length > 5 ? placeModel
                                            .area.substring(0, 5) : placeModel
                                            .area),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20 - 6),
                                  ),
                                  Icon(
                                     rateicon(placeModel.cost_per_person.round()),
                                    //FontAwesomeIcons.solidSmile,
                                    color: Colors.white,
                                    size: 24,
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    )),
              ),
            );
          }catch(e){
            print(e);
            return Container();
          }
        });

  } IconData rateicon(int x) {
    switch ((x%3)+3) {
      case 1:
        return FontAwesomeIcons.solidAngry;
      case 2:
        return FontAwesomeIcons.solidFrown;
      case 3:
        return FontAwesomeIcons.solidMeh;
      case 4:
        return FontAwesomeIcons.solidSmile;
      case 5:
        return FontAwesomeIcons.solidGrinBeam;
      default:
        return FontAwesomeIcons.solidMeh;
    }
  }
}

class CategoryWidget extends StatefulWidget {
  CategoryWidget(this.imagepath,this.fun);
  String imagepath;
  Function fun;
  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  Color backcolor = Color(0x55ffffff);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            backcolor = backcolor == Color(0x55ffffff)
                ? Color(0xb83AAEC2)
                : Color(0x55ffffff);
            widget.fun();
          });
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: backcolor,
              image: DecorationImage(
                  image: AssetImage(widget.imagepath), fit: BoxFit.cover)),
          height: 90,
          width: 90,
        ),
      ),
    );
  }
}

class Categoryaddplace extends StatefulWidget {
  Categoryaddplace(this.imagepath, this.backcolor);
  String imagepath;
  Color backcolor = Color(0x55ffffff);

  @override
  _CategoryaddplaceState createState() => _CategoryaddplaceState();
}

class _CategoryaddplaceState extends State<Categoryaddplace> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: widget.backcolor,
            image: DecorationImage(
                image: AssetImage(widget.imagepath), fit: BoxFit.cover)),
        height: 90,
        width: 90,
      ),
    );
  }
}

class Dropdownbox extends StatefulWidget {
  Dropdownbox(this._salutations, this.hint, this.fun);

  final List<String> _salutations;
  Function fun;
  String hint;

  @override
  _DropdownboxState createState() => _DropdownboxState();
}

class _DropdownboxState extends State<Dropdownbox> {
  var salutation;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0x33ffffff),
          borderRadius: BorderRadius.all(Radius.circular(25))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28.0),
        child: DropdownButton(
          underline: Container(
            height: 0,
          ),
          icon: Icon(Icons.keyboard_arrow_down),

          iconSize: 30,
          style: TextStyle(
            color: Colors.white,
            fontSize: 23,
          ),
          isExpanded: true,
          //menuMaxHeight: 200,
          dropdownColor: Color(0xb83AAEC2),
          iconEnabledColor: Colors.white,
          hint: Text(
            widget.hint,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          items: widget._salutations
              .map((String item) =>
                  DropdownMenuItem<String>(child: Text(item), value: item))
              .toList(),
          onChanged: (val) {
            setState(
              () {
                salutation = val;
                widget.fun(val);
              },
            );
          },
          value: salutation,
        ),
      ),
    );
  }
}

class ImageContainerStackTemplate extends StatelessWidget {
  ImageContainerStackTemplate(
      this.imagepath, this.imagechild, this.containerchild);
  ImageProvider imagepath;
  Widget imagechild;
  Widget containerchild;


  @override
  Widget build(BuildContext context) {
    MediaQueryData mq = MediaQuery.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
                height: 390,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('image/default.png'),
                  fit: BoxFit.fitWidth,
                )),
                child: Container()),
          ),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
                height: 390,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: imagepath,
                  fit: BoxFit.fitWidth,
                )),
                child: imagechild),
          ),
          Positioned(
            top: 235,
            bottom: 0,
            child: Container(
              height: mq.size.height -300,
              width: mq.size.width+0.3,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25),
                      topLeft: Radius.circular(25)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      Color(0xff02ECB9),
                      Color(0xff0C89C3)
                    ], // red to yellow
                    tileMode: TileMode.repeated,
                  )),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(child: containerchild),
              ),
            ),
          ),
        ],
        fit: StackFit.expand,
        overflow: Overflow.visible,
      ),
    );
  }
}
