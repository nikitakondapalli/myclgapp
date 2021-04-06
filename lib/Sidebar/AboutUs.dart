import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/Helpers/Helpers.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

class AboutUs extends StatefulWidget {
  AboutUs({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  final pages = [

    Expanded(
      child: Container(
        //color: Colors.white,
        color:Color(0xFF6A4B5F),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Image.asset("assets/images/About1.png",
                width: 700.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Developer", style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Raleway',
                    color: Color(0xFFA1B6CC),
                  ),
                  ),
                  Text("Nikita Kondapalli", style: TextStyle(
                      fontSize: 30.0,
                      color: Color(0xFF888C76),
                      fontFamily: "Raleway",
                      fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),



    Expanded(
      child: Container(
        color: Color(0xFF847D5F),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Image.asset("assets/images/About2.png",
                width: 700.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Co-Developer", style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: "Raleway",
                    color: Color(0xFFA1B6CC),
                  ),
                  ),
                  Text("Meghana Arikilla", style: TextStyle(
                      fontSize: 30.0,
                      color: Color(0xFFE8BB57),
                      fontFamily: "Raleway",
                      fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),

    Expanded(
      child: Container(
        color: Color(0xFF4E71A6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Image.asset("assets/images/About3.png", width: 700.0),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Content Writer", style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: "Raleway",
                    color: Color(0xFFA1B6CC),
                  ),
                  ),

                  Text("Girish Naidu", style: TextStyle(
                      fontSize: 30.0,
                      color: Color(0xFF888C76),
                      fontFamily: "Raleway",
                      fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),

    Expanded(
      child: Container(
        color: Color(0xFF21323D),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Image.asset("assets/images/About4.png", width: 700.0),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Content Writer", style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: "Raleway",
                    color: Color(0xFFA1B6CC),
                  ),
                  ),

                  Text("Anudeep Singh", style: TextStyle(
                      fontSize: 30.0,
                      color: Color(0xFF888C76),
                      fontFamily: "Raleway",
                      fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),

  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LiquidSwipe(
          pages: pages,
          enableLoop: true,
          fullTransitionValue: 600,
          enableSlideIcon: true,
          waveType: WaveType.liquidReveal,
        ),
      ),
    );
  }
}