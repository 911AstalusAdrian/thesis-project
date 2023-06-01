import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../server/server.dart';
import '../widgets/profileCard.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final String uid = Server.getUID();
  CollectionReference users = FirebaseFirestore.instance.collection("Users");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: FutureBuilder<DocumentSnapshot>(
            future: users.doc(uid).get(), // the only way this thing works
            builder:
                (BuildContext ctx, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('${snapshot.error} occurred'));
              } else if (snapshot.hasData) {
                final data = snapshot.data!;

                return SafeArea(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: ProfileCard(data: data)),
                      TextButton(
                          onPressed: () {},
                          child: const Text("Change password"))
                    ],
                  ));

                // return ProfileCard(data: data);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }
}
