import 'package:flutter/material.dart';



class People extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Page(),
    );
  }
}

class Page extends StatefulWidget {
  @override
  _MyPage createState() => new _MyPage();
}

class _MyPage extends State<Page> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'People',
                      style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0),
                    ),
                    Text(
                      'that inspire you',
                      style: TextStyle(
                          color: Colors.blue,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0),
                    )
                  ],
                ),
              )),
          SizedBox(height: 10.0),
          GridView.count(
            crossAxisCount: 2,
            primary: false,
            crossAxisSpacing: 2.0,
            mainAxisSpacing: 4.0,
            shrinkWrap: true,
            children: <Widget>[
              _buildCard('Stan lee', 'the great', 1,"images/lee.png"),
              _buildCard('Steve jobs', 'Visionary', 2,"images/jobs.png"),
              _buildCard('Elon Musk', 'space settlement', 3,"images/musk.png"),
              _buildCard('Google dev', 'inspire', 4,"images/dev.png"),

SizedBox(height: 10.0,)
            ],
          )
        ],
      ),
    );
  }

  Widget _buildCard(String name, String status, int cardIndex,String images) {
    return Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
        ),
        elevation: 7.0,
        child: Column(
          children: <Widget>[
            SizedBox(height: 12.0),
            Stack(
                children: <Widget>[
                  Container(
                    height: 125.0,
                    width: 125.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.blueGrey,
                        image: DecorationImage(
                            image: AssetImage(images)
                        )
                    ),
                  ),

                ]),
            SizedBox(height: 8.0),
            Text(
              name,
              style: TextStyle(
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              status,
              style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                  color: Colors.grey
              ),
            ),


          ],
        ),
        margin: cardIndex.isEven? EdgeInsets.fromLTRB(10.0, 0.0, 25.0, 10.0):EdgeInsets.fromLTRB(25.0, 0.0, 5.0, 10.0)
    );
  }

}
