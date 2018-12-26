import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase/flutterteam.dart';
import 'package:flutter_firebase/loginpage.dart';
import 'package:flutter_firebase/people.dart';
import 'package:flutter_firebase/signup.dart';

class Page extends StatefulWidget {
  @override
  _FlutterPageState createState() => _FlutterPageState();
}

class _FlutterPageState extends State<Page> with SingleTickerProviderStateMixin{
  AnimationController animationController;
  Animation      animation;
  @override
  void initState(){
    animationController =new AnimationController(duration: Duration(seconds: 10),vsync: this);
    animation=IntTween(begin: 0,end:photos.length-1 ).animate(animationController)
    ..addListener((){
      setState(() {
        photoindex=animation.value;
      });
    });
    animationController.repeat();
  }
  @override
  void dispose()
  {
    super.dispose();
    animationController.dispose();
  }
  int photoindex=0;
  List<String>photos=[
    "images/flutter1.png",
    "images/Logomark.png",
    "images/google1.png",
    "images/dart.png",
    "images/bird.jpg"


  ];
  void _previousImage() {
    setState(() {
      photoindex = photoindex > 0 ? photoindex - 1 : 0;
    });
  }

  void _nextImage() {
    setState(() {
      photoindex = photoindex < photos.length - 1 ? photoindex + 1 : photoindex;
    });
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
        leading: IconButton(icon: Icon(Icons.arrow_back),color: Colors.grey, onPressed: (){
          Navigator.of(context).pushReplacementNamed("/loginpage");
        }),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.menu,color: Colors.grey,),
              onPressed:(){
                showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return new Container(
                          child: new Padding(
                              padding: const EdgeInsets.all(32.0),
                              child: new Text(
                                  'made with love .via Divyam joshi '
                                      'if you like my work star my repo and thats motivate me ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0))));
                    });
              })
        ],
      ),
      body: new ListView(
        shrinkWrap: true,
        children: <Widget>[
          Stack(
            children: <Widget>[

              Container(
                height: 210.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(photos[photoindex]),
                        fit: BoxFit.scaleDown)),
              ),

            /*  GestureDetector(
                child: Container(
                  height: 210.0,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                ),
                onTap: _nextImage,
              ),
              GestureDetector(
                child: Container(
                  height: 210.0,
                  width: MediaQuery.of(context).size.width / 2,
                  color: Colors.transparent,
                ),
                onTap: _previousImage,
              ),*/
              Positioned(
                top: 180.0,
                left: 5.0,
                child: Row(
                  children: <Widget>[

                    SizedBox(width: 2.0),
                    Text(
                      '4.0',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 4.0),
                    SelectedPhoto(
                        photoIndex: photoindex, numberOfDots: photos.length)
                  ],
                ),
              ),


            ],

          ),
          Container(
            margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(blurRadius: 2.0, color: Colors.grey)
                ]),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(25.0, 25.0, 5.0, 5.0),
                      child: Text(
                        'WELCOME to Flutter',
                        style: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(25.0, 40.0, 5.0, 25.0),
                      child: Text(
                        '1.0',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.bold,
                            fontSize: 40.0),
                      ),
                    )
                  ],
                ),
                SizedBox(width: 50.0),
                Container(
                  height: 60.0,
                  width: 125.0,
                  decoration: BoxDecoration(
                      color: Colors.greenAccent[100].withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: GestureDetector(
                    child: Center(
                      child: Text('Logout',
                          style: TextStyle(
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.bold,
                              color: Colors.green),),

                    ),
                    onTap: (){
                        FirebaseAuth.instance.signOut().then((action) {
                          Navigator
                              .of(context)
                              .pushReplacementNamed('/loginpage');
                        }).catchError((e) {
                          print(e);
                        });

                    },
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 2.0,),
          Container(
            height: 500.0,
            width: double.infinity,
            child: PageView(
              children: <Widget>[
                MyApp(),
                People()
              ],
            ),
          )
        ],

      ),
    );

  }

}
class SelectedPhoto extends StatelessWidget {
  final int numberOfDots;
  final int photoIndex;

  SelectedPhoto({this.numberOfDots, this.photoIndex});

  Widget _inactivePhoto() {
    return new Container(
        child: new Padding(
          padding: const EdgeInsets.only(left: 3.0, right: 3.0),
          child: Container(
            height: 8.0,
            width: 8.0,
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(4.0)),
          ),
        ));
  }

  Widget _activePhoto() {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 3.0, right: 3.0),
        child: Container(
          height: 10.0,
          width: 10.0,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey, spreadRadius: 0.0, blurRadius: 2.0)
              ]),
        ),
      ),
    );
  }

  List<Widget> _buildDots() {
    List<Widget> dots = [];

    for (int i = 0; i < numberOfDots; ++i) {
      dots.add(i == photoIndex ? _activePhoto() : _inactivePhoto());
    }

    return dots;
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildDots(),
      ),
    );
  }
}
