import 'package:farmers_clubbing/MainPage.dart';
import 'package:farmers_clubbing/Prompt.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'Global.dart' as global;

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  initState() {
    FirebaseAuth.instance
        .currentUser()
        .then((currentUser) => {
              if (currentUser == null)
                {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Prompt()))
                }
              else
                {
                  global.getCurrentUser(),
                  //global.userID(),
                  Firestore.instance
                      .collection("users")
                      .document(global.id)
                      .get()
                      .then((DocumentSnapshot result) =>
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainPage(
                                        title: "sdf",
                                        uid: global.id,
                                      ))))
                      .catchError((err) => print(err))
                }
            })
        .catchError((err) => print(err));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: SpinKitThreeBounce(
            color: Colors.black,
            size: 60.0,
          ),
        ),
      ),
    );
  }
}
