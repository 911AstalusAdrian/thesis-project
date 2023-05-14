import 'package:flutter/material.dart';

import '../model/User.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {



  @override
  Widget build(BuildContext context) {
    // TODO: Investigate why do I get a Stack Overflow if I try to create the card as a Stateless Widget
    // TODO  in Scaffold, tried the following: body : ProfileCard(user: widget.user)
    // TODO can do without a widget but it would be a nice thing

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
        child: Column(
          children: [
            Text(widget.user.fName!),
            Text(widget.user.lName!),
            Text(widget.user.userName!),
            Text(widget.user.eMail!),
            Text(widget.user.password!),
          ],
        ),
      ),
    );
  }
}
