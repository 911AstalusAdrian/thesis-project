import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../model/User.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);


  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}



class _ProfileScreenState extends State<ProfileScreen> {

  final _secureStorage = FlutterSecureStorage();
  User user = User();

  Future<User> getUserFuture() async{
    return User.deserialize(await _secureStorage.read(key: 'connected_user'));
  }

  getUser() {
    getUserFuture().then((result) {
      setState(() {
        user = result;
      });
    });
  }

  @override
  void initState(){
    super.initState();
    getUser();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: Investigate why do I get a Stack Overflow if I try to create the card as a Stateless Widget
    // TODO  in Scaffold, tried the following: body : ProfileCard(user: widget.user)
    // TODO can do without a widget but it would be a nice thing

    getUser();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
        child: Column(
          children: [
            Text(user.fName!),
            Text(user.lName!),
            Text(user.userName!),
            Text(user.eMail!),
            Text(user.password!),
          ],
        ),
      ),
    );
  }
}
