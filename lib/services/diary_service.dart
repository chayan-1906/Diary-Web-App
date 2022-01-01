import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diary_web_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DiaryService {
  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('users');

  Future<void> loginUser({String email, String password}) async {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return;
  }

  Future<void> createUser(
      {BuildContext context, String uid, String displayName}) async {
    UserModel userModel = UserModel(
      uid: uid,
      displayName: displayName,
      avatarUrl: 'https://picsum.photos/200/300',
    );
    collectionReference.add(userModel.toMap());
    //   .then((value) {
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => const MainScreen(),
    //   ),
    // );
    // });
    return;
  }
}
