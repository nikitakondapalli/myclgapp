import 'dart:async';
import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nnrg/Sidebar/Offline.dart';

class Dictionary extends StatefulWidget {
  @override
  _DictionaryState createState() => _DictionaryState();
}

// ignore: camel_case_types
class _DictionaryState extends State<Dictionary> {

  String _url = "https://owlbot.info/api/v4/dictionary/";
  String _token = " 85fab9658d1a54085207c5dc066e3ce24520e1f7";

  TextEditingController _controller = TextEditingController();
  StreamController _streamController;

  Stream _stream;
  Timer _debounce;

  _search() async {

    if(_controller.text == null || _controller.text.length == 0){
      _streamController.add(null);
      return;
    }

    _streamController.add("waiting");
    Response response = await get(_url + _controller.text.trim(), headers: {"Authorization": "Token " + _token});
    _streamController.add(json.decode(response.body));
  }

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
  void initState(){
    super.initState();

    _streamController = StreamController();
    _stream = _streamController.stream;
  }
  @override
  Widget build(BuildContext context) {
    checkConnectivity();
    return isConnected ? Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: Text("Dictionary", style: TextStyle(
          fontFamily: 'Raleway',
        ),),
        bottom: PreferredSize( preferredSize: Size.fromHeight(48.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 12.0,bottom: 8.0, right: 12.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  child: TextFormField(
                    onChanged: (String text) {
                      if(_debounce ?. isActive ?? false) _debounce.cancel();
                      _debounce = Timer(const Duration(milliseconds: 1000),() {
                        _search();
                      });
                    },
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Search For A Word",
                      contentPadding: const EdgeInsets.only(left: 32),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),

              // IconButton(
              //   icon: Icon(
              //     Icons.search,
              //     size: 0,
              //     color: Colors.transparent,
              //   ),
              //   onPressed: () {
              //
              //   },
              // )
            ],
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream: _stream,
          builder: (BuildContext ctx, AsyncSnapshot snapshot) {
            if(snapshot.data == null){
              return Center(
                child: Text("Enter a search word", style: TextStyle(
                  color: Colors.white70,
                  fontFamily: 'Raleway',
                ),
                ),

              );
            }
            if(snapshot.data == "waiting"){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data["definitions"].length,
              itemBuilder: (BuildContext context, int index) {
                return ListBody(
                  children: <Widget>[
                    Container(
                      color: Colors.grey,
                      child: ListTile(

                        leading: snapshot.data["definitions"][index]["image_url"] == null ? null : CircleAvatar(
                          backgroundImage: NetworkImage(snapshot.data["definitions"][index]["image_url"]),
                        ),
                        title: Text(_controller.text.trim() + "("  + snapshot.data["definitions"][index]["type"] + ")",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        snapshot.data["definitions"][index]["definition"],
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Handlee",
                        ),
                      ),
                    ),
                  ],
                );
              },);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _search();
        },
        child: Icon(Icons.search, color: Colors.white,),
        backgroundColor: Colors.blueGrey,
        tooltip: "Search",),
    )
        :   NoConnectionScreen(context);
  }
}