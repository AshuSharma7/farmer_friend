import 'package:firebase_auth/firebase_auth.dart';

FirebaseUser currentUser;
String id;
void getCurrentUser() async {
  currentUser = await FirebaseAuth.instance.currentUser();
  id = currentUser.uid;
}

String userID() {
  getCurrentUser();
  return currentUser.uid;
}
