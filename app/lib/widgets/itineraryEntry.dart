import 'package:app/firebaseHandler.dart';
import 'package:app/model/entry_model.dart';
import 'package:app/widgets/fancyText.dart';
import 'package:flutter/material.dart';

class ItineraryEntryWidget extends StatefulWidget {
  const ItineraryEntryWidget({Key? key, required this.tripID, required this.data, required this.onRemove}) : super(key: key);

  final VoidCallback onRemove;
  final String tripID;
  final Map<String, dynamic>data;

  @override
  State<ItineraryEntryWidget> createState() => _ItineraryEntryWidgetState();
}

class _ItineraryEntryWidgetState extends State<ItineraryEntryWidget> {

  FirebaseHandler handler = FirebaseHandler();

  @override
  Widget build(BuildContext context) {
    ItineraryEntry entry = ItineraryEntry.fromJson(widget.data);
    String entryID = widget.data['entryID'];
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
          setState(() {
            handler.removeEntry(widget.tripID, entryID);
            widget.onRemove();
          });
      },
      background: Container(
        alignment: Alignment.centerRight,
        color: Colors.red,
        child: const Icon(Icons.cancel_outlined),
      ),
      child:  ListTile(
          leading: Column(
            children: [
              Text(entry.startTime.toString()),
              const Text("|"),
              Text(entry.endTime.toString())
            ],
          ),
          title: FancyText(text: entry.title),
          subtitle: FancyText(text:entry.description, fontSize: 14.0),
        ),
    );
  }
}
