import 'package:farmers_clubbing/SmartDiary.dart';
import 'package:farmers_clubbing/loans.dart';
//import 'SmartDiary.dart' as bool;
import 'package:flutter/material.dart';

bool editMode = false;

class DiaryWidget extends StatefulWidget {
  @override
  _DiaryWidgetState createState() => _DiaryWidgetState();
}

class _DiaryWidgetState extends State<DiaryWidget> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFfbab66),
          elevation: 0.0,
          title: Text(
            "लेन-देन",
            style: TextStyle(fontSize: 35),
          ),
          actions: <Widget>[
            MaterialButton(
              child: Icon(Icons.edit),
              onPressed: () {
                setState(() {
                  if (editMode == false) {
                    editMode = true;
                  } else if (editMode == true) {
                    editMode = false;
                  }
                });
              },
            )
          ],
          automaticallyImplyLeading: false,
          bottom: TabBar(
            tabs: <Widget>[
              Text(
                "Loans",
                style: TextStyle(fontSize: 20.0),
              ),
              Text("बेचना", style: TextStyle(fontSize: 20.0)),
              Text("उधार", style: TextStyle(fontSize: 20.0)),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Loans(),
            SmartDiary("Buy"),
            SmartDiary("Sell"),
          ],
        ),
      ),
    );
  }
}
