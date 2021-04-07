import 'package:connectivity/connectivity.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nnrg/Sidebar/Offline.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
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
    final screenHeight = MediaQuery.of(context).size.height;
    return isConnected
        ? Scaffold(
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              brightness: Brightness.dark,
              title: Text(
                "Contact Us..",
                style: TextStyle(fontFamily: 'Handlee', fontSize: 32),
              ),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    Colors.deepOrange.shade400,
                    Colors.pink.shade200,
                  ],
                )),
              ),
            ),
            body: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Colors.deepOrange.shade400,
                    Colors.pink.shade200
                  ])),
                ),
                Positioned(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                      Align(
                          alignment: Alignment.topRight,
                          child: Image.asset('assets/images/Contactus.png',
                              height: screenHeight * 0.45)),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32.0, vertical: 8),
                        child: Text(
                          'Can reach us at',
                          style: TextStyle(
                            fontFamily: 'Handlee',
                            fontWeight: FontWeight.w900,
                            fontSize: 29,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(32, 5, 8, 0),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              inherit: true,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w500,
                              fontSize: 19,
                              letterSpacing: 1.0,
                              color: Colors.white.withOpacity(0.8),
                            ),
                            children: <TextSpan>[
                              TextSpan(text: 'Mail-'),
                              TextSpan(
                                text: 'devifyhelp@gmail.com' '\n',
                                style: TextStyle(
                                    decoration: TextDecoration.underline),
                                recognizer: new TapGestureRecognizer()
                                  ..onTap = () async {
                                    const url =
                                        "mailto:devifyhelp@gmail.com?subject=Regards-NNRG Student App.";
                                    if (await canLaunch(url)) {
                                      await launch(url);
                                    } else {
                                      throw 'couldnt launch $url';
                                    }
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(32, 0, 8, 0),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              inherit: true,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w500,
                              fontSize: 19,
                              letterSpacing: 1.0,
                              color: Colors.white.withOpacity(0.8),
                            ),
                            children: <TextSpan>[
                              TextSpan(text: 'Instagram id-'),
                              TextSpan(
                                text: ' devifytech',
                                style: TextStyle(
                                    decoration: TextDecoration.underline),
                                recognizer: new TapGestureRecognizer()
                                  ..onTap = () async {
                                    var url =
                                        'https://www.instagram.com/devifytech';

                                    if (await canLaunch(url)) {
                                      await launch(
                                        url,
                                        universalLinksOnly: true,
                                      );
                                    } else {
                                      throw 'There was a problem to open the url: $url';
                                    }
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]))
              ],
            ))
        : NoConnectionScreen(context);
  }
}
