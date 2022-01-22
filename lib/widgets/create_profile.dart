import 'package:diary_web_app/models/user_model.dart';
import 'package:diary_web_app/screens/login_screen.dart';
import 'package:diary_web_app/widgets/update_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateProfile extends StatelessWidget {
  const CreateProfile({
    Key key,
    @required this.currentUser,
  }) : super(key: key);

  final UserModel currentUser;

  @override
  Widget build(BuildContext context) {
    final TextEditingController _avatarUrlTextController =
        TextEditingController(text: currentUser.avatarUrl);
    final TextEditingController _displayNameTextController =
        TextEditingController(text: currentUser.displayName);
    return Container(
      child: Row(
        children: [
          Column(
            children: [
              /// profile picture & alert dialog
              Expanded(
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return UpdateProfile(
                          currentUser: currentUser,
                          avatarUrlTextController: _avatarUrlTextController,
                          displayNameTextController: _displayNameTextController,
                        );
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 30.0,
                      backgroundImage: NetworkImage(currentUser.avatarUrl),
                      // https://i.pravatar.cc/
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
              ),

              /// profile name
              Text(
                currentUser.displayName,
                style: const TextStyle(
                  fontFamily: 'ArialRounded',
                  color: Colors.grey,
                ),
              ),
            ],
          ),

          /// logout icon
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut().then((value) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ));
              });
            },
            icon: const Icon(
              Icons.power_settings_new_rounded,
              color: Colors.redAccent,
              size: 19.0,
            ),
          ),
        ],
      ),
    );
  }
}
