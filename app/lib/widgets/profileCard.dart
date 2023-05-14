import 'package:flutter/material.dart';

import '../model/User.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Text(user.fName!);
  }
}
