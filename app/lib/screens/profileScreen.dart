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
  Server server = Server();
  CollectionReference users = FirebaseFirestore.instance.collection("Users");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
            child: FutureBuilder<DocumentSnapshot>(
                future: users.doc(uid).get(), // the only way this thing works
                builder: (BuildContext ctx,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
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
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                })),
        Center(
          child: FutureBuilder(
            future: server.getTrips(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting) { return const Center(child: CircularProgressIndicator()); }
              else if (snapshot.hasError) { return Center(child: Text('${snapshot.error} occured')); }
              else if (snapshot.hasData) {
                List<Map<String, dynamic>> data = snapshot.data!;
                return SizedBox(
                  height: 300,
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                            title: Text(data[index]['location']),
                            subtitle: Text(data[index]['transportation'])
                        );
                      }),
                );
              }
              else { return const Center(child: CircularProgressIndicator());}
            }),
        ),
      ],
    );
  }
}
