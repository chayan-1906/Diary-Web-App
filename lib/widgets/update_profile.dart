import 'package:diary_web_app/models/user_model.dart';
import 'package:diary_web_app/services/diary_service.dart';
import 'package:flutter/material.dart';

class UpdateProfile extends StatelessWidget {
  const UpdateProfile({
    Key key,
    @required this.currentUser,
    @required TextEditingController avatarUrlTextController,
    @required TextEditingController displayNameTextController,
  })  : _avatarUrlTextController = avatarUrlTextController,
        _displayNameTextController = displayNameTextController,
        super(key: key);

  final UserModel currentUser;
  final TextEditingController _avatarUrlTextController;
  final TextEditingController _displayNameTextController;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        width: MediaQuery.of(context).size.width * 0.40,
        height: MediaQuery.of(context).size.height * 0.40,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Editing ${currentUser.displayName}',
              style: Theme.of(context).textTheme.headline5,
            ),
            const SizedBox(height: 30.0),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.50,
              child: Form(
                child: Column(
                  children: [
                    /// avatar url textformfield
                    TextFormField(
                      controller: _avatarUrlTextController,
                    ),

                    /// display name textformfield
                    TextFormField(
                      controller: _displayNameTextController,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Colors.green,
                            elevation: 4.0,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                              side: BorderSide(
                                color: Colors.green,
                                width: 1.0,
                              ),
                            )),
                        onPressed: () {
                          print(_displayNameTextController.text);
                          print(_avatarUrlTextController.text);
                          DiaryService()
                              .updateUser(
                            context: context,
                            user: currentUser,
                            displayName: _displayNameTextController.text,
                            avatarUrl: _avatarUrlTextController.text,
                          )
                              .then((value) {
                            Navigator.of(context).pop();
                          });
                        },
                        child: const Text(
                          'Update',
                          style: TextStyle(
                            fontFamily: 'ArialRounded',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
