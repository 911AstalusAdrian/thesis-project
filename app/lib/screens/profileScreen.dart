import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import '../model/trip_model.dart';
import '../firebaseHandler.dart';
import '../widgets/profileCard.dart';
import 'editTripScreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  FirebaseHandler handler = FirebaseHandler();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
                child: FutureBuilder(
                    future: handler.getUserData(),
                    builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(
                            child: Text('${snapshot.error} occurred'));
                      } else if (snapshot.hasData) {
                        Map<String, dynamic> data =
                            snapshot.data! as Map<String, dynamic>;
                        return ProfileCard(
                            data: data, onDataChanged: () => setState(() {}));
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    })),
            Center(
              child: FutureBuilder(
                  future: handler.getOwnedTrips(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
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
                          height: 450,
                          child: ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (BuildContext context, int index) {
                                String title = data[index]['title'];
                                String location = data[index]['location'];

                                return ListTile(
                                    title: Text(title == "Default Trip"
                                        ? "Trip to $location"
                                        : title),
                                    subtitle:
                                        Text(data[index]['transportation']),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          onPressed: () => _shareTrip(context),
                                          icon: const Icon(Icons.share),
                                        ),
                                        IconButton(
                                          onPressed: () => _openEditScreen(
                                              context, data[index]),
                                          icon: const Icon(Icons.edit_sharp),
                                        ),
                                        IconButton(
                                          onPressed: () => _confirmTripDelete(
                                              context, data[index]['tripID']),
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
        ),
      ),
    );
  }

  _shareTrip(BuildContext context) {
    List<Map<String, String>> usersAndAccess = [];
    TextEditingController usernameCtrl = TextEditingController();
    String selectedAccess = "";

    AlertDialog shareDialog = AlertDialog(
      title: const Text("Choose who to share this Trip with"),
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter state) {
          return SingleChildScrollView(
            child: SizedBox(
              width: double.maxFinite,
              height: 300,
              child: Center(
                  child: Column(
                children: [
                  TextField(
                    controller: usernameCtrl,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                      onPressed: () {
                        String username = usernameCtrl.text;
                        Map<String, String> fMap = {username: selectedAccess};
                        usersAndAccess.add(fMap);
                        setState(() {});
                      },
                      icon: const Icon(Icons.add),
                    )),
                  ),
                  DropdownSearch<String>(
                    items: const ["Viewer", "Participant"],
                    onChanged: (value) {
                      setState(() {
                        selectedAccess = value ?? "";
                      });
                    },
                  ),
                  Expanded(
                      child: ListView.builder(
                    itemCount: usersAndAccess.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      return ListTile(
                        title: Text(usersAndAccess[index]['username']!),
                        subtitle: Text(usersAndAccess[index]['access']!),
                      );
                    },
                  ))
                ],
              )),
            ),
          );
        },
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Send Invites")),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancel"))
      ],
    );

    showDialog(
        context: context, builder: (BuildContext context) => shareDialog);
  }

  _openEditScreen(BuildContext context, Map<String, dynamic> tripData) {
    String tripID = tripData['tripID'];

    BasicTripModel basicTrip = BasicTripModel.fromJson(tripData);
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (context) =>
                EditTripScreen(tripID: tripID, tripModel: basicTrip)))
        .then((value) {
      setState(() {});
    });
  }

  _confirmTripDelete(BuildContext context, String tripID) {
    AlertDialog alert = AlertDialog(
      title: const Text("Are you sure you want to delete your Trip?"),
      actions: [
        TextButton(
            onPressed: () {
              handler.deleteTrip(tripID);
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
