import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height >= 775.0
                    ? MediaQuery.of(context).size.height
                    : 775.0,
              decoration: BoxDecoration(gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFfbab66),
                  Color(0xFFf7418c)
                ]
              )),
              child: Column(children: <Widget>[
                Image.asset("assets/images/login_logo.png"),

          ],
          ),
          ),
          ),
        ],
      ),
    );
  }
}