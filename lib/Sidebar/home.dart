import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nnrg/HomePages/Dictionary.dart';
import 'package:nnrg/HomePages/ExamInfo.dart';
import 'package:nnrg/HomePages/Placements.dart';
import 'package:nnrg/HomePages/Sports.dart';
import 'package:nnrg/Homepages/Admissions.dart';
import 'package:nnrg/Sidebar/AboutUs.dart';
import 'package:nnrg/Sidebar/Alertdialog.dart';
import 'package:nnrg/Sidebar/Anti2.dart';
import 'package:nnrg/Sidebar/ContactUs.dart';
import 'package:nnrg/Sidebar/Contest.dart';
import 'package:nnrg/Sidebar/Feedback.dart';
import 'package:nnrg/Sidebar/Logoutalert.dart';
import 'package:nnrg/Sidebar/Notifications.dart';
import 'package:nnrg/main.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Offline.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Future<bool> _onBackPressed() {
    return showDialog(context: context, builder: (context) => ExitConfirmationDialog());
  }

  Future<bool> onlogoutpress() {
    return showDialog(context: context, builder: (context) => LogoutDialog()
    );
  }

  String useruid="";
  void sendtoregpage() {
    var newRoute=MaterialPageRoute(builder: (context)=> SplashScreen());
    Navigator.pushReplacement(context, newRoute);
  }

  Future<void> getpresentuseruid() async {
    // ignore: await_only_futures
    var tempid= await FirebaseAuth.instance.currentUser.uid;
    setState(() {
      useruid= tempid;
    });
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
    checkConnectivity();
    if (isConnected) {
      return WillPopScope(
        onWillPop: _onBackPressed,
        child:  Scaffold(
            backgroundColor:Color(0xFF3B657E),
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(context, new MaterialPageRoute(
                        builder: (BuildContext context) => Notifications()));
                  },
                  icon: Icon(Icons.notifications_active),
                  color: Colors.white, iconSize: 26,
                ),
              ],
              leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    iconSize: 31,
                    icon: const Icon(Icons.sort),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                  );
                },
              ),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              brightness: Brightness.light,
            ),

            drawer: new Drawer(
              elevation: 10.0,
              child: new ListView(
                children: <Widget>[
                  new UserAccountsDrawerHeader(
                    accountName: new Text("NNRG", style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Raleway',
                        fontSize: 12.0
                    ),),
                    accountEmail: new Text("${FirebaseAuth.instance.currentUser.email}", style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Raleway'
                    )),
                    decoration: new BoxDecoration(
                        image: new DecorationImage(
                            fit: BoxFit.fill,
                            image:  AssetImage('assets/images/drawerbg.png'))),
                  ),
                  new ListTile(
                    leading: Icon(Icons.home),
                    title: new Text('Home',
                      style: new TextStyle(color: Colors.black,
                          fontFamily: 'Raleway', fontSize: 20.0),),
                    onTap: () {
                      Navigator.push(context, new MaterialPageRoute(
                          builder: (BuildContext context) => new Home()));
                    },
                  ),

                  Divider(color: Colors.grey, height: 5.0,),
                  new ListTile(
                    leading: Icon(Icons.notifications_active),
                    title: new Text('Notifications',
                      style: new TextStyle(color: Colors.black,
                          fontFamily: 'Raleway', fontSize: 20.0),),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.push(context, new MaterialPageRoute(
                          builder: (BuildContext context) => new Notifications()));
                    },
                  ),

                  Divider(color: Colors.grey, height: 5.0,),
                  new ListTile(
                    leading: Icon(Icons.not_interested),
                    title: new Text('Anti Ragging',
                      style: new TextStyle(color: Colors.black,
                          fontFamily: 'Raleway', fontSize: 20.0),),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.push(context, new MaterialPageRoute(
                          builder: (BuildContext context) => new Anti2()));
                    },
                  ),

                  Divider(color: Colors.grey, height: 5.0,),
                  new ListTile(
                    leading: Icon(Icons.camera_alt),
                    title: new Text('Contest',
                      style: new TextStyle(color: Colors.black,
                          fontFamily: 'Raleway', fontSize: 20.0),),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.push(context, new MaterialPageRoute(
                          builder: (BuildContext context) => new Contest()));
                    },
                  ),

                  Divider(color: Colors.grey, height: 5.0,),
                  new ListTile(
                    leading: Icon(Icons.people),
                    title: new Text('About Us',
                      style: new TextStyle(color: Colors.black,
                          fontFamily: 'Raleway', fontSize: 20.0),),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.push(context, new MaterialPageRoute(
                          builder: (BuildContext context) => new AboutUs()));
                    },
                  ),

                  Divider(color: Colors.grey, height: 5.0,),
                  new ListTile(
                    leading: Icon(Icons.library_books),
                    title: new Text('Privacy Policy',
                      style: new TextStyle(color: Colors.black,
                          fontFamily: 'Raleway', fontSize: 20.0),),
                    onTap: ()  async {
                      const url = 'https://nnrgconfession.web.app';
                      if(await canLaunch(url)){
                        await launch(url);
                      } else {
                        Fluttertoast.showToast(
                          toastLength: Toast.LENGTH_LONG,
                          msg: "couldnt launch Browser$url",
                          backgroundColor: Colors.white,
                          textColor: Colors.black54,
                          gravity: ToastGravity.CENTER,
                        );
                      }
                    },
                  ),

                  Divider(color: Colors.grey, height: 5.0,),
                  new ListTile(
                    leading: Icon(Icons.contact_mail),
                    title: new Text('Contact Us',
                      style: new TextStyle(color: Colors.black,
                          fontFamily: 'Raleway', fontSize: 20.0),),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.push(context, new MaterialPageRoute(
                          builder: (BuildContext context) => new ContactUs()));
                    },
                  ),

                  Divider(color: Colors.grey, height: 5.0,),
                  new ListTile(
                    leading: Icon(Icons.feedback),
                    title: new Text('Feedback',
                      style: new TextStyle(color: Colors.black,
                          fontFamily: 'Raleway', fontSize: 20.0),),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.push(context, new MaterialPageRoute(
                          builder: (BuildContext context) => new Review()));
                    },
                  ),

                  Divider(color: Colors.grey, height: 5.0,),
                  new ListTile(
                    leading: Icon(Icons.star_half),
                    title: new Text('Rate Us',
                      style: new TextStyle(color: Colors.black,
                          fontFamily: 'Raleway', fontSize: 20.0),),
                    onTap: () async {
                      const url = 'https://play.google.com/store/apps/details?id=com.clg.nnrg&hl=en_US&gl=US';
                      if(await canLaunch(url)){
                        await launch(url);
                      } else {
                        Fluttertoast.showToast(
                          toastLength: Toast.LENGTH_LONG,
                          msg: "couldnt launch PlayStore $url",
                          backgroundColor: Colors.white,
                          textColor: Colors.black54,
                          gravity: ToastGravity.CENTER,
                        );
                      }
                    },
                  ),

                  Divider(color: Colors.grey, height: 5.0,),
                  new ListTile(
                    leading: Icon(Icons.exit_to_app, color: Colors.blueAccent,),
                    title: new Text('Log Out',
                      style: new TextStyle(color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Raleway', fontSize: 20.0),),
                    onTap: () {
                      onlogoutpress();
                    },
                  ),
                ],
              ),
            ),

            body:  Container(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 25.0),
                  Padding(
                    padding: EdgeInsets.only(left: 40.0),
                    child: Row(
                      children: <Widget>[
                        Text('Hey!', style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Handlee',
                            fontSize: 25.0)),
                        SizedBox(width: 10.0),
                        Text('Welcome', style: TextStyle(
                            fontFamily: 'Raleway',
                            color: Colors.white,
                            fontSize: 25.0))
                      ],
                    ),
                  ),
                  SizedBox(height: 40.0),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0)),
                      ),
                      child: Padding(
                          padding: EdgeInsets.only(top: 45.0),
                          child: Container(
                              child: ListView(children: [
                                _buildDictionary('assets/images/home1.png', 'Dictionary', 'Improve your wording skills'),
                                _buildExamInfo('assets/images/home2.png', 'Exam Info', 'Get updates about exam'),
                                _buildPlacements('assets/images/home3.png', 'Placements', 'About training and placements'),
                                _buildSports('assets/images/home4.png', 'Sports', 'Get updates on all sports events'),
                                _buildAdmision('assets/images/home5.png', 'Admission', 'Know about admission process')
                              ]))),
                    ),
                  ),
                ],
              ),
            )
        ),
      );
    } else {
      return NoConnectionScreen(context);
    }
  }



  Widget _buildDictionary(String imgPath, String foodName, String price) {
    return Padding(
        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Dictionary()
              ));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    child: Row(
                        children: [
                          Hero(
                              tag: imgPath,
                              child: Image(
                                  image: AssetImage(imgPath),
                                  fit: BoxFit.cover,
                                  height: 75.0,
                                  width: 75.0
                              )
                          ),
                          SizedBox(width: 10.0),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:[
                                Text(
                                    foodName,
                                    style: TextStyle(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.bold,

                                    )
                                ),
                                Text(
                                    price,
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.grey,

                                    )
                                )
                              ]
                          )
                        ]
                    )
                ),
              ],
            )
        ));
  }

  Widget _buildExamInfo(String imgPath, String foodName, String price) {
    return Padding(
        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ExamDetails(heroTag: imgPath, foodName: foodName, foodPrice: price)));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    child: Row(
                        children: [
                          Hero(tag: imgPath,
                              child: Image(image: AssetImage(imgPath),
                                  fit: BoxFit.cover,
                                  height: 75.0,
                                  width: 75.0
                              )
                          ),
                          SizedBox(width: 10.0),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:[
                                Text(foodName, style: TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold,

                                )
                                ),
                                Text(price, style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.grey,

                                )
                                )
                              ]
                          )
                        ]
                    )
                ),
              ],
            )
        ));
  }

  Widget _buildPlacements(String imgPath, String foodName, String price) {
    return Padding(
        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Placements()));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    child: Row(
                        children: [
                          Hero(tag: imgPath,
                              child: Image(image: AssetImage(imgPath),
                                  fit: BoxFit.cover,
                                  height: 75.0,
                                  width: 75.0
                              )
                          ),
                          SizedBox(width: 10.0),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:[
                                Text(foodName, style: TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold,

                                )
                                ),
                                Text(price, style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.grey,

                                )
                                )
                              ]
                          )
                        ]
                    )
                ),
              ],
            )
        ));
  }

  Widget _buildSports(String imgPath, String foodName, String price) {
    return Padding(
        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SportsDetails(heroTag: imgPath, foodName: foodName, foodPrice: price)));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    child: Row(
                        children: [
                          Hero(tag: imgPath,
                              child: Image(image: AssetImage(imgPath),
                                  fit: BoxFit.cover,
                                  height: 75.0,
                                  width: 75.0
                              )
                          ),
                          SizedBox(width: 10.0),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:[
                                Text(foodName, style: TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold,

                                )
                                ),
                                Text(price, style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.grey,

                                )
                                )
                              ]
                          )
                        ]
                    )
                ),
              ],
            )
        ));
  }

  Widget _buildAdmision(String imgPath, String foodName, String price) {
    return Padding(
        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Admission(heroTag: imgPath, foodName: foodName, foodPrice: price)));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    child: Row(
                        children: [
                          Hero(tag: imgPath,
                              child: Image(image: AssetImage(imgPath),
                                  fit: BoxFit.cover,
                                  height: 75.0,
                                  width: 75.0
                              )
                          ),
                          SizedBox(width: 10.0),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:[
                                Text(foodName, style: TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold,
                                )
                                ),
                                Text(price, style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.grey,
                                )
                                )
                              ]
                          )
                        ]
                    )
                ),
              ],
            )
        ));
  }

}
