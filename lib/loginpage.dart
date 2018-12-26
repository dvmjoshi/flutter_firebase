import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
class LoginPage extends StatefulWidget{
  @override
  _LoginPageSate createState()=>_LoginPageSate();
}
class _LoginPageSate extends State<LoginPage>{
  String _email;
  String   _password;
  //google sign
  GoogleSignIn googleauth = new GoogleSignIn();
  final formkey=new GlobalKey<FormState>();
  checkFields(){
    final form=formkey.currentState;
    if(form.validate()){
      form.save();
      return true;
    }
    return false;
  }



  LoginUser(){
    if (checkFields()){
      FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password)
          .then((user){
        print("signed in as ${user.uid}");
        Navigator.of(context).pushReplacementNamed('/userpage');
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
        title: Image(image:AssetImage("images/flutter1.png",),height: 30.0,fit: BoxFit.fitHeight,),

        elevation: 0.0,

        centerTitle: true,
        backgroundColor: Colors.transparent,

      ),
      body:
      ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
            height: 220.0,
            width: 110.0,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/monkey.gif'),
                    fit: BoxFit.cover),
              borderRadius: BorderRadius.only
                (
                  bottomLeft: Radius.circular(500.0),
                  bottomRight: Radius.circular(500.0)
              ),
           ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: Center(
                  child: Form(
                    key: formkey,
                    child: Center(
                      child: ListView(
                        shrinkWrap: true,
                        children: <Widget>[

                          _input("required email",false,"Email",'Enter your Email',(value) => _email = value),
                          SizedBox(width: 20.0,height: 20.0,),
                          _input("required password",true,"Password",'Password',(value) => _password = value),
            new Padding(padding: EdgeInsets.all(8.0),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Row(
                          children: <Widget>[
                            Expanded(
                              child: OutlineButton(
                                child: Text("Login "),
                                onPressed:LoginUser
                              ),
                              flex: 1,
                            ),
                            SizedBox(height: 18.0,width: 18.0,),
                           
                            SizedBox(height: 18.0,width: 18.0,),
                            Expanded(
                              flex: 1,
                              child: OutlineButton(
                                  //child: Text("login with google"),
                                 // child: ImageIcon(AssetImage("images/google1.png"),semanticLabel: "login",),
                                  child: Image(image: AssetImage("images/google1.png"),height:28.0,fit: BoxFit.fitHeight),
                                  onPressed: (){
                                googleauth.signIn().then((result){result.authentication.then((googleuser){
                                  FirebaseAuth.instance.signInWithGoogle
                                    (idToken: googleuser.idToken, accessToken: googleuser.accessToken).
                                  then((user){
                                    print("Signedin user ${user.displayName}");
                                    Navigator.of(context).pushReplacementNamed("/userpage");
                                  }).catchError((e){
                                    print(e);
                                  });
                                }).catchError((e){
                                  print(e);
                                });}).catchError((e){
                                  print(e);
                                });
                                  }),
                            )

                          ],
                    ),
                    SizedBox(height: 15.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'New login with google?',
                          style: TextStyle(fontFamily: 'Montserrat'),
                        ),
                        SizedBox(width: 5.0),
                        InkWell(
                          child: Text(
                            'create new account',
                            style: TextStyle(
                                color: Colors.blue,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),
                          ),
                        )
                      ],
                    ),
                    OutlineButton(
                        child: Text("signup"),
                        onPressed: (){
                          Navigator.of(context).pushNamed('/signup');
                        }),
                    OutlineButton(
                        child: Text("ui"),
                        onPressed: (){
                          Navigator.of(context).pushNamed('/userpage');
                        })
                  ],

                ),

              ),
            ),),

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

