import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "dart:async";

class CommentScreen extends StatefulWidget {
  final String postid;
  final String postOwner;
  final String postMediaUrl;

  const CommentScreen({this.postid, this.postOwner, this.postMediaUrl});
  @override
  _CommentScreenState createState() => _CommentScreenState(
      postid: this.postid,
      postOwner: this.postOwner,
      postMediaUrl: this.postMediaUrl);
}

class _CommentScreenState extends State<CommentScreen> {
  final String postid;
  final String postOwner;
  final String postMediaUrl;

  bool didFetchComments = false;
  List<Comment> fetchedComments = [];

  final TextEditingController _commentController = TextEditingController();

  _CommentScreenState({this.postid, this.postOwner, this.postMediaUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        brightness: Brightness.light,
        centerTitle: true,
        title: Text("Comments",
          style: TextStyle(fontFamily: 'Handlee',fontSize: 29),
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
      ),
      body: buildPage(),
    );
  }

  Widget buildPage() {
    return Column(
      children: [
        Expanded(
          child: buildComments(),
        ),
        // Divider(),
        ListTile(
          title: TextFormField(
            maxLines: 2,
            controller: _commentController,
            decoration: InputDecoration(labelText: 'Write a comment...'),
            onFieldSubmitted: addComment,
          ),
          trailing: OutlineButton(onPressed: (){addComment(_commentController.text);},
            borderSide: BorderSide.none, child: Text("Post", style: TextStyle(
              fontFamily: "OpenSansPro",
              color: Colors.blueAccent,
              fontSize: 18,),),),
        ),
      ],
    );
  }


  Widget buildComments() {
    if (this.didFetchComments == false){
      return FutureBuilder<List<Comment>>(
          future: getComments(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Container(
                  alignment: FractionalOffset.center,
                  child: CircularProgressIndicator());
            this.didFetchComments = true;
            this.fetchedComments = snapshot.data;
            return ListView(
              children: snapshot.data,
              // Text("${FirebaseAuth.instance.currentUser.email}",
            );
          });
    } else {
      // for optimistic updating
      return ListView(
          children: this.fetchedComments
      );
    }
  }

  Future<List<Comment>> getComments() async {
    List<Comment> comments = [];

    // ignore: deprecated_member_use
    QuerySnapshot data = await FirebaseFirestore.instance.collection("posts").document(postid).collection("comments").get();
    data.docs.forEach((DocumentSnapshot doc) {
      comments.add(Comment.fromDocument(doc));
    });
    return comments;
  }

  addComment(String comment) {
    _commentController.clear();
    // ignore: deprecated_member_use
    FirebaseFirestore.instance.collection("posts").document(postid).collection("comments").add({
      "comment": comment,
      //"timestamp": Timestamp.now(),
      "userId": FirebaseAuth.instance.currentUser.email
    });

    //adds to postOwner's activity feed
    // FirebaseFirestore.instance.collection("insta_a_feed").doc(postOwner).collection("items").add({
    //   "userId": FirebaseAuth.instance.currentUser.email,
    //   "type": "comment",
    //   //"commentData": comment,
    //   //"timestamp": Timestamp.now(),
    //   "postId": postId,
    //    });

    // add comment to the current listview for an optimistic update
    setState(() {
      fetchedComments = List.from(fetchedComments)..add(Comment(
          comment: comment,
          //timestamp: Timestamp.now(),
          userId: FirebaseAuth.instance.currentUser.email
      ));
    });
  }
}

class Comment extends StatelessWidget {
  //final String username;
  final String userId;
  final String comment;
  //final Timestamp timestamp;

  Comment(
      {
        //this.username,
        this.userId,
        this.comment,
        //this.timestamp
      });

  factory Comment.fromDocument(DocumentSnapshot document) {
    var data = document.data();
    return Comment(
      //username: data['username'],
      userId: data['userId'],
      comment: data["comment"],
      //timestamp: data["timestamp"],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(comment),
        ),
        Divider(),
      ],
    );
  }
}

//       stream : instance.collection('posts').orderBy("date",descending: true).snapshots(),
//       builder: (BuildContext context,AsyncSnapshot <QuerySnapshot> snapshot) {

//       FirebaseFirestore.instance.collection("posts").document(postid).collection("comments").add({
//         "comments":val,
//         "commented by":FirebaseAuth.instance.currentUser.email,
//       }).then((value) =>{
