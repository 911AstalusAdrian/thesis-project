import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model/trip_model.dart';
import '../server/server.dart';
import '../widgets/profileCard.dart';
import 'editTripScreen.dart';

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
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('${snapshot.error} occured'));
                } else if (snapshot.hasData) {
                  List<Map<String, dynamic>> data = snapshot.data!;
                  if (data.isEmpty) {
                    return const Center(
                        child: Text("You have no trips planned yet!"));
                  } else {
                    return SizedBox(
                      height: 300,
                      child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                                title: Text(data[index]['location']),
                                subtitle: Text(data[index]['transportation']),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.share),
                                    ),
                                    IconButton(
                                      onPressed: () => _openEditScreen(context, data[index]),
                                      icon: const Icon(Icons.edit_sharp),
                                    ),
                                    IconButton(
                                      onPressed: () => _confirmTripDelete(context, data[index]['tripID']),
                                      icon: const Icon(
                                          Icons.delete_outline_sharp,
                                          color: Colors.red),
                                    ),
                                  ],
                                ));
                          }),
                    );
                  }
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
        ),
      ],
    );
  }

  _openEditScreen(BuildContext context, Map<String, dynamic> tripData){
    String tripID = tripData['tripID'];

    tripData['endDate'] = tripData['endDate'].toDate();
    tripData['startDate'] = tripData['startDate'].toDate();

    BasicTripModel basicTrip = BasicTripModel.fromJson(tripData);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => EditTripScreen(tripID: tripID, tripModel: basicTrip)));
  }

  _confirmTripDelete(BuildContext context, String tripID) {
    AlertDialog alert = AlertDialog(
      title: const Text("Are you sure you want to delete your Trip?"),
      actions: [
        TextButton(
            onPressed: () {
              server.deleteTrip(tripID);
              Navigator.of(context).pop();
              setState(() {});
            },
            child: const Text("Yes")),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("No"))
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
