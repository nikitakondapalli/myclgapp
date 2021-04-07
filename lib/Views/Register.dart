import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nnrg/Sidebar/Offline.dart';
import 'package:nnrg/VIews/Login.dart';
import 'package:nnrg/VIews/Verifi.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();

  bool isLoading = false;
  bool _obscureText = true;
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
                title: Center(
                    child: Text(
                  "Sign Up",
                  style: TextStyle(fontFamily: 'Raleway', color: Colors.white),
                )),
              ),
              body: isLoading
                  ? Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.symmetric(horizontal: 24),
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
                                    "Create Account",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    "Fill up your details to get started \n with NNRG App",
                                    style: TextStyle(
                                      color: Colors.white70,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 60,
                            ),
                            Theme(
                              data: new ThemeData(
                                primaryColor: Colors.green,
                                primaryColorDark: Colors.red,
                              ),
                              child: Form(
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: emailTextEditingController,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                      validator: (val) {
                                        return RegExp(
                                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                .hasMatch(val)
                                            ? null
                                            : "Please enter correct email";
                                      },
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        labelStyle:
                                            TextStyle(color: Colors.grey),
                                        labelText: "Email",
                                        hintText: "Enter your email",
                                        hintStyle:
                                            TextStyle(color: Colors.white70),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 42, vertical: 20),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(28),
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                            gapPadding: 10),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(28),
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                            gapPadding: 10),
                                        suffixIcon: Icon(
                                          Icons.mail_outline,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    TextFormField(
                                      obscureText: _obscureText,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                      controller: passwordTextEditingController,
                                      decoration: InputDecoration(
                                        labelStyle:
                                            TextStyle(color: Colors.grey),
                                        labelText: "Password",
                                        hintText: "Enter password",
                                        hintStyle:
                                            TextStyle(color: Colors.white70),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 42, vertical: 20),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(28),
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                            gapPadding: 10),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(28),
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                            gapPadding: 10),
                                        suffixIcon: IconButton(
                                          icon: Icon(_obscureText
                                              ? Icons.visibility
                                              : Icons.visibility_off),
                                          color: this._obscureText
                                              ? Colors.grey
                                              : Colors.redAccent,
                                          onPressed: () {
                                            setState(() {
                                              _obscureText = !_obscureText;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 35,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isLoading = true;
                                });
                                createuserwithemailandpassword();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    gradient: LinearGradient(
                                      colors: [
                                        const Color(0xff8636F5),
                                        const Color(0xff0089FF)
                                      ],
                                    )),
                                width: MediaQuery.of(context).size.width,
                                child: Text(
                                  "Create Account",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontFamily: 'Raleway'),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 19,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have an account? ",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: 'Raleway'),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    var route = MaterialPageRoute(
                                        builder: (context) => Login());
                                    Navigator.push(context, route);
                                  },
                                  child: Text(
                                    "Sign In",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: 'Raleway',
                                        decoration: TextDecoration.underline),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 50,
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          )
        : NoConnectionScreen(context);
  }

  signUp() async {
    try {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailTextEditingController.text,
              password: passwordTextEditingController.text)
          .then((value) => {
                value.user
                    .sendEmailVerification()
                    .then((value) => changescreen())
              });
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      print(e.message.toString() +
          "...........................................................................................");
      Fluttertoast.showToast(
        toastLength: Toast.LENGTH_LONG,
        msg: "$e",
        backgroundColor: Colors.white,
        textColor: Colors.black,
        gravity: ToastGravity.BOTTOM,
      );
      return null;
    }
    print(emailTextEditingController.text);
  }

  void sendemail() {
    FirebaseAuth.instance.currentUser
        .sendEmailVerification()
        .then((value) => {changescreen()});
  }

  Future createuserwithemailandpassword() async {
    try {
      var result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailTextEditingController.text,
          password: passwordTextEditingController.text);
      return sendemail();
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      print(e.toString());
      Fluttertoast.showToast(
          toastLength: Toast.LENGTH_LONG,
          msg: e.message,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          gravity: ToastGravity.BOTTOM,
          fontSize: 16.0);
      return null;
    }
  }

  void changescreen() {
    var route = MaterialPageRoute(builder: (context) => Verifi());
    Navigator.pushReplacement(context, route);
  }
}
