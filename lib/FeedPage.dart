import 'package:farmers_clubbing/miniPrice.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'Global.dart' as Global;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:unicorndial/unicorndial.dart';
import 'Weather.dart';
import 'Prices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() {
    return _FeedPageState();
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class _FeedPageState extends State<FeedPage> {
  DateTime now = DateTime.now();
  FirebaseUser currentUser;
  List<String> weatherItems = [];
  String city = "bhiwadi";

  final List<Widget> carousel = [Weather(), miniPrice()];
  var childButtons = List<UnicornButton>();
  int noPosts = 1;
  String question;
  //String id;
  String userCity = "alwar";
  String id = Global.id;

  @override
  initState() {
    setState(() {});
    getCurrentUser();
    // id = currentUser.uid;
    super.initState();
  }

  void getCurrentUser() async {
    currentUser = await FirebaseAuth.instance.currentUser();
    //  final id = currentUser.uid;
  }

//id = currentUser.uid;
  //List<String>
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Crop Guidance",
          style: TextStyle(fontSize: 35.0),
        ),
        backgroundColor: Color(0xFFfbab66),
        automaticallyImplyLeading: false,
        elevation: 0.0,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 0.0),
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFfbab66), Color(0xFFf7418c)])),
        child: Column(
          children: <Widget>[
            Expanded(
              //padding: EdgeInsets.all(0.0),
              child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance
                    .collection("Feeds")
                    .document(Global.userID())
                    .collection('pages')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError)
                    return new Text('Error: ${snapshot.error}');
                  if (snapshot.data == null)
                    return Center(
                      child: SpinKitChasingDots(
                        color: Colors.white,
                        size: 40.0,
                        //  backgroundColor: Colors.black,
                      ),
                    );
                  if (snapshot.data.documents.toString() != "[]") {
                    return new ListView(
                      children: snapshot.data.documents
                          .map((DocumentSnapshot document) {
                        return AnimationConfiguration.staggeredList(
                          position: 1,
                          duration: const Duration(milliseconds: 545),
                          child: ScaleAnimation(
                            //  verticalOffset: 100,
                            child: new Card(
                              margin: EdgeInsets.all(5.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              elevation: 10.0,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.person,
                                          size: 20.0,
                                        ),
                                        StreamBuilder(
                                          stream: Firestore.instance
                                              .collection("users")
                                              .document(currentUser.uid)
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            return Text(snapshot.data["fname"]);
                                          },
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      width: 400,
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.network(
                                        document['image'],
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: new Text(
                                          // title: document['title'],
                                          document['description'],
                                          style: TextStyle(fontSize: 20.0),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  } else {
                    return Center(
                        child: Text(
                      "No Posts",
                      style: TextStyle(fontSize: 30.0),
                    ));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
