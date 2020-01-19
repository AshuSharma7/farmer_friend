import 'package:farmers_clubbing/WeatherPage.dart';
import 'package:farmers_clubbing/pest.dart';
import 'package:flutter/material.dart';

class Alert extends StatefulWidget {
  @override
  _AlertState createState() => _AlertState();
}

class _AlertState extends State<Alert> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Alerts",
            style: TextStyle(fontSize: 35.0),
          ),
          elevation: 0.0,
          backgroundColor: Color(0xffebab66),
          automaticallyImplyLeading: false,
          bottom: TabBar(
            tabs: <Widget>[
              Text(
                "Weather",
                style: TextStyle(fontSize: 20.0),
              ),
              Text("Pest Alert", style: TextStyle(fontSize: 20.0)),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[WeatherPage(), PestAlert()],
        ),
      ),
    );
  }
}
