import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Sidebar/Home.dart';
import 'VIews/Register.dart';
import 'VIews/Verifi.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp();
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/splash.png",
            fit: BoxFit.fill,
          ),
          Positioned(
               bottom: 120,
              // right: 150,
               left: 150,
              child: Row(
                children: <Widget>[
                  SizedBox(width: 30.0, height: 30.0,
                    child: CircularProgressIndicator(strokeWidth: 2.0,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                ],
              )
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      if (user.emailVerified) {
        Future.delayed(Duration(seconds: 2), () {
          var newRoute = MaterialPageRoute(builder: (context) => Home());
          Navigator.pushAndRemoveUntil(context, newRoute, (Route<dynamic> route) => false);
        });
      } else {
        Future.delayed(Duration(seconds: 2), () {
          var newRoute = MaterialPageRoute(builder: (context) => Verifi());
          Navigator.pushReplacement(context, newRoute);
        });
      }
    } else {
      print("no user found");
      Future.delayed(Duration(seconds: 2), () {
        var newRoute = MaterialPageRoute(builder: (context) => Register());
        Navigator.pushAndRemoveUntil(context, newRoute, (Route<dynamic> route) => false);
      });
    }
  }
}