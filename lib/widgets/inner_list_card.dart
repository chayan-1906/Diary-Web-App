import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diary_web_app/models/diary_model.dart';
import 'package:diary_web_app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'delete_enrty_dialog.dart';
import 'update_entry_dialog.dart';

class InnerListCard extends StatelessWidget {
  final DateTime selectedDate;
  final DiaryModel diaryModel;
  final CollectionReference<Object> diariesCollectionReference;

  const InnerListCard({
    Key key,
    @required this.selectedDate,
    this.diaryModel,
    this.diariesCollectionReference,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _titleTextController =
        TextEditingController(text: diaryModel.title);
    final TextEditingController _descriptionTextController =
        TextEditingController(text: diaryModel.entry);
    return Column(
      children: [
        ListTile(
          title: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatDateFromTimestamp(diaryModel.entryTime),
                  style: const TextStyle(
                    fontFamily: 'ArialRounded',
                    fontSize: 19.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return DeleteEntryDialog(
                          diariesCollectionReference:
                              diariesCollectionReference,
                          diaryModel: diaryModel,
                        );
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.delete_forever_rounded,
                    color: Colors.redAccent,
                  ),
                  label: Text(''),
                ),
              ],
            ),
          ),
          subtitle: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formatDateFromTimestampHour(diaryModel.entryTime),
                    style: const TextStyle(
                      fontFamily: 'ArialRounded',
                      color: Colors.green,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.more_horiz_rounded),
                    label: const Text(''),
                  ),
                ],
              ),
              Image.network(diaryModel.photoUrls != null
                  ? diaryModel.photoUrls.toString()
                  : 'https://picsum.photos/400/200'),
              Row(
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// title
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            diaryModel.title,
                            style: const TextStyle(
                              fontFamily: 'ArialRounded',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        /// entry
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            diaryModel.entry,
                            style: const TextStyle(
                              fontFamily: 'ArialRounded',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          onTap: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Row(
                            children: [
                              Text(
                                formatDateFromTimestamp(diaryModel.entryTime),
                                style: const TextStyle(
                                  fontFamily: 'ArialRounded',
                                  fontSize: 19.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              // edit
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return UpdateEntryDialog(
                                          diaryModel: diaryModel,
                                          titleTextController:
                                              _titleTextController,
                                          descriptionTextController:
                                              _descriptionTextController,
                                          linkReference:
                                              diariesCollectionReference,
                                          selectedDate: selectedDate,
                                          widget: this,
                                        );
                                      });
                                },
                                icon: const Icon(Icons.edit_rounded),
                              ),
                              // delete
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return DeleteEntryDialog(
                                          diariesCollectionReference:
                                              diariesCollectionReference,
                                          diaryModel: diaryModel,
                                        );
                                      });
                                },
                                icon: const Icon(
                                  Icons.delete_forever_rounded,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    content: ListTile(
                      subtitle: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                formatDateFromTimestampHour(
                                    diaryModel.entryTime),
                                style: const TextStyle(
                                  fontFamily: 'ArialRounded',
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.60,
                            height: MediaQuery.of(context).size.height * 0.50,
                            child: Image.network(diaryModel.photoUrls == null
                                ? 'https://picsum.photos/400/200'
                                : diaryModel.photoUrls.toString()),
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        diaryModel.title,
                                        style: const TextStyle(
                                          fontFamily: 'ArialRounded',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        diaryModel.entry,
                                        style: const TextStyle(
                                          fontFamily: 'ArialRounded',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            fontFamily: 'ArialRounded',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  );
                });
          },
        ),
      ],
    );
  }
}
