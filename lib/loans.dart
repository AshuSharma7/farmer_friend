import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loans extends StatefulWidget {
  @override
  _LoansState createState() => _LoansState();
}

String content;

class _LoansState extends State<Loans> {
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
                stream: Firestore.instance.collection("loans").snapshots(),
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
                            content = document['content'];
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoanPage()));
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

class LoanPage extends StatefulWidget {
  @override
  _LoanPageState createState() => _LoanPageState();
}

class _LoanPageState extends State<LoanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Loans Description"),
        elevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffebab66),
      ),
      body: Container(
        child: Text(
          content,
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }
}
