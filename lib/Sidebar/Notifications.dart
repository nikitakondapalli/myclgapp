import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:nnrg/Pushnotify.dart';
import 'package:nnrg/Sidebar/AddPost.dart';
import 'package:nnrg/Sidebar/Offline.dart';
import 'package:nnrg/Views/crud.dart';
import 'package:share/share.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'CommentsPage.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {

  CrudMethods crudMethods = new CrudMethods();
  QuerySnapshot blogSnapshot;

  //String get imgUrl => null;
  // final String imgUrl;
  // BlogTile(
  //     {
  //       @required this.imgUrl,
  //     });



  bool isConnected = true;

  final _controller = NativeAdmobController();
  FirebaseFirestore instance = FirebaseFirestore.instance;

  Widget createNativeAd() {
    NativeAdmob nativeAdModAd = NativeAdmob(
      adUnitID: NativeAd.testAdUnitId,
      controller: _controller,
    );
    return Container(
        width: double.infinity,
        height: 100,
        child: nativeAdModAd
    );
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

  String useruid="";

  Future<void> getpresentuseruid() async {
    // ignore: await_only_futures
    var tempid= await FirebaseAuth.instance.currentUser.uid;
    setState(() {
      useruid= tempid;
    });
  }

  //------notifications------------------------//
  String _homeScreenText = "Waiting for token...";

  final Map<String, Item> _items = <String, Item>{};
  Item _itemForMessage(Map<String, dynamic> message) {
    final dynamic data = message['data'] ?? message;
    final String itemId = data['id'];
    final Item item = _items.putIfAbsent(itemId, () => Item(itemId: itemId))
      ..status = data['status'];
    return item;
  }
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  Widget _buildDialog(BuildContext context, Item item) {
    return AlertDialog(
      content: Text("Item ${item.itemId} has been updated"),
      actions: <Widget>[
        FlatButton(
          child: const Text('CLOSE'),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        FlatButton(
          child: const Text('SHOW'),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ],
    );
  }

  void _showItemDialog(Map<String, dynamic> message) {
    showDialog<bool>(
      context: context,
      builder: (_) => _buildDialog(context, _itemForMessage(message)),
    ).then((bool shouldNavigate) {
      if (shouldNavigate == true) {
        _navigateToItemDetail(message);
      }
    });
  }
  void _navigateToItemDetail(Map<String, dynamic> message) {
    final Item item = _itemForMessage(message);
    // Clear away dialogs
    Navigator.popUntil(context, (Route<dynamic> route) => route is PageRoute);
    if (!item.route.isCurrent) {
      Navigator.push(context, item.route);
    }
  }
  initializeFCM(){
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        _showItemDialog(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        _navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        _navigateToItemDetail(message);
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: true)
    );
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      setState(() {
        _homeScreenText = "Push Messaging token: $token";
      });
      print(_homeScreenText);
    });
  }

//-------------------notifications--------//

  @override
  Widget build(BuildContext context) {
    return  isConnected ? Scaffold(
        backgroundColor: Colors.black87,
        appBar: AppBar(
          brightness: Brightness.light,
          centerTitle: true,
          title: Shimmer.fromColors(
            baseColor:Colors.white,
            highlightColor:Colors.black,
            child: Text("Notifications", style: TextStyle(
                fontFamily: 'Handlee',fontSize: 33),
            ),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                      Color(0xFF52779F),
                      Color(0xFF52779F),
                    ])
            ),
          ),
          actions: [
            IconButton(
              icon: Icon( Icons.add ),
              color: Colors.transparent,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddPost()));
              },
            ),
          ],
        ),
        body:  StreamBuilder(
          stream : FirebaseFirestore.instance.collection('posts').orderBy("date",descending: true).snapshots(),
          builder: (BuildContext context,AsyncSnapshot <QuerySnapshot> snapshot) {
            if(snapshot.hasData){
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context,index){
                    var cards= Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: ListTile(
                          title: ListTile(
                            onTap: () { },
                            title: Text(
                              snapshot.data.docs[index].data()["title"],
                              style: TextStyle(
                                  fontSize: 22.0,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.bold),
                            ),
                            trailing: Text(
                              timeago.format(
                                  DateTime.fromMillisecondsSinceEpoch(snapshot.data.docs[index].data()["date"])),
                              style: TextStyle(fontSize: 14.0, color: Colors.grey),
                            ),
                          ),
                          isThreeLine: true,
                          subtitle: Padding(
                            padding: const EdgeInsets.only(bottom: 14.0),
                            child: Column(
                              children: [

                                // Linkify(
                                //   onOpen: (link) async{
                                //     if (await canLaunch(link.url)) {
                                //       await launch(link.url);
                                //     } else {
                                //       Fluttertoast.showToast(
                                //         toastLength: Toast.LENGTH_LONG,
                                //         msg: "Could not launch $link",
                                //         backgroundColor: Colors.white,
                                //         textColor: Colors.black54,
                                //         gravity: ToastGravity.CENTER,
                                //       );
                                //     }
                                //   },
                                //   text: (snapshot.data.docs[index].data()["body"] ),
                                //   style: TextStyle(fontSize: 18.0),
                                // ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    IconButton(
                                      onPressed: ()  {
                                        HapticFeedback.heavyImpact();
                                        if(snapshot.data.docs[index].data()[useruid]!=null){
                                          if(snapshot.data.docs[index].data()[useruid]){
                                            // ignore: deprecated_member_use
                                            FirebaseFirestore.instance.collection('posts').doc(snapshot.data.docs[index].documentID.toString()).update({
                                              "likes":(snapshot.data.docs[index].data()["likes"])-1,
                                              useruid:false,
                                            });
                                          }
                                          else{
                                            // ignore: deprecated_member_use
                                            FirebaseFirestore.instance.collection('posts').doc(snapshot.data.docs[index].documentID.toString()).update({
                                              "likes":(snapshot.data.docs[index].data()["likes"])+1,
                                              useruid:true,
                                            });
                                          }
                                        }
                                        else{
                                          // ignore: deprecated_member_use
                                          FirebaseFirestore.instance.collection('posts').doc(snapshot.data.docs[index].documentID.toString()).update({
                                            "likes":(snapshot.data.docs[index].data()["likes"])+1,
                                            useruid:true,
                                          });
                                        }
                                      },
                                      icon: Icon(snapshot.data.docs[index].data()[useruid]==true
                                          ?Icons.favorite:Icons.favorite_border,color: snapshot.data.docs[index].data()[useruid]==true
                                          ?Colors.red:Colors.black,size: 16,),),
                                    Text(snapshot.data.docs[index].data()["likes"].toString(),style:TextStyle(color: CupertinoColors.systemRed),),
                                    IconButton(
                                      icon: Icon(Icons.chat_bubble_outline,color: Colors.grey),
                                      iconSize: 18,
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => CommentScreen()));
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.share,color: Colors.blueAccent),
                                      iconSize: 18,
                                      onPressed: (){
                                        Share.share("Please Download 'NNRG Student Portal' App From\n"
                                            "https://play.google.com/store/apps/details?id=com.clg.nnrg&hl=en_US&gl=US\n"
                                            " To View This Post.. ",subject: "Download 'NNRG Student Portal' App");
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                    return Column(
                      children: [
                        cards,
                        index % 2 == 0 ? createNativeAd() : Container()
                      ],
                    );
                  }
              );

            } else {
              return Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),);
            }
          },
        )
    )
        :   NoConnectionScreen(context);
  }

  @override
  void initState() {
    crudMethods.getData().then((result) {
      blogSnapshot = result;
      setState(() {});
    });
    super.initState();
    getpresentuseruid();
    initializeFCM();
  }
}