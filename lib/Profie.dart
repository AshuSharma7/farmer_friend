import 'package:farmers_clubbing/Global.dart';
import 'package:farmers_clubbing/Prompt.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            StreamBuilder(
                stream: Firestore.instance
                    .collection("users")
                    .document(currentUser.uid)
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return SpinKitThreeBounce(
                      size: 40,
                      color: Colors.white,
                    );
                  }
                  var user = snapshot.data;
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0xFFfbab66), Color(0xFFf7418c)])),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: 300.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Colors.white,
                              image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/carousel1.png"),
                                  fit: BoxFit.cover),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black38,
                                    blurRadius: 10.0,
                                    spreadRadius: 5.0)
                              ]),
                          width: MediaQuery.of(context).size.width,
                          // child: Image.asset("assets/images/45280.jpg", fit: BoxFit.fill),
                        ),
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: 200.0,
                                height: 200.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100.0),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black38,
                                          blurRadius: 30.0,
                                          spreadRadius: 10.0)
                                    ]),
                                child: Icon(
                                  Icons.person,
                                  size: 100.0,
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                user["fname"].toString().toUpperCase(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 30.0),
                              ),
                              Text(
                                "E-mail id: " + user["email"],
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20.0),
                              ),
                              SizedBox(
                                height: 60.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Icon(
                                        Icons.edit,
                                        size: 40.0,
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Text("रूपरेखा"),
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          FirebaseAuth.instance.signOut().then(
                                                (result) => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Prompt()),
                                                ),
                                              );
                                        },
                                        child: Icon(
                                          Icons.vpn_key,
                                          size: 40.0,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Text("Logout"),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
