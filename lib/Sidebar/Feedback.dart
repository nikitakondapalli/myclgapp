import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'Offline.dart';


// ignore: must_be_immutable
class Review extends StatefulWidget {
  String postid;
  Review({
    this.postid
  });

  @override
  _ReviewState createState() => _ReviewState(postid:postid);
}

class _ReviewState extends State<Review> {

  String postid;

  final review = TextEditingController();

  Color _bulbColor = Colors.grey;

  _ReviewState({this.postid});

  bool isConnected = true;

  @override
  void initState() {
    super.initState();
  }

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
    return isConnected ? GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child:
        Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              title:Text("Feedback", style: TextStyle(
                  fontFamily: 'Handlee', fontSize: 32),
              ),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  color: _bulbColor,
                ),
              ),
            ),

            body:  ListView(
              children: <Widget> [
                SizedBox(height: 10.0,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text("We would like your feedback to improve our app. ", style: TextStyle(
                      fontFamily: 'Raleway',
                    ),
                    ),
                  ],
                ),
                SizedBox(height: 15.0,),

                Row(
                  children: <Widget>[
                    Radio( value: Colors.redAccent, groupValue: _bulbColor, onChanged: (val) {
                      _bulbColor = val;
                      setState(() {});
                    },),
                    Text("Login Trouble?", style: TextStyle(
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Radio( value: Colors.blueAccent, groupValue: _bulbColor, onChanged: (val) {
                      _bulbColor = val;
                      setState(() {});
                    },),
                    Text("Change My E-mail Address", style: TextStyle(
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Radio( value: Colors.teal, groupValue: _bulbColor, onChanged: (val) {
                      _bulbColor = val;
                      setState(() {});
                    },),
                    Text("Found a Bug in the app.", style: TextStyle(
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Radio( value: Colors.orangeAccent, groupValue: _bulbColor, onChanged: (val) {
                      _bulbColor = val;
                      setState(() {});
                    },),
                    Text("Other Issues", style: TextStyle(
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Radio( value: Colors.black, groupValue: _bulbColor, onChanged: (val) {
                      _bulbColor = val;
                      setState(() {});
                    },),
                    Text("Suggestion", style: TextStyle(
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: TextFormField(
                    controller: review,
                    maxLines: 6,
                    decoration: InputDecoration(
                      hintText: "Please briefly describe the issue?",
                      hintStyle: TextStyle(
                          fontSize: 15.0,
                          color: Color(0xffc5c5c5),
                          fontFamily: "Raleway"
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffe5e5e5)),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    child: FlatButton(
                      onPressed: () {
                        writeData(review.text);
                      },
                      color: _bulbColor,
                      padding: EdgeInsets.all(16.0),
                      child: Text("SUBMIT", style: TextStyle(
                        letterSpacing: 1.0,
                        fontFamily: 'Raleway',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                    ),
                  ),
                ),
              ],
            )
        )
    )
        : NoConnectionScreen(context);
  }

  void writeData(String val) {
    if(val==""){
      Fluttertoast.showToast(
        toastLength: Toast.LENGTH_LONG,
        msg:"You can't send empty message.",
        backgroundColor: Colors.redAccent,
        gravity: ToastGravity.CENTER,
      );
    }

    else{
      Fluttertoast.showToast(
        toastLength: Toast.LENGTH_LONG,
        msg:"Thank you for feedback.",
        backgroundColor: Colors.green,
        gravity: ToastGravity.CENTER,
      );
      Navigator.pop(context);
    }
  }
}