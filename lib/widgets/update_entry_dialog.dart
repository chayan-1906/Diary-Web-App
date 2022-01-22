import 'dart:html' as html;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diary_web_app/models/diary_model.dart';
import 'package:diary_web_app/utils/utils.dart';
import 'package:diary_web_app/widgets/delete_enrty_dialog.dart';
import 'package:diary_web_app/widgets/inner_list_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';

class UpdateEntryDialog extends StatefulWidget {
  const UpdateEntryDialog({
    Key key,
    @required this.diaryModel,
    @required TextEditingController titleTextController,
    @required TextEditingController descriptionTextController,
    @required this.widget,
    @required CollectionReference linkReference,
    @required DateTime selectedDate,
    this.cloudFile,
    this.fileBytes,
    this.imageWidget,
  })  : _titleTextController = titleTextController,
        _descriptionTextController = descriptionTextController,
        _linkReference = linkReference,
        _selectedDate = selectedDate,
        super(key: key);

  final DiaryModel diaryModel;
  final TextEditingController _titleTextController;
  final TextEditingController _descriptionTextController;
  final CollectionReference _linkReference;
  final InnerListCard widget;
  final html.File cloudFile;
  final fileBytes;
  final Image imageWidget;
  final DateTime _selectedDate;

  @override
  State<UpdateEntryDialog> createState() => _UpdateEntryDialogState();
}

class _UpdateEntryDialogState extends State<UpdateEntryDialog> {
  var _fileBytes;
  Image _imageWidget;

  @override
  Widget build(BuildContext context) {
    Future<void> getMultipleImageInfos() async {
      var mediaData = await ImagePickerWeb.getImageInfo;
      // String mimeType = mime(path.basename(mediaData.fileName));
      // html.File mediaFile =
      //     html.File(mediaData.data, mediaData.fileName, {'type': mimeType});

      // if (mediaFile != null) {
      setState(() {
        // _cloudFile = mediaFile;
        _fileBytes = mediaData.data;
        print(_fileBytes.toString());
        _imageWidget = Image.memory(mediaData.data);
      });
      // }
    }

    return AlertDialog(
      elevation: 5.0,
      content: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                /// discard
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: TextButton.styleFrom(
                        elevation: 4.0,
                        padding: const EdgeInsets.all(20.0),
                        backgroundColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0))),
                    child: const Text(
                      'Discard',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'ArialRounded',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                /// done
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextButton(
                    onPressed: () {
                      final _fieldsNotEmpty =
                          widget._titleTextController.text.isNotEmpty &&
                              widget._descriptionTextController.text.isNotEmpty;
                      final diaryTitleChanged = widget.diaryModel.title !=
                          widget._titleTextController.text;
                      final diaryEntryChanged = widget.diaryModel.entry !=
                          widget._descriptionTextController.text;
                      final diaryUpdate = diaryTitleChanged ||
                          diaryEntryChanged ||
                          _fileBytes != null;
                      // storage.FirebaseStorage firebaseStorage =
                      //     storage.FirebaseStorage.instance;
                      DateTime dateTime = DateTime.now();
                      final path = '$dateTime';
                      if (_fieldsNotEmpty && diaryUpdate) {
                        widget._linkReference
                            .doc(widget.diaryModel.id)
                            .update(DiaryModel(
                              userId: FirebaseAuth.instance.currentUser.uid,
                              author: FirebaseAuth.instance.currentUser.email
                                  .split('@')[0],
                              title: widget._titleTextController.text,
                              entry: widget._descriptionTextController.text,
                              photoUrls: widget.diaryModel.photoUrls,
                              entryTime: Timestamp.fromDate(
                                // widget.widget.selectedDate,
                                DateTime.now(),
                              ),
                            ).toMap())
                            .then((value) => Navigator.of(context).pop());
                      }
                      // TODO:  SOMETHING WENT WRONG WITH FIREBASE STORAGE
                      /*if (_fileBytes != null) {
                        storage.SettableMetadata settableMetadata =
                            storage.SettableMetadata(
                          contentType: 'image/jpeg',
                          customMetadata: {'picked-file-path': path},
                        );
                        firebaseStorage
                            .ref('diary-web-app-chayan19062000.appspot.com')
                            .child(
                                'images/$path${FirebaseAuth.instance.currentUser.uid}')
                            .putData(_fileBytes, settableMetadata)
                            .then((value) {
                          return value.ref.getDownloadURL().then((value) {
                            widget._linkReference
                                .doc(FirebaseAuth.instance.currentUser.uid)
                                .update({
                              'photo_list': value.toString(),
                            });
                          });
                        }).then((value) {
                          Navigator.of(context).pop();
                        });
                      }*/
                      // setState(() {
                      //   _buttonText = 'Saving...';
                      // });
                      // Future.delayed(const Duration(milliseconds: 2500))
                      //     .then((value) {
                      //   Navigator.of(context).pop();
                      // });
                    },
                    style: TextButton.styleFrom(
                        elevation: 4.0,
                        padding: const EdgeInsets.all(20.0),
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0))),
                    child: const Text(
                      // _buttonText,
                      'Done',
                      style: TextStyle(
                        fontFamily: 'ArialRounded',
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      // image picker
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          onPressed: () async {
                            await getMultipleImageInfos();
                          },
                          splashRadius: 26.0,
                          icon: const Icon(Icons.image_rounded),
                        ),
                      ),
                      // delete
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return DeleteEntryDialog(
                                    diariesCollectionReference:
                                        widget._linkReference,
                                    diaryModel: widget.diaryModel,
                                  );
                                });
                          },
                          splashRadius: 26.0,
                          icon: const Icon(
                            Icons.delete_outline_rounded,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 50.0),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          formatDateFromTimestamp(widget.diaryModel.entryTime),
                          style: const TextStyle(fontFamily: 'ArialRounded'),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.60,
                          height: MediaQuery.of(context).size.height * 0.40,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: _imageWidget ??
                                Image.network(widget.diaryModel.photoUrls ??
                                    'https://picsum.photos/400/200'),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.50,
                          child: Form(
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: widget._titleTextController,
                                  decoration: const InputDecoration(
                                      hintText: 'Title...'),
                                ),
                                TextFormField(
                                  maxLines: null,
                                  controller: widget._descriptionTextController,
                                  decoration: const InputDecoration(
                                      hintText: 'Write your thoughts here...'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
