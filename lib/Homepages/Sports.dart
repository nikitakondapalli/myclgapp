import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:nnrg/Sidebar/Offline.dart';
import 'package:url_launcher/url_launcher.dart';

class SportsDetails extends StatefulWidget {
  final heroTag;
  final foodName;
  final foodPrice;

  SportsDetails({this.heroTag, this.foodName, this.foodPrice});

  @override
  _ExamDetailsState createState() => _ExamDetailsState();
}

class _ExamDetailsState extends State<SportsDetails> {
  var selectedCard = 'WEIGHT';

  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print(' could not launch $command');
    }
  }

  bool isConnected = true;

  Future checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      setState(() {
        isConnected = true;
      });
    } else {
      setState(() {
        isConnected = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return  isConnected ?  Scaffold(
      backgroundColor: Color(0xFF7A9BEE),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        brightness: Brightness.dark,
        elevation: 0.0,
        title: Text('Details', style: TextStyle(
            fontFamily: "Handlee",
            fontSize: 27.0,
            color: Colors.white)),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height +385,
          width: MediaQuery.of(context).size.width,
          child: Stack(overflow: Overflow.visible, children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
            ),
            Positioned(
                top: 75.0,
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(45.0),
                          topRight: Radius.circular(45.0),
                        ),
                        color: Colors.white),
                    height: MediaQuery.of(context).size.height +385,
                    width: MediaQuery.of(context).size.width)),
            Positioned(
                top: 10.0,
                left: (MediaQuery.of(context).size.width / 2) - 100.0,
                child: Hero(
                    tag: widget.heroTag,
                    child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(widget.heroTag),
                                fit: BoxFit.cover)),
                        height: 220.0,
                        width: 200.0))),
            Positioned(
                top: 250.0,
                left: 25.0,
                right: 25.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(widget.foodName, style: TextStyle(
                        fontFamily: "Raleway",
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold)),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(widget.foodPrice, style: TextStyle(
                            fontFamily: "Raleway",
                            fontSize: 20.0,
                            color: Colors.grey)),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    SizedBox(height: 10.0),
                    Text("NNRG is not confined to academics. Our endeavor is to aid in the overall development and achievements of our students. This includes physical fitness, mental ability, team spirit and the discipline required to work towards a goal. ",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Raleway",
                          letterSpacing: 1.0),
                    ),
                    SizedBox(height: 20,),
                    Divider(color: Colors.black26,
                      height: 5.0,
                    ),
                    SizedBox(height: 10,),

                    Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Vijay Kumar",
                                      style: TextStyle(
                                          color: Colors.black87.withOpacity(0.7),
                                          fontSize: 20,fontFamily: 'Raleway'),
                                    ),
                                    SizedBox(height: 5,),
                                    Container(
                                        width: MediaQuery.of(context).size.width - 268,
                                        child: Text("Physical Director""\n"
                                            "\n" "B.Sc, B.Ed, M.A, M.P.Ed, UGC-NET, TS-SET, (Ph.D)",
                                          style: TextStyle(color: Colors.black45,fontFamily: 'SourceSansPro'),
                                        ))
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                        Expanded(child: Image.asset("assets/images/Sports.png", width: 10,))
                      ],
                    ),
                    SizedBox(height: 5,),
                    Divider(color: Colors.transparent, height: 5.0,),
                    Text("Contact", style: TextStyle(
                        color: Color(0xff242424),
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Raleway"),
                    ),
                    SizedBox(height: 20,),

                    Row(
                      children: [
                        InkWell(
                          child: GestureDetector(
                            onTap: () {
                              customLaunch("mailto:vijayvijay.vakiti@gmail.com?");
                            },
                            child: Container(
                              width: 120,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Color(0xFF346AEA),
                                  borderRadius: BorderRadius.circular(18)
                              ),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Align(
                                      child: Text("Email", style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Raleway"
                                      ),),
                                    ),
                                  ),
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.white38,
                                        borderRadius: BorderRadius.circular(14)
                                    ),
                                    child: Icon(Icons.mail_outline, color: Colors.white,),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16,),

                        InkWell(
                          child: GestureDetector(
                            onTap: () {
                              customLaunch('tel:8297839956');
                            },
                            child: Container(
                              width: 120,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(18)
                              ),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Align(
                                      child: Text("Call", style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Raleway"
                                      ),),
                                    ),
                                  ),
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(14)
                                    ),
                                    child: Icon(Icons.call, color: Colors.white,),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Container(
                      child: Text(""
                      ),
                    ),
                  ],
                )),
          ]
          ),
        ),
      ),
    )
        :   NoConnectionScreen(context);
  }
}
