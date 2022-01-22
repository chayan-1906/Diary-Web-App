import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diary_web_app/models/diary_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'inner_list_card.dart';
import 'loading.dart';

class DiaryListView extends StatefulWidget {
  const DiaryListView(
      {Key key,
      @required List<DiaryModel> listOfDiaries,
      @required this.selectedDate})
      : _listOfDiaries = listOfDiaries,
        super(key: key);

  final List<DiaryModel> _listOfDiaries;
  final DateTime selectedDate;

  @override
  State<DiaryListView> createState() => _DiaryListViewState();
}

class _DiaryListViewState extends State<DiaryListView> {
  @override
  Widget build(BuildContext context) {
    CollectionReference diariesCollectionReference =
        FirebaseFirestore.instance.collection('diaries');
    return StreamBuilder<QuerySnapshot>(
        stream: diariesCollectionReference.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
          }
          var filteredList = snapshot.data.docs.map((diary) {
            return DiaryModel.fromDocument(diary);
          }).where((item) {
            return item.userId == FirebaseAuth.instance.currentUser.uid;
          }).toList();
          return Column(
            children: [
              Expanded(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.40,
                  child: ListView.builder(
                    itemCount: filteredList.length,
                    itemBuilder: (BuildContext buildContext, int index) {
                      DiaryModel diaryModel = filteredList[index];
                      return Card(
                        elevation: 4.0,
                        color: Colors.transparent,
                        child: InnerListCard(
                          selectedDate: widget.selectedDate,
                          // selectedDate: this.selectedDate,
                          diaryModel: diaryModel,
                          diariesCollectionReference:
                              diariesCollectionReference,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        });
  }
}
