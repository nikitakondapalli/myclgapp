import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nnrg/Sidebar/Offline.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;

TextEditingController editController = TextEditingController();

class _ForgotPasswordState extends State<ForgotPassword> {
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
    return isConnected
        ? GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: Color(0xff161730),
              appBar: AppBar(
                centerTitle: true,
                elevation: 0,
                backgroundColor: Color(0xff161730),
                title: Text(
                  "Forgot Password?",
                  style: TextStyle(fontFamily: 'Raleway', color: Colors.white),
                ),
              ),
              body: Container(
                padding: EdgeInsets.symmetric(horizontal: 19),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Reset Your Password",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Enter your email to receive \n a reset link",
                              style: TextStyle(
                                color: Colors.white70,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Form(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 25,
                            ),
                            TextFormField(
                              controller: editController,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(color: Colors.grey),
                                labelText: "Email",
                                hintText: "Enter your email",
                                hintStyle: TextStyle(color: Colors.white70),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 42, vertical: 20),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(28),
                                    borderSide: BorderSide(color: Colors.white),
                                    gapPadding: 10),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(28),
                                    borderSide: BorderSide(color: Colors.white),
                                    gapPadding: 10),
                                suffixIcon: Icon(
                                  Icons.mail_outline,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 37,
                            ),
                            GestureDetector(
                              onTap: () {
                                HapticFeedback.heavyImpact();
                                sendresetlink();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                margin: EdgeInsets.symmetric(horizontal: 25),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    gradient: LinearGradient(
                                      colors: [
                                        const Color(0xff8636F5),
                                        const Color(0xff0089FF)
                                      ],
                                    )),
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: Text(
                                    "Reset password",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Raleway',
                                        fontSize: 16),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : NoConnectionScreen(context);
  }

  void sendresetlink() {
    bool error = false;
    var useremail = editController.text;
    FirebaseAuth.instance
        .sendPasswordResetEmail(email: useremail)
        .catchError((e) {
      setState(() {
        error = true;
      });
      print(e.message.toString() +
          "  eeeeeeeeeeeeerrrrrrrrrrrrrrrrroooooooooooooooorrrrrrrrrrrrr");
      Fluttertoast.showToast(
        toastLength: Toast.LENGTH_LONG,
        msg: e.message.toString(),
        backgroundColor: Colors.white,
        textColor: Colors.black,
        gravity: ToastGravity.CENTER,
      );
    }).then((value) {
      Future.delayed(Duration(milliseconds: 700), () {
        if (error) {
          return;
        } else {
          print(
              "oooooooooooooooooooooooooooookkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
          Fluttertoast.showToast(
            toastLength: Toast.LENGTH_LONG,
            msg:
                "A reset password link has been sent to your mail. Please use it to change the password.",
            backgroundColor: Colors.white,
            textColor: Colors.black,
            gravity: ToastGravity.TOP,
          );
          Navigator.pop(context);
        }
      });
    });
  }
}
