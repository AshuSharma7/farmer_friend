import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmers_clubbing/Global.dart';
import 'package:flutter/cupertino.dart';

Widget build(BuildContext context) {
  return StreamBuilder(
    stream: Firestore.instance
        .collection("users")
        .document(currentUser.uid)
        .snapshots(),
    builder: (context, snapshot) {
      return Text(snapshot.data["fname"]);
    },
  );
}
