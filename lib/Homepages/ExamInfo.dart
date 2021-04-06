import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:nnrg/Sidebar/Offline.dart';
import 'package:url_launcher/url_launcher.dart';

class ExamDetails extends StatefulWidget {
  final heroTag;
  final foodName;
  final foodPrice;

  ExamDetails({this.heroTag, this.foodName, this.foodPrice});

  @override
  _ExamDetailsState createState() => _ExamDetailsState();
}

class _ExamDetailsState extends State<ExamDetails> {
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
    return  isConnected ? Scaffold(
      backgroundColor: Color(0xFF7A9BEE),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        brightness: Brightness.dark,
        elevation: 0.0,
        title: Text('Details',
            style: TextStyle(
                fontFamily: "Handlee", fontSize: 27.0, color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height +35,
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
                    height: MediaQuery.of(context).size.height + 150,
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
                    Text(widget.foodName,
                        style: TextStyle(
                            fontFamily: "Raleway",
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(widget.foodPrice,
                            style: TextStyle(
                                fontFamily: "Raleway",
                                fontSize: 20.0,
                                color: Colors.grey)),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    SizedBox(height: 10.0),
                    Text("Announcement of academic schedules, Preparation of question papers, Conduction of examinations, Evaluation of answer scripts, Declaration of results and issuing of grade sheets.",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Raleway",
                          letterSpacing: 1.0),
                    ),
                    SizedBox(height: 20,),
                    Divider(
                      color: Colors.black26,
                      height: 5.0,
                    ),
                    SizedBox(height: 10,),
                    Text("Contact", style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Raleway"),
                    ),
                    SizedBox(height: 12,),
                    Text("Superintendent of Examinations", style: TextStyle(
                        fontSize: 18,
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                        fontFamily: "SourceSansPro"),
                    ),
                    SizedBox(height: 12,),
                    Text("Shailender Reddy",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black45,
                          fontFamily: "Raleway"),
                    ),
                    SizedBox(height: 12,),
                    Container(
                      color: Colors.white,
                      child: Row(
                        children: [
                          InkWell(
                            child: GestureDetector(
                              onTap: () {
                                customLaunch("mailto:examcenter@nnrg.edu.in?");
                              },
                              child: Container(width: 120, height: 40,
                                decoration: BoxDecoration(
                                    color: Color(0xFF346AEA),
                                    borderRadius: BorderRadius.circular(18)),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Align(
                                        child: Text("Email", style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Raleway"),
                                        ),
                                      ),
                                    ),
                                    Container(width: 50, height: 50,
                                      decoration: BoxDecoration(
                                          color: Color(0xFF7A9BEE),
                                          borderRadius:
                                          BorderRadius.circular(14)),
                                      child: Icon(Icons.mail_outline,
                                        color: Colors.white,
                                      ),
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
                                customLaunch('tel:9966378279');
                              },
                              child: Container(width: 120, height: 40,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(18)),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Align(
                                        child: Text("Call", style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Raleway"),
                                        ),
                                      ),
                                    ),
                                    Container(width: 50, height: 50,
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                          BorderRadius.circular(14)),
                                      child: Icon(Icons.call,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ]),
        ),
      ),
    )
        :   NoConnectionScreen(context);
  }
}
