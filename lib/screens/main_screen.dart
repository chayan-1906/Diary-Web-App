import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diary_web_app/models/diary_model.dart';
import 'package:diary_web_app/models/user_model.dart';
import 'package:diary_web_app/services/diary_service.dart';
import 'package:diary_web_app/widgets/create_profile.dart';
import 'package:diary_web_app/widgets/diary_listview.dart';
import 'package:diary_web_app/widgets/write_dialog_diary.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String _dropDownText;
  final TextEditingController _titleTextController = TextEditingController();
  final TextEditingController _descriptionTextController =
      TextEditingController();
  DateTime selectedDate = DateTime.now();
  var userDiaryFilteredEntriesList;
  List<DiaryModel> _listOfDiaries = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        toolbarHeight: 100.0,
        // elevation: 4.0,
        title: Row(
          children: [
            Text(
              'Diary',
              style: TextStyle(
                fontFamily: 'ArialRounded',
                fontSize: 39.0,
                color: Colors.blueGrey.shade400,
              ),
            ),
            const Text(
              'Book',
              style: TextStyle(
                fontFamily: 'ArialRounded',
                fontSize: 39.0,
                color: Colors.green,
              ),
            ),
          ],
        ),
        actions: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton(
                  items: <String>['Latest', 'Earliest'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(
                          fontFamily: 'ArialRounded',
                          color: Colors.grey,
                        ),
                      ),
                    );
                  }).toList(),
                  hint: _dropDownText != null
                      ? Text(
                          _dropDownText,
                          style: const TextStyle(
                            fontFamily: 'ArialRounded',
                            fontSize: 17.0,
                          ),
                        )
                      : const Text(
                          'Select',
                          style: TextStyle(
                            fontFamily: 'ArialRounded',
                            fontSize: 17.0,
                          ),
                        ),
                  onChanged: (value) {
                    if (value == 'Latest') {
                      setState(() {
                        _dropDownText = value;
                      });
                    } else if (value == 'Earliest') {
                      setState(() {
                        _dropDownText = value;
                      });
                    }
                  },
                ),
              ),
              // TODO: CREATE PROFILE
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    final usersListStream = snapshot.data.docs.map((docs) {
                      return UserModel.fromDocument(docs);
                    }).where((userModel) {
                      return (userModel.uid ==
                          FirebaseAuth.instance.currentUser.uid);
                    }).toList();
                    UserModel currentUser = usersListStream[0];
                    return CreateProfile(currentUser: currentUser);
                  }),
            ],
          ),
        ],
      ),
      body: Row(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border(
                  right: BorderSide(width: 0.4, color: Colors.blueGrey),
                ),
                // color: Colors.green,
              ),
              child: Column(
                children: [
                  /// calendar
                  Padding(
                    padding: const EdgeInsets.all(38.0),
                    child: SfDateRangePicker(
                      headerStyle: const DateRangePickerHeaderStyle(
                        textStyle: TextStyle(
                          fontFamily: 'ArialRounded',
                          fontWeight: FontWeight.w600,
                          fontSize: 20.0,
                        ),
                      ),
                      monthCellStyle: const DateRangePickerMonthCellStyle(
                        textStyle: TextStyle(
                          fontFamily: 'ArialRounded',
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0,
                        ),
                      ),
                      yearCellStyle: const DateRangePickerYearCellStyle(
                        textStyle: TextStyle(
                          fontFamily: 'ArialRounded',
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0,
                        ),
                      ),
                      selectionTextStyle: const TextStyle(
                        fontFamily: 'ArialRounded',
                        // fontWeight: FontWeight.w100,
                        fontSize: 13.0,
                      ),
                      todayHighlightColor: Colors.greenAccent,
                      onSelectionChanged: (dateRangePickerSelection) {
                        setState(() {
                          selectedDate = dateRangePickerSelection.value;
                          _listOfDiaries.clear();
                          userDiaryFilteredEntriesList =
                              DiaryService().getSameDateDiaries(
                            first: Timestamp.fromDate(selectedDate).toDate(),
                            userId: FirebaseAuth.instance.currentUser.uid,
                          );
                          userDiaryFilteredEntriesList.then((value) {
                            for (var item in value) {
                              // print('Diary => ${item.title}');
                              setState(() {
                                _listOfDiaries.add(item);
                              });
                            }
                          });
                        });
                        // print('userDiaryFilteredEntriesList: ${userDiaryFilteredEntriesList.toString()}');
                        // setState(() {
                        // selectedDate = dateRangePickerSelection.value;
                        // _listOfDiaries.clear();
                        // userDiaryFilteredEntriesList = DiaryService()
                        //     .getSameDateDiaries(
                        //     Timestamp.fromDate(selectedDate).toDate(),
                        //     FirebaseAuth.instance.currentUser!.uid);
                        //
                        // userDiaryFilteredEntriesList.then((value) {
                        //   for (var item in value) {
                        //     setState(() {
                        //       _listOfDiaries.add(item);
                        //     });
                        //   }
                        // });
                        // });
                      },
                    ),
                  ),

                  /// write new textbutton.icon
                  Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Card(
                      elevation: 4.0,
                      child: TextButton.icon(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return WriteDiaryDialog(
                                  selectedDate: selectedDate,
                                  titleTextController: _titleTextController,
                                  descriptionTextController:
                                      _descriptionTextController,
                                );
                              });
                        },
                        icon: Icon(
                          Icons.add_rounded,
                          size: 30.0,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        label: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Write New',
                            style: TextStyle(
                              fontFamily: 'ArialRounded',
                              fontSize: 17.0,
                              color: Theme.of(context).primaryColorDark,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 10,
            child: DiaryListView(
              listOfDiaries: _listOfDiaries,
              selectedDate: selectedDate,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add',
        backgroundColor: Theme.of(context).primaryColorDark,
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}
