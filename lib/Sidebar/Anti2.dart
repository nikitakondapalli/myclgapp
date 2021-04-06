import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nnrg/Sidebar/AntiRagging.dart';

// ignore: must_be_immutable
class Anti2 extends StatefulWidget {
  String postid;
  Anti2({
    this.postid
  });

  @override
  _Anti2State createState() => _Anti2State();
}

class _Anti2State extends State<Anti2> {
  String postid;
  final anti = TextEditingController();
  final controller = ScrollController();
  double offset = 0;

  _Anti2State({this.postid});

  @override
  void initState() {
    super.initState();
    controller.addListener(onScroll);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MyHeader(
              textTop: "Know All About",
              textBottom: "Anti-Ragging",
              offset: offset,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("AN ACT TO PROHIBIT RAGGING IN EDUCATIONAL INSTITUTIONS IN THE STATE OF ANDHRA PRADESH ACT NO. 26 OF 1997",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Raleway',
                      letterSpacing: 1.0,
                    ),
                  ),

                  SizedBox(height: 20),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Ragging is a criminal offence as per the Supreme Court verdict. ""\n"
                            "Causing, inducing, compelling or forcing a student,"
                            " whether by way of practical joke or otherwise,"
                            " to do any act which detracts from "
                            "human dignity or violates his/her person or exposes him/her to ridicule from doing any lawful act."
                            " By intimidating, wrongfully restraining, wrongfully confining, "
                            "or injuring him or by using criminal force on him/her or by holding out to him/her any threat of intimidation,"
                            " wrongful confinement, injury or the use of criminal force.",
                          style: TextStyle(fontSize: 17,
                              fontFamily: 'Raleway',
                              color: Colors.black54
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 13),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Column(
                              children: [
                                SizedBox(height: 20,),
                                Text("Feel free to tell us what you've gone through. If any..", style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 26,
                                  fontFamily: 'Raleway',
                                  letterSpacing: 1.0,
                                  //fontWeight: FontWeight.bold
                                ),),
                              ],
                            ),
                          ),
                          SizedBox(height: 10,),
                          Form(
                            child: Column(
                              children: [
                                SizedBox(height: 25,),
                                TextFormField(
                                  controller: anti,
                                  style: TextStyle(color: Colors.black87, fontSize: 16),
                                  decoration: InputDecoration(
                                    labelStyle: TextStyle(color: Colors.black87),
                                    labelText: "Report",
                                    hintText: "Describe briefly..",
                                    hintStyle: TextStyle(color: Colors.black26),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black87),
                                    ),
                                  ),
                                  maxLines: 5,
                                ),
                                SizedBox(height: 37,),
                                GestureDetector(
                                  onTap: () {
                                    HapticFeedback.heavyImpact();
                                    writeData(anti.text);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                    margin: EdgeInsets.symmetric(horizontal: 25),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        gradient: LinearGradient(
                                          colors: [
                                            const Color(0xFFC53A4B),
                                            const Color(0xFFE66A77)
                                          ],
                                        )),
                                    width: MediaQuery.of(context).size.width,
                                    child: Center(
                                      child: Text("SUBMIT", style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Raleway',
                                        fontSize: 16,
                                        letterSpacing: 1.0,
                                      ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16,),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
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
        msg:"Message has been Recorded",
        backgroundColor: Colors.green,
        gravity: ToastGravity.CENTER,
      );
      Navigator.pop(context);
    }
  }
}