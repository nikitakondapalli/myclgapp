import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nnrg/Sidebar/Offline.dart';
import '../main.dart';
import 'Forgetpwd.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController passwordTextEditingController = new TextEditingController();

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
    return isConnected ?  GestureDetector(
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
          title: Text("Sign In",
            style: TextStyle(fontFamily: 'Raleway',color: Colors.white),
          ),
        ),

        body: isLoading ? Container(
          child: Center(child: CircularProgressIndicator()),) : Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Column(
                    children: [
                      SizedBox(height: 20,),
                      Text("Welcome Back", style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                      ),),
                      SizedBox(height: 15,),
                      Text("Sign in with your registered \n email and password", style: TextStyle(
                        color: Colors.white70,
                      ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Form(
                  child: Column(
                    children: [
                      SizedBox(height: 25,),
                      TextFormField(
                        validator: (val) {
                          return RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(val) ? null : "Please Enter Correct Email";
                        },
                        controller: emailTextEditingController,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.grey),
                          labelText: "Email",
                          hintText: "Enter your email",
                          hintStyle: TextStyle(color: Colors.white70),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(28),
                              borderSide: BorderSide(color: Colors.white),
                              gapPadding: 10
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(28),
                              borderSide: BorderSide(color: Colors.white),
                              gapPadding: 10
                          ),
                          suffixIcon: Icon(Icons.mail_outline,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      SizedBox(height: 30,),
                      TextFormField(
                        obscureText: _obscureText,
                        validator: (val) {
                          return val.length >= 6
                              ? null : "Enter a Correct Password ";
                        },
                        style: TextStyle(color: Colors.white, fontSize: 16),
                        controller: passwordTextEditingController,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.grey),
                          labelText: "Password",
                          hintText: "Enter your Password",
                          hintStyle: TextStyle(color: Colors.white70),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(28),
                              borderSide: BorderSide(color: Colors.white),
                              gapPadding: 10
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(28),
                              borderSide: BorderSide(color: Colors.white),
                              gapPadding: 10
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                            color: this._obscureText ? Colors.grey : Colors.redAccent,
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
                SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassword()));
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Text("Forgot Password?",
                            style: TextStyle(color: Colors.white, fontSize: 16,
                                fontFamily: 'Raleway'),
                          )),
                    )
                  ],
                ),
                SizedBox(height: 16,),
                GestureDetector(
                  onTap: () async{
                    setState(() {
                      isLoading=true;
                    });
                    await signInWithEmailAndPassword();
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
                    child: Text("Sign In",
                      style: TextStyle(color: Colors.white, fontSize: 17, fontFamily: 'Raleway'),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: 19,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account? ",
                      style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Raleway'),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text("Create Now",
                        style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Raleway',
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    )
        :   NoConnectionScreen(context);
  }

  void checkuser() {
    var user=FirebaseAuth.instance.currentUser;
    if(user!=null){
      var newRoute=MaterialPageRoute(builder: (context)=> SplashScreen());
      Navigator.pushReplacement(context, newRoute);

    } else {
      setState(() {
        isLoading=false;
      });
    }
  }

  Future signInWithEmailAndPassword() async {
    try {
      var result = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailTextEditingController.text, password: passwordTextEditingController.text);

      return checkuser();
    } catch (e) {
      setState(() {
        isLoading=false;
      });

      print(e.toString());
      Fluttertoast.showToast(
        toastLength: Toast.LENGTH_LONG,
        msg: e.message,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 15,
      );
      return null;
    }
  }

}
