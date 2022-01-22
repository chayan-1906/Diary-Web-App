import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diary_web_app/models/diary_model.dart';
import 'package:diary_web_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DiaryService {
  final CollectionReference usersCollectionReference =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference diariesCollectionReference =
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
    // collectionReference.add(userModel.toMap());
    usersCollectionReference.doc(uid).set(userModel.toMap());
    return;
  }

  Future<void> updateUser(
      {BuildContext context,
      UserModel user,
      String displayName,
      String avatarUrl}) async {
    UserModel updateUser = UserModel(
        displayName: displayName, avatarUrl: avatarUrl, uid: user.uid);
    usersCollectionReference
        .doc(user.uid)
        .update(updateUser.toMap())
        .onError((error, stackTrace) => print(error.toString()));
    return;
  }

  Future<List<DiaryModel>> getSameDateDiaries({DateTime first, String userId}) {
    return diariesCollectionReference
        .where('entry_time',
            isGreaterThanOrEqualTo: Timestamp.fromDate(first).toDate())
        .where('entry_time',
            isLessThan:
                Timestamp.fromDate(first.add(const Duration(days: 1))).toDate())
        .where('user_id', isEqualTo: userId)
        .get()
        .then((value) {
      print('Items length==> ${value.docs.length}');
      return value.docs.map((diary) {
        return DiaryModel.fromDocument(diary);
      }).toList();
    });
  }
}
