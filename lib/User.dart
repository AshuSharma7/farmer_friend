import 'package:flutter/material.dart';
import 'package:unicorndial/unicorndial.dart';
import 'Weather.dart';
import 'Prices.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';

class User extends StatefulWidget {
  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  DateTime now = DateTime.now();
  List<String> weatherItems = [];
  String city = "bhiwadi";

  final List<Widget> carousel = [Weather(), Prices()];
  var childButtons = List<UnicornButton>();
  int noPosts = 1;
  List<String> postData = [
    "चावल की खेत में मुझे किस कीटनाशक का उपयोग करना चाहिए?"
  ];
  String question;

  //List<String>
  @override
  Widget build(BuildContext context) {
    var childButtons = List<UnicornButton>();
    childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: "प्रश्न पूछें",
        currentButton: FloatingActionButton(
            heroTag: "Question",
            backgroundColor: Colors.black,
            mini: true,
            child: Icon(Icons.question_answer),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      title: Text("Ask a question"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          TextField(
                            decoration: InputDecoration(
                                hintText: "Enter Question here",
                                labelText: "Question"),
                            onChanged: (value) {
                              question = value;
                            },
                          )
                        ],
                      ),
                      actions: <Widget>[
                        MaterialButton(
                          onPressed: () {
                            noPosts += 1;
                            postData.add(question);
                            Navigator.of(context).pop(question);
                            setState(() {});
                          },
                          child: Text("OK"),
                        )
                      ],
                    );
                  });
            })));

    childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: "एक विचार पोस्ट करें",
        currentButton: FloatingActionButton(
          heroTag: "idea",
          backgroundColor: Colors.black,
          mini: true,
          child: Icon(Icons.bubble_chart),
          onPressed: () {},
        )));
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "जानकारी",
          style: TextStyle(fontSize: 35.0),
        ),
        backgroundColor: Color(0xFFfbab66),
        automaticallyImplyLeading: false,
        elevation: 0.0,
      ),
      floatingActionButton: UnicornDialer(
        backgroundColor: Colors.transparent,
        parentButtonBackground: Colors.black,
        orientation: UnicornOrientation.VERTICAL,
        parentButton: Icon(Icons.add),
        childButtons: childButtons,
      ),
      body: Container(
        child: Container(
          padding: EdgeInsets.only(top: 20.0),
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFfbab66), Color(0xFFf7418c)])),
          child: Column(
            children: <Widget>[
              Center(
                  child: new CarouselSlider(
                      autoPlayDuration: Duration(seconds: 5),
                      items: [2, 1].map((i) {
                        return new Builder(
                          builder: (BuildContext context) {
                            return new Container(
                                //color: Colors.transparent,
                                width: MediaQuery.of(context).size.width,
                                margin: new EdgeInsets.only(
                                    left: 5.0,
                                    right: 5.0,
                                    bottom: 10.0,
                                    top: 10.0),

                                //decoration: new BoxDecoration(color: Colors.amber),
                                child: Container(
                                    //elevation: 10.0,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        color: Colors.transparent,
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/images/carousel$i.png"),
                                            fit: BoxFit.cover),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black38,
                                              blurRadius: 5.0,
                                              spreadRadius: 2.0)
                                        ]),
                                    child: Center(child: carousel[i - 1])));
                          },
                        );
                      }).toList(),
                      height: 200.0,
                      autoPlay: true)),
              Expanded(
                //padding: EdgeInsets.all(0.0),
                child: new ListView.builder(
                  itemCount: noPosts,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        elevation: 10.0,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.person,
                                    size: 25.0,
                                  ),
                                  Text("आशु शर्मा"),
                                  Spacer(),
                                  Text("${new DateFormat('EEEE').format(now)}" +
                                      " " +
                                      "${(now.day)}"),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.all(0.0),
                                child: Text(
                                  postData[index],
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              TextField(
                                decoration: InputDecoration(
                                    hintText: "क्या आप उत्तर दे सकते हैं?"),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
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
