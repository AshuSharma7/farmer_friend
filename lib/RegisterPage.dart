import 'package:farmers_clubbing/MainPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  final TextEditingController fnameEditor = new TextEditingController();
  final TextEditingController emailEditor = new TextEditingController();
  final TextEditingController passEditor = new TextEditingController();
  final TextEditingController mobileEditor = new TextEditingController();
  final TextEditingController confirmPassEditor = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(top: 50.0),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height >= 775.0
                  ? MediaQuery.of(context).size.height
                  : 775.0,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFFfbab66), Color(0xFFf7418c)])),
              child: Column(
                children: <Widget>[
                  Image.asset(
                    "assets/images/login_logo.png",
                    width: 250.0,
                  ),
                  Stack(
                    children: <Widget>[
                      Card(
                        margin:
                            EdgeInsets.only(top: 10.0, right: 40.0, left: 40.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        elevation: 10.0,
                        color: Colors.white,
                        child: Container(
                          padding: EdgeInsets.only(
                              top: 15.0, left: 10.0, right: 10.0),
                          child: Form(
                            key: _registerFormKey,
                            child: Column(
                              children: <Widget>[
                                TextField(
                                  obscureText: false,
                                  controller: fnameEditor,
                                  decoration: InputDecoration(
                                    labelText: "पूरा नाम",
                                    prefixIcon: Icon(Icons.person_outline),
                                    border: InputBorder.none,
                                    fillColor: Colors.red,
                                  ),
                                ),
                                SizedBox(
                                    height: 0.8,
                                    child: Container(
                                      height: 0.8,
                                      width: 235.0,
                                      color: Colors.black26,
                                    )),
                                TextField(
                                  obscureText: false,
                                  controller: emailEditor,
                                  // maxLength: 12,
                                  //    keyboardType: TextInputType,
                                  decoration: InputDecoration(
                                      labelText: "Email",
                                      prefixIcon: Icon(Icons.email),
                                      counterText: '',
                                      border: InputBorder.none),
                                ),
                                SizedBox(
                                    height: 0.8,
                                    child: Container(
                                      height: 0.8,
                                      width: 235.0,
                                      color: Colors.black26,
                                    )),
                                TextField(
                                  obscureText: false,
                                  controller: mobileEditor,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    labelText: "मोबाइल न.",
                                    prefixIcon: Icon(Icons.phone),
                                    border: InputBorder.none,
                                    fillColor: Colors.red,
                                  ),
                                ),
                                SizedBox(
                                    height: 0.8,
                                    child: Container(
                                      height: 0.8,
                                      width: 235.0,
                                      color: Colors.black26,
                                    )),
                                TextField(
                                  obscureText: true,
                                  controller: passEditor,
                                  decoration: InputDecoration(
                                      labelText: "नया पासवर्ड",
                                      prefixIcon: Icon(Icons.lock_outline),
                                      border: InputBorder.none),
                                ),
                                SizedBox(
                                    height: 0.8,
                                    child: Container(
                                      height: 0.8,
                                      width: 235.0,
                                      color: Colors.black26,
                                    )),
                                TextField(
                                  obscureText: true,
                                  controller: confirmPassEditor,
                                  decoration: InputDecoration(
                                      labelText: "नया पासवर्ड",
                                      prefixIcon: Icon(Icons.lock_outline),
                                      border: InputBorder.none),
                                ),
                                SizedBox(
                                  height: 40.0,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 330.0, left: 80.0, right: 80.0),
                        child: SizedBox(
                          width: 200,
                          height: 45.0,
                          child: Container(
                            width: 500,
                            height: 100,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.topRight,
                                  colors: [
                                    Color(0xFFfbab66),
                                    Color(0xFFf7418c)
                                  ]),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26, blurRadius: 10.0)
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                            child: MaterialButton(
                                textColor: Colors.white,
                                splashColor: Color(0xFFfbab66),
                                padding: EdgeInsets.all(0),
                                onPressed: () async {
                                  if (_registerFormKey.currentState
                                      .validate()) {
                                    if (passEditor.text ==
                                        confirmPassEditor.text) {
                                      try {
                                        await FirebaseAuth.instance
                                            .createUserWithEmailAndPassword(
                                                email: emailEditor.text,
                                                password: passEditor.text)
                                            .then((currentUser) => Firestore
                                                    .instance
                                                    .collection("users")
                                                    .document(
                                                        currentUser.user.uid)
                                                    .setData({
                                                  "uid": currentUser.user.uid,
                                                  "fname": fnameEditor.text,
                                                  "email": emailEditor.text,
                                                  "mobile": mobileEditor.text,
                                                }).then((result) => {
                                                          Navigator
                                                              .pushAndRemoveUntil(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              MainPage(
                                                                                title: "Users",
                                                                                uid: currentUser.user.uid,
                                                                              )),
                                                                  (_) => false),
                                                          fnameEditor.clear(),
                                                          emailEditor.clear(),
                                                          passEditor.clear(),
                                                          confirmPassEditor
                                                              .clear()
                                                        }));
                                      } on PlatformException catch (e) {
                                        return showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                actions: <Widget>[
                                                  MaterialButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text("OK"),
                                                  )
                                                ],
                                                title:
                                                    Text("Wrong email format"),
                                                content: Text(
                                                    "Email is wrong, Check email format "),
                                              );
                                            });
                                      }
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text("Error"),
                                              content: Text(
                                                  "Passwords do not match"),
                                              actions: <Widget>[
                                                MaterialButton(
                                                  child: Text("OK"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                )
                                              ],
                                            );
                                          });
                                    }
                                  }
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0)),
                                child: Center(
                                    child: Text(
                                  "जुड़ जाओ",
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold),
                                ))),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
