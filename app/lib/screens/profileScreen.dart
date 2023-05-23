import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../model/user_model.dart';
import '../server/server.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);


  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}



class _ProfileScreenState extends State<ProfileScreen> {

  Server server = Server();
  final _secureStorage = const FlutterSecureStorage();
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState(){
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: Investigate why do I get a Stack Overflow if I try to create the card as a Stateless Widget
    // TODO  in Scaffold, tried the following: body : ProfileCard(user: widget.user)
    // TODO can do without a widget but it would be a nice thing

    return Center(
      child: FutureBuilder(
          future: server.getUserFromUid(uid),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              print("Waiting");
              print(snapshot.data);
              return const Center(child: Text("Waiting")); }
            else if (snapshot.hasError) {
              print(snapshot.data);
              print("Error");
              return Center(child: Text( '${snapshot.error} occurred'));}
            else if (snapshot.hasData) {
              print(snapshot.data);
              final data = snapshot.data;
              print(data);
              return const Center(
                child: Text(
                  "Text",
                  style: TextStyle(fontSize: 18),
                ),
              );
            }
            else {
              return const Center(child: CircularProgressIndicator()); }
          })
    );
  }

}
