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
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  CollectionReference users = FirebaseFirestore.instance.collection("Users");

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
      child: FutureBuilder<DocumentSnapshot>(
          future: users.doc(uid).get(), // the only way this thing works
          builder: (BuildContext ctx, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator()); }
            else if (snapshot.hasError) {
              return Center(child: Text( '${snapshot.error} occurred'));}
            else if (snapshot.hasData) {
              final String data = snapshot.data!.get("eMail");
              return Center(
                child: Text(
                  data,
                  style: TextStyle(fontSize: 18),
                ),
              );
            }
            else { return const Center(child: CircularProgressIndicator()); }
          })
    );
  }

}
