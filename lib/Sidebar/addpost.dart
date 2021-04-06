import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nnrg/Views/crud.dart';
import 'package:random_string/random_string.dart';

class AddPost extends StatefulWidget {
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  File selectedImage;
  final picker = ImagePicker();

  bool isLoading = false;

  CrudMethods crudMethods = new CrudMethods();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        selectedImage = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> uploadBlog() async {
    if (selectedImage != null) {
      // upload the image

      setState(() {
        isLoading = true;
      });
      Reference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child("blogImages")
          .child("${randomAlphaNumeric(9)}.jpg");

      final UploadTask task = firebaseStorageRef.putFile(selectedImage);

      var imageUrl;
      await task.whenComplete(() async {
        try {
          imageUrl = await firebaseStorageRef.getDownloadURL();
        } catch (onError) {
          print("Error");
        }

        print(imageUrl);
      });

      // print(downloadUrl);

      Map<String, dynamic> blogData = {
        "imgUrl": imageUrl,

      };

      crudMethods.addData(blogData).then((value) {
        setState(() {
          isLoading = false;
        });
        Navigator.pop(context);
      });

      // upload the blog info
    }
  }


  final body=TextEditingController();
  final title=TextEditingController();
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
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add Posts..",
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              color: Colors.blueAccent
          ),
        ),
      ),

      body: isConnected ? SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [

              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: (){

                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(6)
                      ),
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      child: Icon(Icons.add_a_photo, color: Colors.black45,),
                    ),
                  )
              ),
              SizedBox(height: 12,),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: title,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.grey),
                      labelText: "Title",
                      hintText: "Heading",
                      hintStyle: TextStyle(color: Colors.black26, fontFamily: 'Raleway'),
                      border: OutlineInputBorder()),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: body,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.grey),
                      labelText: "Add Body",
                      hintText: "Description",
                      hintStyle: TextStyle(color: Colors.black26, fontFamily: 'Raleway'),
                      border: OutlineInputBorder()),
                  maxLines: 4,
                ),
              ),
              SizedBox(height: 12,),

              GestureDetector(
                onTap: () {
                  HapticFeedback.heavyImpact();
                  insertPost();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  margin: EdgeInsets.symmetric(horizontal: 55),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.blueAccent
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Text("Post", style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontFamily: 'Raleway'),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )

          : Container(
        color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("OFFLINE", style: TextStyle(color: Colors.white),),
            SizedBox(width: 8.0,),
            SizedBox(width: 12.0, height: 12.0,
              child: CircularProgressIndicator(strokeWidth: 2.0,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }



  void insertPost() {

    if(body.text.length>1&&title.text.length>1){
      FirebaseFirestore.instance.collection("posts").add({
        "likes":0,
        "body":body.text,
        "date":DateTime.now().millisecondsSinceEpoch,
        "title": title.text,
      }).then((value) => {
        Fluttertoast.showToast(
          toastLength: Toast.LENGTH_LONG,
          msg:"Post added !",
          backgroundColor: Colors.green,
          gravity: ToastGravity.TOP,
        ),
        //Navigator.pop(context),
      });
    }

    else {
      if(body.text.length<=1){
        Fluttertoast.showToast(
          toastLength: Toast.LENGTH_LONG,
          msg:"Body field can't be empty",
          backgroundColor: Colors.redAccent,
          gravity: ToastGravity.CENTER,
        );
      }

      else if(title.text.length<=1){
        Fluttertoast.showToast(
          toastLength: Toast.LENGTH_LONG,
          msg:"Title field cannot be empty",
          backgroundColor: Colors.redAccent,
          gravity: ToastGravity.CENTER,
        );
      }
    }
  }
}