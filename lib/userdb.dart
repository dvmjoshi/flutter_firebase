/*import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class userdb {
newUser(user,context){
  Firestore.instance.collection('/users').add({
    'emial':user.email,
    'uid':user.uid
  }).then((value){
Navigator.of(context).pop();
    Navigator.of(context).pushReplacementNamed('/homepage');
  }).catchError((e){
    print(e);
  });
}

}*/