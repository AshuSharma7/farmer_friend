import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmers_clubbing/Global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'Diary.dart' as diary;
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

bool editMode = false;

class SmartDiary extends StatefulWidget {
  final String tab;
  SmartDiary(this.tab);
  @override
  _SmartDiaryState createState() => _SmartDiaryState(tab);
}

class _SmartDiaryState extends State<SmartDiary> {
  String tab;
  _SmartDiaryState(this.tab);
  DateTime now = DateTime.now();
  String itemsValue;
  int itemPrice;
  int noDiaries = 0;
  List<String> items = [];
  List<int> itemsPrices = [];
  TextEditingController controller = new TextEditingController();
  bool isUpdating;
  int total = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 485),
        child: Center(
          child: FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.black,
            child: MaterialButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      elevation: 10.0,
                      title: Text("Add a new Diary"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          TextField(
                            decoration: InputDecoration(
                                hintText: "Item Name",
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            onChanged: (value) {
                              itemsValue = value;
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                hintText: "Item Price",
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            onChanged: (value) {
                              itemPrice = int.parse(value);
                            },
                          ),
                        ],
                      ),
                      actions: <Widget>[
                        FlatButton(
                            onPressed: () async {
                              // CircularProgressIndicator(
                              //   backgroundColor: Colors.black,
                              // );
                              Navigator.of(context).pop(context);
                              await Firestore.instance
                                  .collection("users")
                                  .document(currentUser.uid)
                                  .collection(tab)
                                  .add({
                                "itemName": itemsValue,
                                "itemPrice": itemPrice
                              });
                              CircularProgressIndicator(
                                backgroundColor: Colors.black,
                              );

                              setState(() {});
                            },
                            child: Text(
                              "OK",
                              style: TextStyle(fontSize: 15.0),
                            ))
                      ],
                    );
                  },
                );
                setState(() {});
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: Container(
        child: Container(
          padding: EdgeInsets.only(top: 10.0),
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
                stream: Firestore.instance
                    .collection("users")
                    .document(currentUser.uid)
                    .collection(tab)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  //print(snapshot.data.documents.toString());
                  if (snapshot.hasError) {
                    return Text("Error");
                  }
                  if (snapshot == null)
                    return Center(
                        child: CircularProgressIndicator(
                      backgroundColor: Colors.black,
                    ));
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: SpinKitThreeBounce(
                        color: Colors.white,
                        size: 50.0,
                        //  backgroundColor: Colors.black,
                      ),
                    );
                  } else if (snapshot.data.documents.toString() != "[]") {
                    return Card(
                      margin: EdgeInsets.all(5.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      // elevation: 5.0,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  "Item Name",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                                Spacer(),
                                Text(
                                  "Total",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 0.8,
                              child: Container(
                                height: 0.8,
                                color: Colors.black,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ),
                            Expanded(
                              //   padding: const EdgeInsets.all(8.0),
                              child: ListView(
                                children: snapshot.data.documents
                                    .map((DocumentSnapshot document) {
                                  total += document["itemPrice"];
                                  return AnimationConfiguration.staggeredGrid(
                                    columnCount: 2,
                                    position: 1,
                                    duration: const Duration(milliseconds: 475),
                                    child: ScaleAnimation(
                                      // verticalOffset: 50.0,
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: new Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                if (diary.editMode == true)
                                                  GestureDetector(
                                                      onTap: () async {
                                                        showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AlertDialog(
                                                                content: Text(
                                                                    "Do You Want to delete this Entry"),
                                                                actions: <
                                                                    Widget>[
                                                                  MaterialButton(
                                                                    onPressed:
                                                                        () {
                                                                      Firestore
                                                                          .instance
                                                                          .collection(
                                                                              "users")
                                                                          .document(currentUser
                                                                              .uid)
                                                                          .collection(
                                                                              tab)
                                                                          .document(
                                                                              document.documentID)
                                                                          .delete();
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                      setState(
                                                                          () {});
                                                                    },
                                                                    child: Text(
                                                                        "OK"),
                                                                  )
                                                                ],
                                                              );
                                                            });
                                                      },
                                                      child:
                                                          Icon(Icons.delete)),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: new Text(
                                                    document["itemName"],
                                                    style: TextStyle(
                                                        fontSize: 16.0),
                                                  ),
                                                ),
                                                Spacer(),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: new Text(
                                                    document["itemPrice"]
                                                            .toString() +
                                                        "₹",
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 0.6,
                                              child: Container(
                                                height: 0.6,
                                                color: Colors.black,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                              ),
                                            ),
                                            //Spacer(),
                                            // Text("itemPrice")
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 0.0, bottom: 5),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "Items: " +
                                        snapshot.data.documents.length
                                            .toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0),
                                  ),
                                  Spacer(),
                                  Text(
                                    "Total: " + total.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Center(
                      child: Text(
                        "No Items in Diary",
                        style: TextStyle(fontSize: 30.0),
                      ),
                    );
                  }
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}
