import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diary_web_app/models/diary_model.dart';
import 'package:diary_web_app/screens/main_screen.dart';
import 'package:flutter/material.dart';

class DeleteEntryDialog extends StatelessWidget {
  const DeleteEntryDialog({
    Key key,
    @required this.diariesCollectionReference,
    @required this.diaryModel,
  }) : super(key: key);

  final CollectionReference<Object> diariesCollectionReference;
  final DiaryModel diaryModel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Delete Entry?',
        style: TextStyle(fontFamily: 'ArialRounded', color: Colors.redAccent),
      ),
      content: const Text(
        'Are you sure you want to delete?\nThis action can\'t be undone',
        style: TextStyle(fontFamily: 'ArialRounded'),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Cancel',
            style: TextStyle(fontFamily: 'ArialRounded'),
          ),
        ),
        TextButton(
          onPressed: () {
            // Navigator.of(context).pop();
            diariesCollectionReference
                .doc(diaryModel.id)
                .delete()
                .then((value) {
              // Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const MainScreen(),
                ),
              );
            });
          },
          child: Text(
            'Delete',
            style: TextStyle(fontFamily: 'ArialRounded'),
          ),
        ),
      ],
    );
  }
}
