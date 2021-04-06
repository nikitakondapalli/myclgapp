import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: non_constant_identifier_names
Widget NoConnectionScreen (BuildContext context) {
  return Scaffold(
    body: Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          "assets/images/Offline.png",
          fit: BoxFit.cover,
        ),
        Positioned(
          bottom: 100,
          left: 30,
          child: FlatButton(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              onPressed: () {
                Fluttertoast.showToast(
                  toastLength: Toast.LENGTH_LONG,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  gravity: ToastGravity.TOP, msg: "Please try again",
                );
              },
              child: Row(
                children: <Widget>[
                  Text("Retry".toUpperCase(), style: TextStyle(fontSize: 15 ,color: Colors.black),),
                  SizedBox(width: 10.0,),
                  SizedBox(width: 14.0, height: 14.0,
                    child: CircularProgressIndicator(strokeWidth: 2.0,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.black26),
                    ),
                  ),
                ],
              )
          ),
        )
      ],
    ),
  );
}


