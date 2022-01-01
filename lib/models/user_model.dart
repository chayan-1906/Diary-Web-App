import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String uid;
  final String displayName;
  final String profession;
  final String avatarUrl;

  UserModel({
    this.id,
    this.uid,
    this.displayName,
    this.profession,
    this.avatarUrl,
  });

  factory UserModel.fromDocument(QueryDocumentSnapshot queryDocumentSnapshot) {
    return UserModel(
      id: queryDocumentSnapshot.id,
      uid: queryDocumentSnapshot.get('uid'),
      displayName: queryDocumentSnapshot.get('display_name'),
      profession: queryDocumentSnapshot.get('profession'),
      avatarUrl: queryDocumentSnapshot.get('avatar_url'),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'display_name': displayName,
      'profession': profession,
      'avatar_url': avatarUrl,
    };
  }
}
