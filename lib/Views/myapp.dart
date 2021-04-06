import 'package:flutter/material.dart';
import 'package:nnrg/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AfterSplash extends StatefulWidget {
  _AfterSplashState createState() => _AfterSplashState();
}

class _AfterSplashState extends State<AfterSplash> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      var newRoute=MaterialPageRoute(builder: (context)=> SplashScreen());
      Navigator.pushReplacement(context, newRoute);
    } else {
      prefs.setBool('seen', true);
      Navigator.pushReplacementNamed(context, 'intro');
    }
  }

  @override
  void initState() {
    super.initState();
    checkFirstSeen();
  }

  @override
  Widget build(BuildContext context) {
    return Offstage(child: null);
  }
}
