import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class SignUpPage extends StatefulWidget{
  @override
  _SignupPageSate createState()=>_SignupPageSate();
}
class _SignupPageSate extends State<SignUpPage>{
  String _email;
  String   _password;
  final formkey=new GlobalKey<FormState>();
  checkFields(){
    final form=formkey.currentState;
    if(form.validate()){
      form.save();
      return true;
    }
    return false;
  }



   createUser()async{
    if (checkFields()){
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password)
          .then((user){
        print('signed in as ${user.uid}');

        Navigator.of(context).pop();
        Navigator.of(context).pushNamed('/userpage');
      }).catchError((e){
        print(e);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(

      appBar: AppBar(
        title: Image(image:AssetImage("images/flutter1.png",),
          height: 30.0,
          fit: BoxFit.fitHeight,),
        elevation: 0.0,

        centerTitle: true,
        backgroundColor: Colors.black12,

      ),
      body:ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
            height: 210.0,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/google2.gif'),
                    fit: BoxFit.contain),
                borderRadius: BorderRadius.only
                  (
                    bottomLeft: Radius.circular(500.0),
                    bottomRight: Radius.circular(500.0)
                )),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: Center(
                  child: new Form(
                    key: formkey,
                    child: Center(
                      child: new ListView(
                        shrinkWrap: true,
                        children: <Widget>[

                         _input("required email",false,"Email",'Enter your Email',(value) => _email = value),
                          SizedBox(width: 20.0,height: 20.0,),
                          _input("required password",true,"Password",'Password',(value) => _password = value),

                          Center(
                            child: Padding(
                              padding: EdgeInsets.only(left: 138.0,top: 8.0),
                              child: Row(
                                children: <Widget>[
                                  OutlineButton(
                                    child: Text("Register"),
                                    onPressed: createUser,
                                  ),
                                  SizedBox(height: 18.0,width: 18.0,),


                                ],
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  )
              ),
            ),
          ),
        ],
      ) ,
    );
  }
  Widget _input(String validation,bool ,String label,String hint, save ){

    return new TextFormField(
      decoration: InputDecoration(
          hintText: hint,
          labelText: label,
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0)
          ),


      ),
      obscureText: bool,
      validator: (value)=>
      value.isEmpty ? validation: null,
      onSaved: save ,

    );

  }
}

