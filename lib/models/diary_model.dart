import 'package:cloud_firestore/cloud_firestore.dart';

class DiaryModel {
  final String id;
  final String userId;
  final String title;
  final String author;
  final Timestamp entryTime;
  final String photoUrls;
  final String entry;

  DiaryModel({
    this.id,
    this.userId,
    this.title,
    this.author,
    this.entryTime,
    this.photoUrls,
    this.entry,
  });

  factory DiaryModel.fromDocument(QueryDocumentSnapshot queryDocumentSnapshot) {
    return DiaryModel(
      id: queryDocumentSnapshot.id,
      userId: queryDocumentSnapshot.get('user_id'),
      author: queryDocumentSnapshot.get('author'),
      entryTime: queryDocumentSnapshot.get('entry_time'),
      photoUrls: queryDocumentSnapshot.get('photo_list'),
      title: queryDocumentSnapshot.get('title'),
      entry: queryDocumentSnapshot.get('entry'),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'title': title,
      'author': author,
      'entry': entry,
      'photo_list': photoUrls,
      'entry_time': entryTime,
    };
  }
}
