import 'package:flutter/material.dart';

import '../model/user_model.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({Key? key, required this.user}) : super(key: key);

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Text(user.fName);
  }
}
