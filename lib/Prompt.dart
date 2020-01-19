import 'package:farmers_clubbing/LoginPage.dart';
import 'package:farmers_clubbing/RegisterPage.dart';
import 'package:flutter/material.dart';

class Prompt extends StatefulWidget {
  @override
  _PromptState createState() => _PromptState();
}

class _PromptState extends State<Prompt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFfbab66), Color(0xFFf7418c)])),
            padding: EdgeInsets.only(top: 200.0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                    child: Text(
                      "पहले इस ऐप का इस्तेमाल किया है?",
                      style: TextStyle(fontSize: 30.0, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 0.0, left: 40.0, right: 40.0),
                    child: SizedBox(
                      width: 150.0,
                      height: 150.0,
                      child: Container(
                        width: 500,
                        height: 100,
                        // color: Colors.white,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.black45, blurRadius: 20.0)
                            ],
                            borderRadius: BorderRadius.circular(30.0)),
                        child: MaterialButton(
                            textColor: Colors.black,
                            splashColor: Color(0xFFfbab66),
                            padding: EdgeInsets.all(0),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ),
                              );
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            child: Center(
                                child: Text(
                              "हाँ",
                              style: TextStyle(
                                  fontSize: 35.0, fontWeight: FontWeight.w300),
                            ))),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 0.0, left: 40.0, right: 40.0),
                    child: SizedBox(
                      width: 150,
                      height: 150.0,
                      child: Container(
                        width: 500,
                        height: 100,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.black45, blurRadius: 20.0)
                            ],
                            borderRadius: BorderRadius.circular(30.0)),
                        child: MaterialButton(
                            textColor: Colors.black,
                            splashColor: Color(0xFFfbab66),
                            padding: EdgeInsets.all(0),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterPage(),
                                ),
                              );
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            child: Center(
                                child: Text(
                              "नहीं",
                              style: TextStyle(
                                  fontSize: 35.0, fontWeight: FontWeight.w300),
                            ))),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
