import 'package:flutter/material.dart';
import 'package:split/data/models.dart';
import 'package:split/data/helpers.dart';

class EventDetailPage extends StatelessWidget {
  final Event event;
  // const String eventDate;

  EventDetailPage({required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(event.title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Details for ${event.title}',
                    style: const TextStyle(fontSize: 25),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text("Edit"),
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                      onTap: () {
                        _showDeleteConfirmationDialog(context, event.id);
                      },
                      child: const Text("Delete",
                          style: TextStyle(color: Colors.red))),
                ],
              ),
              // SizedBox(height: 20),
              // ElevatedButton(onPressed: onPressed, child: child),
              Text('${event.description}'),
              Text(event.date),
            ],
          ),
        ));
  }

  // Function to show the delete confirmation dialog
  void _showDeleteConfirmationDialog(BuildContext context, id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this event?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                void deleteEvent() async {
                  await DatabaseHelper().deleteEvent(id);
                } // Call the delete function

                deleteEvent();
                Navigator.pop(context);
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
  }

  // void _deleteEvent(BuildContext context, id) async {
  //   // Add your delete logic here (e.g., remove the event from the database)

  //   // Close the dialog and navigate back to the previous page
  //   // print("context");
  //   await deleteEvent(id);
  //   Navigator.of(context).pop(); // Close the dialog
  //   Navigator.of(context).pop(); // Navigate back to the previous page
  // }
}
