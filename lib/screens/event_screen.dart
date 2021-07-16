import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/event_detail.dart';

class EventScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event'),
      ),
      body: EventList(),
    );
  }
}

class EventList extends StatefulWidget {
  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  List<EventDetail> details = [];

  @override
  void initState() {
    getDetailsList().then((data) {
      setState(() {
        details = data;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: (details != null) ? details.length : 0,
      itemBuilder: (context, position) {
        String sub =
            'Date: ${details[position].date} - Start: ${details[position].startTime} - End: ${details[position].endTime}';
        return ListTile(
          //title: Text('${details[position].description}'),
          title: Text('description'),
          subtitle: Text(sub),
        );
      },
    );
  }

  Future<List<EventDetail>> getDetailsList() async {
    var data = await db.collection('event_details').get();
    if (data != null) {
      details =
          data.docs.map((document) => EventDetail.fromMap(document)).toList();
      int i = 0;
      details.forEach((detail) {
        detail.id = data.docs[i].id;
        i++;
      });
    }
    return details;
  }
}
