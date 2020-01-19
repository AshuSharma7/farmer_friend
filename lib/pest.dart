import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmers_clubbing/loans.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PestAlert extends StatefulWidget {
  @override
  _PestAlertState createState() => _PestAlertState();
}

String content;
String news;

class _PestAlertState extends State<PestAlert> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFfbab66), Color(0xFFf7418c)])),
        child: Column(
          children: <Widget>[
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection("pest").snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return ListView(
                        children: snapshot.data.documents
                            .map((DocumentSnapshot document) {
                      // print(document['title']);
                      return Container(
                        height: 100,
                        child: GestureDetector(
                          onTap: () {
                            news = document['News'];
                            content = document['content'];
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PestPage()));
                          },
                          child: Card(
                              margin: EdgeInsets.all(15.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Center(
                                  child: Text(
                                document['title'],
                                style: TextStyle(fontSize: 15.0),
                              ))),
                        ),
                      );
                    }).toList());
                  } else {
                    return Container(
                      // decoration: BoxDecoration(
                      //     gradient: LinearGradient(
                      //         begin: Alignment.topCenter,
                      //         end: Alignment.bottomCenter,
                      //         colors: [Color(0xffebab66), Color(0xffe7418c)])),
                      child: Center(
                        child: SpinKitThreeBounce(
                          color: Colors.white,
                          size: 60.0,
                        ),
                      ),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PestPage extends StatefulWidget {
  @override
  _PestPageState createState() => _PestPageState();
}

class _PestPageState extends State<PestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pest Alert"),
        elevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffebab66),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFfbab66), Color(0xFFf7418c)])),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text(
                "Pest Attacks in Following Ares",
                style: TextStyle(fontSize: 25.0),
              ),
              Card(
                margin: EdgeInsets.all(10.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    news,
                    style: TextStyle(fontSize: 23.0),
                  ),
                ),
              ),
              Text(
                "Precautions",
                style: TextStyle(fontSize: 23.0),
              ),
              Container(
                padding: EdgeInsets.all(5.0),
                child: Card(
                  margin: EdgeInsets.all(10.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      content,
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
