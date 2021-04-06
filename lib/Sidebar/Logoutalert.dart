import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../main.dart';

// ignore: must_be_immutable
class LogoutDialog extends StatefulWidget {
  @override
  _LogoutDialogState createState() => _LogoutDialogState();
}

class _LogoutDialogState extends State<LogoutDialog> {
  String useruid="";

  void sendtoregpage() {
    var newRoute=MaterialPageRoute(builder: (context)=> SplashScreen());
    Navigator.pushReplacement(context, newRoute);
  }

  void sendout(){
    FirebaseAuth.instance.signOut().then((value) => {
      sendtoregpage()});
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildChild(context),
    );
  }

  _buildChild(BuildContext context) => Container(
    height: 230,
    decoration: BoxDecoration(
        color: Color(0xFF323434),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(16))
    ),

    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text('Logout out of', style: TextStyle(
            fontFamily: 'Handlee',
            fontSize: 26,
            color: Colors.white,
            letterSpacing: 1.2,
            fontWeight: FontWeight.bold),),
        Center(
          child: Text('NNRG?', style: TextStyle(
              fontFamily: 'Handlee',
              fontSize: 22,
              color: Colors.white,
              letterSpacing: 1.2,
              fontWeight: FontWeight.bold),),
        ),
        SizedBox(height: 38,),
        Divider(color: Colors.white12, height: 2.5,),

        Column(
          children: <Widget>[

            FlatButton(
              onPressed: () => sendout(),
              child: Text('Log Out', style: TextStyle(fontSize: 20),),
              textColor: Colors.blueAccent,
            ),
            SizedBox(width: 8,),
            Divider(color: Colors.white12, height: 2.5,),

            FlatButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text('Cancel', style: TextStyle(fontSize: 20),),
              textColor: Colors.white,
            )
          ],
        )
      ],
    ),
  );
}