import 'package:app/model/trip_model.dart';
import 'package:app/screens/itineraryScreen.dart';
import 'package:app/widgets/fancyText.dart';
import 'package:flutter/material.dart';

import '../firebaseHandler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseHandler handler = FirebaseHandler();

  final String uid = FirebaseHandler.getUID();

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
              future: handler.getName(),
              builder: (BuildContext ctx, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  String name = snapshot.data!;
                  return FancyText(text: "Hello, $name!");
                } else {
                  return const Center(child: Text("Please wait..."));
                }
              },
            ),
            const FancyText(text: "Here's how your upcoming Trips look like:"),
            Container(
              child: FutureBuilder(
                  future: handler.getOngoingAndFutureTrips(),
                  builder: (BuildContext ctx, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('${snapshot.error} has occurred'));
                    } else if (snapshot.hasData) {
                      List<Map<String, dynamic>> data = snapshot.data!;
                      if (data.isEmpty) {
                        return const Center(
                            child: Text("You have to Trips planned yet!"));
                      } else {
                        return SizedBox(
                          height: 600,
                          child: ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (BuildContext ctx, int index) {

                                DateTime currentDate = DateTime.now();
                                currentDate = DateTime(currentDate.year, currentDate.month, currentDate.day);
                                DateTime startDate = data[index]['startDate'].toDate();
                                int noOfDays = startDate.difference(currentDate).inDays;
                                bool ongoing = data[index]['ongoing'];

                                return ListTile(
                                  leading: const Icon(Icons.flight_takeoff),
                                  title: Text(data[index]['title']),
                                  subtitle: ongoing == true
                                      ? const Text("ONGOING")
                                      : noOfDays == 0
                                          ? const Text("Today")
                                          : Text("$noOfDays day(s) left"),
                                  trailing: TextButton(
                                    onPressed: () {
                                      String tripID = data[index]['tripID'];
                                      BasicTripModel trip = BasicTripModel.fromJson(data[index]);
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context) => ItineraryScreen(tripID: tripID, trip: trip)));
                                    },
                                    child: const Text("View Itinerary"),
                                  ),
                                );
                              }),
                        );
                      }
                    } else {
                      return const Center(child: Text("Yeah what happened here"));
                    }
                  }),
            )
          ],
        ),
      )
    );
  }
}
