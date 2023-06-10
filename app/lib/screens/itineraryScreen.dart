import 'package:app/model/entry_model.dart';
import 'package:app/model/trip_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:grouped_list/grouped_list.dart';
import '../server/server.dart';

class ItineraryScreen extends StatefulWidget {
  const ItineraryScreen({Key? key, required this.tripID, required this.trip}) : super(key: key);

  final String tripID;
  final BasicTripModel trip;

  @override
  State<ItineraryScreen> createState() => _ItineraryScreenState();
}

class _ItineraryScreenState extends State<ItineraryScreen> {
  Server server = Server();
  late BasicTripModel trip;

  @override
  void initState() {
    super.initState();
    trip = widget.trip;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Itinerary of ${trip.title}"),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: server.getItinerary(widget.tripID),
          builder: (BuildContext ctx, AsyncSnapshot<dynamic> snapshot){

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());}
            else if (snapshot.hasError) {
              return Center(child: Text("${snapshot.error} has occurred"));}
            else if (snapshot.hasData){

              List<Map<String, dynamic>> entries = snapshot.data!;
              List<String> dates = getDates(trip.startDate, trip.endDate);
              List<Map<String, dynamic>> groupedData = dates.map((date) {
                return {
                  'group': date,
                  'items': entries.where((element) => element['date'] == date).toList()};
              }).toList();

              return GroupedListView<dynamic, String>(
                elements: groupedData,
                groupBy: (item) => item['group'],
                groupSeparatorBuilder: (String date) {
                  return ListTile(
                      leading: const Icon(Icons.calendar_today),
                      title: Text(date),
                      trailing: IconButton(
                          onPressed: () { _addToItinerary(context, date); },
                          icon: const Icon(Icons.add, color: Colors.orangeAccent)
                      )
                  );
                },
                itemBuilder: (BuildContext context, dynamic item){
                  List<dynamic> data = item['items'];
                  return Column(
                    children: data.map( ((item) => Text(item['title']))).toList(),
                  );
                },
              );
            } else { return const Center(child: Text("TEXT")); }
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

  _addToItinerary(BuildContext context, String date){

    TimeOfDay selectedStartTime = TimeOfDay.now();
    TextEditingController startTimeCtrl = TextEditingController();

    TimeOfDay selectedEndTime = TimeOfDay.now();
    TextEditingController endTimeCtrl = TextEditingController();

    TextEditingController entryTitleCtrl = TextEditingController();
    TextEditingController entryDescCtrl = TextEditingController();

    AlertDialog entryDetails = AlertDialog(
      content: SingleChildScrollView(
        child: Column(
            children: [
              TextField(
                controller: entryTitleCtrl,
                decoration: const InputDecoration(
                    icon: Icon(Icons.text_fields_sharp),
                    hintText: "Give your entry a Title"
                ),
              ),
              TextField(
                controller: entryDescCtrl,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                decoration: const InputDecoration(
                    icon: Icon(Icons.text_fields_sharp),
                    hintText: "Give your entry a Description"
                ),
              ),
              TextField(
                  enabled: false,
                  decoration: InputDecoration(
                      icon: const Icon(Icons.calendar_today),
                      labelText: date)),
              TextField(
                  readOnly: true,
                  controller: startTimeCtrl,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.access_time),
                      labelText: "Start Time"),
                  onTap: () async {
                    TimeOfDay? time = await showTimePicker(
                        context: context,
                        initialTime: selectedStartTime);
                    setState(() {
                      selectedStartTime = time ?? TimeOfDay.now();
                      startTimeCtrl.text = selectedStartTime.format(context);
                    });
                  }
              ),
              TextField(
                  readOnly: true,
                  controller: endTimeCtrl,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.access_time),
                      labelText: "End Time"),
                  onTap: () async {
                    TimeOfDay? time = await showTimePicker(
                        context: context,
                        initialTime: selectedEndTime);
                    setState(() {
                      selectedEndTime = time ?? TimeOfDay.now();
                      endTimeCtrl.text = selectedEndTime.format(context);
                    });
                  }
              )
            ],
          ),
        ),
      actions: [
        TextButton(
          onPressed: () {
            _saveEntry(
              entryTitleCtrl.text,
              entryDescCtrl.text,
              date,
              selectedStartTime,
              selectedEndTime
            );
            Navigator.of(context).pop();
          },
          child: const Text("Add Entry"),
        )
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext ctx) => entryDetails);
  }


  _saveEntry(String title, String desc, String date, TimeOfDay start, TimeOfDay end){
    ItineraryEntry entry = ItineraryEntry(
        title: title,
        description: desc,
        date: date,
        startTime: start.format(context),
        endTime: end.format(context));

    server.addEntry(widget.tripID, entry);
    setState(() {});

  }

}
