import 'package:flutter/material.dart';
import 'package:split/data/helpers.dart';
import 'package:split/data/models.dart';
import 'package:intl/intl.dart';

class CreateEditEventPage extends StatefulWidget {
  final Event? event;

  const CreateEditEventPage({super.key, this.event});

  @override
  CreateEditEventPageState createState() => CreateEditEventPageState();
}

class CreateEditEventPageState extends State<CreateEditEventPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.event != null) {
      _titleController.text = widget.event!.title;
      _descriptionController.text = widget.event?.description ?? "";
      _dateController.text = widget.event!.date;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create/Edit Event')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Event Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration:
                    const InputDecoration(labelText: 'Event Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(labelText: 'Event Date'),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a date';
                  }
                  return null;
                },
                onTap: () async {
                  await openDatePicker(context: context); // Wrap in a closure
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Save event data
                    void saveEvent() async {
                      final event = Event(
                          title: _titleController.text,
                          description: _descriptionController.text,
                          date: _dateController.text);
                      await DatabaseHelper().insertEvent(event.toJSON());
                    }

                    saveEvent();
                    Navigator.pop(context, true);
                  }
                },
                child: const Text('Save Event'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  openDatePicker({required BuildContext context}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2015),
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
    );

    if (pickedDate != null) {
      _dateController.text = DateFormat("yyyy-MM-dd").format(pickedDate);
    }
  }
}
