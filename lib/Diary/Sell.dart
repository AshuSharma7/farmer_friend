import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Sell extends StatefulWidget {
  @override
  _SellState createState() => _SellState();
}

class _SellState extends State<Sell> {
  //var dataBase = Firestore.instance.('');
  DateTime now = DateTime.now();
  String itemsValue;
  int itemPrice;
  int noDiaries = 0;
  List<String> items = [];
  List<int> itemsPrices = [];
  TextEditingController controller = new TextEditingController();
  bool isUpdating;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.black,
        child: MaterialButton(
          onPressed: () {
            noDiaries += 1;
            setState(() {});
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
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
                child: new ListView.builder(
                  itemCount: noDiaries,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return Card(
                        // margin:
                        //     EdgeInsets.only(top: 15.0, right: 20.0, left: 20.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        elevation: 10.0,
                        margin: EdgeInsets.all(15.0),
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "${new DateFormat('EEEE').format(now)}" +
                                        " " +
                                        "${(now.day)}",
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                  Spacer(),
                                  MaterialButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              elevation: 10.0,
                                              title: Text("Add a new item"),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  TextField(
                                                    decoration: InputDecoration(
                                                        hintText: "Item Name",
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0))),
                                                    onChanged: (value) {
                                                      itemsValue = value;
                                                    },
                                                  ),
                                                  SizedBox(
                                                    height: 20.0,
                                                  ),
                                                  TextField(
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                        hintText: "Item Price",
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0))),
                                                    onChanged: (value) {
                                                      itemPrice =
                                                          int.parse(value);
                                                    },
                                                  ),
                                                ],
                                              ),
                                              actions: <Widget>[
                                                FlatButton(
                                                    onPressed: () {
                                                      // databaseReference
                                                      //     .child('$index')
                                                      //     .set({
                                                      //   'title': '$itemsValue',
                                                      //   'description':
                                                      //       '$itemPrice'
                                                      // });
                                                      setState(() {});
                                                      Navigator.of(context)
                                                          .pop(itemPrice);
                                                    },
                                                    child: Text(
                                                      "OK",
                                                      style: TextStyle(
                                                          fontSize: 15.0),
                                                    ))
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: Icon(Icons.add)),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(20.0),
                              child: new ListView.builder(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemCount: items.length,
                                itemBuilder: (BuildContext ctxt, int index) {
                                  return Row(
                                    children: <Widget>[
                                      Text(items[index]),
                                      Spacer(),
                                      Text("${itemsPrices[index]}" + "\$")
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
