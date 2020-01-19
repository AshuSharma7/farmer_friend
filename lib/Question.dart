import 'package:flutter/material.dart';

class Question extends StatefulWidget {
  @override
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AlertDialog(
        content: Text("Ask a Question"),
        actions: <Widget>[
          TextField(
            decoration: InputDecoration(
              hintText: "Enter Here",
              labelText: "Qquestion",
            ),
          ),
        ],
      ),
    );
  }
}
