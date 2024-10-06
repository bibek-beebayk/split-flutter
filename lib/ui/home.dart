import 'package:flutter/material.dart';
// import 'package:split/data/event/helpers.dart';
// import 'package:split/data/event/model.dart';
import '../data/helpers.dart';
import '../data/models.dart';
import 'add_event.dart';
import 'event_details.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with WidgetsBindingObserver {
  List<Event> events = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadEvents(); // Load events when the page is first built
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // This method gets called when returning to the page after pushing another page
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _loadEvents(); // Refresh events when resuming the page
    }
  }

  void _loadEvents() async {
    final List<Map<String, dynamic>> eventMaps =
        await DatabaseHelper().getEvents();
    setState(() {
      events = eventMaps.map((e) => Event.fromJSON(e)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Events')),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return ListTile(
            title: Text(event.title),
            subtitle: Text(event.date),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EventDetailPage(event: event),
                ),
              ).then((_) {
                _loadEvents(); // Refresh events when returning from event details
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateEditEventPage(),
            ),
          ).then((_) {
            _loadEvents(); // Refresh events when returning from add/edit page
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
