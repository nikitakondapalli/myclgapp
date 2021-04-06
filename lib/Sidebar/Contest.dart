import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'Offline.dart';


class Contest extends StatefulWidget {

  @override
  _ContestState createState() => _ContestState();
}

class _ContestState extends State<Contest> {

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
    return  isConnected ?  Scaffold(
        body:Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              decoration: new BoxDecoration(
                  image: new DecorationImage(image: AssetImage('assets/images/Contest.png'),
                      fit: BoxFit.fill)),
            )
          ],
        )
    )
        :   NoConnectionScreen(context);
  }
}