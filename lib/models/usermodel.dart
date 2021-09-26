import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String ID,name, email, password, phoneNO, city, userType, ProfilePicURL ;
  List  ownedplaces=[],recentlyvisited=[],favoriteplaces=[];
  UserModel(
      {
        this.ID='',
      this.name = '',
      this.email = '',
      this.password = '',
      this.phoneNO = '',
      this.city = '',
      this.userType='',
      this.ProfilePicURL='',
      this.ownedplaces=const[],
        this.recentlyvisited=const[],
        this.favoriteplaces=const[],
      });
  factory UserModel.fromdoc(DocumentSnapshot doc){
return UserModel(
  ID:doc.id,
  userType: doc['userType'],
  name: doc['name'],
  email: doc['email'],
  password: doc['password'],
  phoneNO: doc['phoneNo'],
  city: doc['city'],
  ProfilePicURL: doc['ProfilePicURL'],
  ownedplaces:doc['ownedplaces'],
  recentlyvisited: doc['recentlyvisited'],
  favoriteplaces: doc['favoriteplaces'],
);
  }
}
