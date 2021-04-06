import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:nnrg/Sidebar/Offline.dart';
import 'package:nnrg/Sidebar/Home.dart';

class Verifi extends StatefulWidget {
  @override
  _VerifiState createState() => _VerifiState();
}

class _VerifiState extends State<Verifi> {

  String jhdgsj="";
  String animationa="Jump";
  bool timer=false;
  String timecount="TEN";
  bool verified=false;

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
    return  isConnected ? Scaffold(
      backgroundColor:Color(0xff151F2B),
      body: Column(
        children: [
          SizedBox(height: 90,),
          Center(child:
          Container(
              height: 200,
              width: MediaQuery.of(context).size.width/1.5,
              child:verified? FlareActor("assets/images/verified.flr",animation: jhdgsj)
                  :FlareActor("assets/images/mail.flr",animation: animationa,))
          ),
          SizedBox(height: 30,),
          Center(child: Text("Hello, Thank you for registering",style: TextStyle(color: Colors.white,fontSize: 23,fontFamily: 'Handlee',),)),
          Center(child: Text("we have sent an email..",style: TextStyle(color: Colors.white,fontSize: 23,fontFamily: 'Handlee',),)),
          Center(child: Text("Please check your inbox and verify.",style: TextStyle(color: Colors.white,fontSize: 23,fontFamily: 'Handlee',),)),
          SizedBox(height: 35,),
          timer?CupertinoButton(child: Text("Resend Verification Link"), onPressed: (){
            FirebaseAuth.instance.currentUser.sendEmailVerification();
            Fluttertoast.showToast(
              msg:"Verification link sent ",
              toastLength: Toast.LENGTH_LONG,
              backgroundColor: Colors.white,
              textColor: Colors.black,
              gravity: ToastGravity.BOTTOM,
            );})
              :Container(
              decoration: BoxDecoration(
                  color: Color(0xff0E1111),
                  borderRadius: BorderRadius.circular(50)
              ),
              height: 80,
              width: 180,
              child: Center(child: Text(timecount,style: TextStyle(
                  color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold,letterSpacing: 1),))),
        ],
      ),
    )
        :   NoConnectionScreen(context);
  }

  void checkemail(){
    checkstart();
  }

  void goto(){
    setState(() {
      verified=true;
      jhdgsj="verified";
    });

    Future.delayed(Duration(seconds: 2),(){
      var dkb = MaterialPageRoute(builder: (context) => Home());
      Navigator.pushAndRemoveUntil(context, dkb, (Route<dynamic> route) => false);
      });
  }

  void checkstart(){
    Future.delayed(Duration(seconds: 2),(){
      FirebaseAuth.instance.currentUser.reload().then((value) => {
        if( FirebaseAuth.instance.currentUser.emailVerified){
          goto()
        } else {
          checkemail()
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    checkemail();
    count();
    eight();
    seven();
    six();
    five();
    four();
    three();
    two();
    one();
    togglewidgets();
  }

  void count(){
    Future.delayed(Duration(seconds: 1),(){
      setState(() {
        timecount="NINE";
      });
    });
  }

  void eight(){
    Future.delayed(Duration(seconds: 2),(){
      setState(() {
        animationa="nll";
        timecount="EIGHT";
      });
    });
  }

  void seven(){
    Future.delayed(Duration(seconds: 3),(){
      setState(() {
        timecount="SEVEN";
      });
    });
  }

  void six(){
    Future.delayed(Duration(seconds: 4),(){
      setState(() {
        timecount="SIX";
      });
    });
  }

  void five(){
    Future.delayed(Duration(seconds: 5),(){
      setState(() {
        timecount="FIVE";
      });
    });
  }

  void four(){
    Future.delayed(Duration(seconds: 6),(){
      setState(() {
        timecount="FOUR";
      });
    });
  }

  void three(){
    Future.delayed(Duration(seconds: 7),(){
      setState(() {
        timecount="THREE";
      });
    });
  }

  void two(){
    Future.delayed(Duration(seconds: 8),(){
      setState(() {
        timecount="TWO";
      });
    });
  }

  void one(){
    Future.delayed(Duration(seconds: 9),(){
      setState(() {
        timecount="ONE";
      });
    });
  }

  void togglewidgets(){
    Future.delayed(Duration(seconds: 10),(){
      setState(() {
        timer=true;
      });
    });
  }

}
