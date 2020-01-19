import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'Global.dart' as global;

TextEditingController messageController = new TextEditingController();

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

bool me = false;
final ScrollController scroll = new ScrollController();

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Stack(
        children: <Widget>[
          Container(
            height: 40.0,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: "Type your Message...",
                        fillColor: Colors.white,
                        // prefixIcon: Icon(Icons.lock_outline),
                        border: InputBorder.none),
                    controller: messageController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () async {
                      Firestore.instance
                          .collection("users")
                          .document(global.userID())
                          .collection("Help")
                          .add({
                        "message": messageController.text,
                        "from": global.userID(),
                        "timestamp": FieldValue.serverTimestamp()
                      });
                      messageController.clear();
                      scroll.animateTo(
                        scroll.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 1),
                        curve: Curves.easeOut,
                      );
                    },
                    child: Icon(
                      Icons.send,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      appBar: AppBar(
        backgroundColor: Color(0xFFfbab66),
        title: Text(
          "Messages",
          style: TextStyle(fontSize: 32),
        ),
        elevation: 0.0,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFfbab66), Color(0xFFf7418c)])),
        child: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              StreamBuilder(
                stream: Firestore.instance
                    .collection("users")
                    .document(global.userID())
                    .collection("Help")
                    .snapshots(),
                builder: (BuildContext, AsyncSnapshot<QuerySnapshot> snapshot) {
                  return Column(
                    children: snapshot.data.documents
                        .map((DocumentSnapshot document) {
                      if (!snapshot.hasData) {
                        Center(
                          child: SpinKitThreeBounce(
                            color: Colors.white,
                            size: 60.0,
                          ),
                        );
                      }
                      if (document["from"] == "admin") {
                        me = false;
                      }
                      return Container();
                    }).toList(),
                    //crossAxisAlignment: CrossAxisAlignment.start,
                  );
                },
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  // crossAxisAlignment: fromMe ? CrossAxisAlignment.,
                  children: <Widget>[
                    StreamBuilder(
                      stream: Firestore.instance
                          .collection("users")
                          .document(global.userID())
                          .collection("Help")
                          .orderBy("timestamp")
                          .snapshots(),
                      builder: (BuildContext,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        // if (global.userID() == snapshot.data.documents[1]) {
                        //   me = true;
                        // }

                        // print(snapshot.data.documents.first);
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return Column(
                          children: snapshot.data.documents
                              .map((DocumentSnapshot document) {
                            if (document["from"] == "admin") {
                              me = false;
                            } else {
                              me = true;
                            }
                            return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  alignment: me
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  height: 40.0,
                                  child: Container(
                                      margin: EdgeInsets.all(10.0),
                                      padding: EdgeInsets.all(2.0),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(3.0)),
                                      child: Text(
                                        document["message"],
                                        style: TextStyle(fontSize: 14),
                                      )),
                                ));
                          }).toList(),
                          crossAxisAlignment: CrossAxisAlignment.start,
                        );
                      },
                    )
                  ],
                ),
              ),
              // Container(
              //   height: 30.0,
              //   width: MediaQuery.of(context).size.width,
              //   child: Row(
              //     children: <Widget>[
              //       Expanded(
              //         child: TextField(
              //           decoration: InputDecoration(
              //               hintText: "Type your Message...",
              //               fillColor: Colors.white,
              //               // prefixIcon: Icon(Icons.lock_outline),
              //               border: InputBorder.none),
              //           controller: messageController,
              //         ),
              //       ),
              //       MaterialButton(
              //         color: Colors.white,
              //         shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(10.0)),
              //         onPressed: () async {
              //           Firestore.instance
              //               .collection("users")
              //               .document(global.userID())
              //               .collection("Help")
              //               .add({
              //             "message": messageController.text,
              //             "from": global.userID(),
              //             "timestamp": FieldValue.serverTimestamp()
              //           });
              //           messageController.clear();
              //         },
              //         child: Icon(Icons.send),
              //       )
              //     ],
              //   ),
              // ),
            ],
            // crossAxisAlignment:
            //     me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          ),
        ),
      ),
    );
  }
}
