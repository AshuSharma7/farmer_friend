import 'package:farmers_clubbing/FeedPage.dart';
import 'package:farmers_clubbing/MainPage.dart';
import 'package:farmers_clubbing/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Global.dart' as global;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final TextEditingController adhharEditor = new TextEditingController();
  final TextEditingController passEditor = new TextEditingController();
  static List<String> list = ["किसान", "उपभोक्ता"];
  String selectedValue = list[0];
  AuthResult currentUser;
  List<Widget> dropDownItems = [FeedPage(), User()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            //   padding: EdgeInsets.only(top: 28),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height >= 775.0
                  ? MediaQuery.of(context).size.height
                  : 775.0,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFFfbab66), Color(0xFFf7418c)])),
              // color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/images/login_logo.png",
                    width: 250.0,
                  ),
                  // Container(
                  //   padding: EdgeInsets.only(bottom: 20.0),
                  //   child: Icon(Icons.portrait, size: 100.0,),),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        margin: EdgeInsets.all(10.0),
                        // elevation: 10.0,
                        color: Colors.transparent,
                        child: Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: Column(
                            children: <Widget>[
                              Stack(
                                children: <Widget>[
                                  Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    elevation: 10.0,
                                    color: Colors.white,
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          top: 15.0, left: 10.0, right: 10.0),
                                      child: Column(
                                        children: <Widget>[
                                          TextFormField(
                                            obscureText: false,
                                            controller: adhharEditor,
                                            decoration: InputDecoration(
                                              hintText: "Email",
                                              prefixIcon:
                                                  Icon(Icons.alternate_email),
                                              border: InputBorder.none,
                                              fillColor: Colors.red,
                                            ),
                                            //onSaved: (value) => ,
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
                                                labelText: "पासवर्ड",
                                                prefixIcon:
                                                    Icon(Icons.lock_outline),
                                                border: InputBorder.none),
                                          ),
                                          SizedBox(
                                            height: 40.0,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),

                                  //SizedBox(height: 40.0,),
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 140.0, left: 0.0, right: 0.0),
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
                                                  color: Colors.black26,
                                                  blurRadius: 10.0)
                                            ],
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0)),
                                          ),
                                          child: MaterialButton(
                                              textColor: Colors.white,
                                              splashColor: Color(0xFFfbab66),
                                              padding: EdgeInsets.all(0),
                                              onPressed: () async {
                                                try {
                                                  AuthResult currentUser =
                                                      await FirebaseAuth
                                                          .instance
                                                          .signInWithEmailAndPassword(
                                                              email:
                                                                  adhharEditor
                                                                      .text,
                                                              password:
                                                                  passEditor
                                                                      .text);
                                                  Navigator.pushAndRemoveUntil(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              MainPage(
                                                                title:
                                                                    "MainPage",
                                                                uid: currentUser
                                                                    .user.uid,
                                                              )),
                                                      (_) => false);
                                                  adhharEditor.clear();
                                                  passEditor.clear();
                                                  global.getCurrentUser();
                                                  // .then((currentUser) => {
                                                  //       Navigator
                                                  //           .pushAndRemoveUntil(
                                                  //               context,
                                                  //               MaterialPageRoute(
                                                  //                   builder: (context) =>
                                                  //                       MainPage(
                                                  //                         title: "Users",
                                                  //                         uid: currentUser.user.uid,
                                                  //                       )),
                                                  //               (_) =>
                                                  //                   false),

                                                  // adhharEditor
                                                  //     .clear(),
                                                  // passEditor.clear(),
                                                  // global
                                                  //     .getCurrentUser(),

                                                } on PlatformException catch (e) {
                                                  return showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          actions: <Widget>[
                                                            MaterialButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: Text("OK"),
                                                            )
                                                          ],
                                                          title: Text(
                                                              "Wrong Credentials"),
                                                          content: Text(
                                                              "Wrong Email or PAssword"),
                                                        );
                                                      });
                                                }
                                              },
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0)),
                                              child: Center(
                                                  child: Text(
                                                "लॉग इन करें",
                                                style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ))),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              DropdownButton<String>(
                                items: list.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                value: selectedValue,
                                onChanged: (String newValue) {
                                  setState(() {
                                    selectedValue = newValue;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
