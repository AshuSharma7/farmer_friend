import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Farmer1",
          style: TextStyle(fontSize: 35.0),
        ),
        backgroundColor: Color(0xFFfbab66),
        automaticallyImplyLeading: false,
        elevation: 0.0,
      ),
      body: Container(
        //padding: EdgeInsets.only(top: 200.0),
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color(0xFFfbab66),
              Color(0xFFf7418c),
            ])),
        child: TextField(
          //obscureText: true,
          //controller: passEditor,\
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.white)),
            hintStyle: TextStyle(color: Colors.white),
            hintText: "Type Your Message",
            prefixIcon: Icon(
              Icons.message,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
