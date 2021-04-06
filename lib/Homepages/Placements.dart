import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:nnrg/Sidebar/Offline.dart';
import 'package:url_launcher/url_launcher.dart';

class Placements extends StatefulWidget {
  @override
  _PlacementsState createState() => _PlacementsState();
}

class _PlacementsState extends State<Placements> {

  bool isConnected = true;
  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print(' could not launch $command');
    }
  }

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
    checkConnectivity();
    return isConnected ? Scaffold(
        appBar: AppBar(
          title: Text('Details', style: TextStyle(
              fontFamily: "Handlee",
              fontSize: 27.0,
              color: Colors.black)),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          brightness: Brightness.light,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              );
            },
          ),
        ),

        body:  SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(child: Image.asset("assets/images/placements1.png", height: 220)),
                    SizedBox(width: 20,),
                    Container(
                      width: MediaQuery.of(context).size.width - 222,
                      height: 220,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("THIGULLA SAMPATH REDDY",
                            style: TextStyle(
                                fontFamily: "Raleway",
                                fontSize: 19),
                          ),
                          Text("Corporate Relations Officer",
                            style: TextStyle(
                                fontFamily: "SourceSansPro",
                                fontSize: 12, color: Colors.black45),
                          ),
                          //SizedBox(height: 36,),
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    customLaunch(
                                        "mailto:cro@nnrg.edu.in?");
                                  },
                                  child: IconTile(
                                    backColor: Color(0xffFFECDD),
                                    imgAssetPath: "assets/images/email.png",
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    customLaunch('tel:+919885294438');
                                  },
                                  child: IconTile(
                                    backColor: Color(0xffFEF2F0),
                                    imgAssetPath: "assets/images/call.png",
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Text("About", style: TextStyle(
                    fontSize: 22,fontFamily: 'Raleway'),
                ),
                SizedBox(height: 16,),
                Text("Mr. Sampath Reddy Thigulla is creative and highly result oriented engineering professional who brings "
                    "along Industrial experience and International exposure to bridge the gap between academia and Industry.",
                  style: TextStyle(
                      color: Colors.black45,
                      fontSize: 15,fontFamily: 'SourceSansPro'),
                ),
                Text("Worked in IT for around five years with one year in India and around four years in USA.",
                  style: TextStyle(color: Colors.black45, fontSize: 15,fontFamily: 'SourceSansPro'),
                ),
                SizedBox(height: 20,),
                Divider(color: Colors.black26, height: 5.0,),
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
                                Text("Mr. K. Sreekanth",
                                  style: TextStyle(
                                      color: Colors.black87.withOpacity(0.7),
                                      fontSize: 20,fontFamily: 'Raleway'),
                                ),
                                SizedBox(height: 5,),
                                Container(
                                    width: MediaQuery.of(context).size.width - 268,
                                    child: Text("Associate Professor & Training and Placement Officer,""\n"
                                        "\n""B.Tech, M.Tech, MIEEE, LMISTE",
                                      style: TextStyle(color: Colors.black45,fontFamily: 'SourceSansPro'),
                                    ))
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    Expanded(child: Image.asset("assets/images/placements2.png", width: 10,))
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
                          customLaunch("mailto:tpo@nnrg.edu.in?");
                        },
                        child: Container(
                          width: 120,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Color(0xffFBB97C),
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
                          customLaunch('tel:+91 9885294438');
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
                )
              ],
            ),
          ),
        )
    )
        :   NoConnectionScreen(context);
  }
}

class IconTile extends StatelessWidget {
  final String imgAssetPath;
  final Color backColor;

  IconTile({this.imgAssetPath, this.backColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      child: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
            color: backColor, borderRadius: BorderRadius.circular(15)),
        child: Image.asset(
          imgAssetPath,
          width: 20,
        ),
      ),
    );
  }
}
