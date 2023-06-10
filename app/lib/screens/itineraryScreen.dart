import 'package:app/model/trip_model.dart';
import 'package:app/widgets/fancyText.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:grouped_list/grouped_list.dart';
import '../server/server.dart';

class ItineraryScreen extends StatefulWidget {
  const ItineraryScreen({Key? key, required this.tripID}) : super(key: key);

  final String tripID;

  @override
  State<ItineraryScreen> createState() => _ItineraryScreenState();
}

class _ItineraryScreenState extends State<ItineraryScreen> {
  Server server = Server();
  BasicTripModel? trip;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _initializeData();
    List<String> dates = getDates(trip!.startDate, trip!.endDate);

    List<Map<String, dynamic>> groupedData = dates.map((date) {
      return {'group': date, 'items': []};
    }).toList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Itinerary of ${trip!.title}"),
      ),
      body: SafeArea(
        child: GroupedListView<dynamic, String>(
          elements: groupedData,
          groupBy: (item) => item['group'],
          groupSeparatorBuilder: (String date) {
            return ListTile(
                leading: const Icon(Icons.calendar_today),
                title: Text(date),
                trailing: IconButton(
                    onPressed: () { _addToItinerary(date); },
                    icon: const Icon(Icons.add, color: Colors.orangeAccent)
                )
            );
          },
          itemBuilder: (BuildContext context, dynamic item){
            List<dynamic> data = item['items'];
            return Column(
              children: data.map( ((item) => Text(item))).toList(),
            );
          },
        ),
      ),
    );
  }

  List<String> getDates(DateTime startDate, DateTime endDate) {
    List<String> dates = [];

    DateTime currentDate = startDate;
    while (currentDate.isBefore(endDate)) {
      String formattedDate = DateFormat("dd/MM/yyyy").format(currentDate);
      dates.add(formattedDate);
      currentDate = currentDate.add(const Duration(days: 1));
    }

    if (DateUtils.isSameDay(currentDate, endDate)) {
      String formattedDate = DateFormat("dd/MM/yyyy").format(currentDate);
      dates.add(formattedDate);
    }

    return dates;
  }

  _addToItinerary(String date){
    print("add");
  }

  _initializeData() async {
    Map<String, dynamic> tripData = await server.getTripDetails(widget.tripID);
    trip = BasicTripModel.fromJson(tripData);
    setState(() {});
  }
}
