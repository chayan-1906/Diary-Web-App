import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diary_web_app/models/diary_model.dart';
import 'package:diary_web_app/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';

class WriteDiaryDialog extends StatefulWidget {
  const WriteDiaryDialog({
    Key key,
    @required this.selectedDate,
    @required TextEditingController titleTextController,
    @required TextEditingController descriptionTextController,
  })  : _titleTextController = titleTextController,
        _descriptionTextController = descriptionTextController,
        super(key: key);

  final DateTime selectedDate;
  final TextEditingController _titleTextController;
  final TextEditingController _descriptionTextController;

  @override
  State<WriteDiaryDialog> createState() => _WriteDiaryDialogState();
}

class _WriteDiaryDialogState extends State<WriteDiaryDialog> {
  var _buttonText = 'Done';
  CollectionReference diaryCollectionReference =
      FirebaseFirestore.instance.collection('diaries');
  // html.File _cloudFile;
  var _fileBytes;
  Image _imageWidget;
  String currentUserId;

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
                      // storage.FirebaseStorage firebaseStorage =
                      //     storage.FirebaseStorage.instance;
                      DateTime dateTime = DateTime.now();
                      final path = '$dateTime';
                      final _fieldsNotEmpty =
                          widget._titleTextController.text.isNotEmpty &&
                              widget._descriptionTextController.text.isNotEmpty;
                      if (_fieldsNotEmpty) {
                        diaryCollectionReference
                            .add(DiaryModel(
                          title: widget._titleTextController.text,
                          entry: widget._descriptionTextController.text,
                          author: FirebaseAuth.instance.currentUser.email
                              .split('@')[0],
                          userId: FirebaseAuth.instance.currentUser.uid,
                          entryTime: Timestamp.fromDate(widget.selectedDate),
                        ).toMap())
                            .then((value) {
                          setState(() {
                            currentUserId = value.id;
                          });
                        });
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
                            diaryCollectionReference.doc(currentUserId).update({
                              'photo_list': value.toString(),
                            });
                          });
                        });
                      }*/

                      setState(() {
                        _buttonText = 'Saving...';
                      });
                      Future.delayed(const Duration(milliseconds: 2500))
                          .then((value) {
                        Navigator.of(context).pop();
                      });
                    },
                    style: TextButton.styleFrom(
                        elevation: 4.0,
                        padding: const EdgeInsets.all(20.0),
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0))),
                    child: Text(
                      _buttonText,
                      style: const TextStyle(
                        fontFamily: 'ArialRounded',
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30.0),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    color: Colors.white12,
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: () async {
                            await getMultipleImageInfos();
                          },
                          splashRadius: 26.0,
                          icon: const Icon(Icons.image_rounded),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 50.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(formatDate(widget.selectedDate)),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.50,
                          child: Form(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: (MediaQuery.of(context).size.height *
                                          0.80) /
                                      2,
                                  child: _imageWidget,
                                ),
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
