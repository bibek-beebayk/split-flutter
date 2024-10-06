class Event {
  final int? id;
  final String title;
  final String? description;
  final String date;

  Event({this.id, required this.title, this.description, required this.date});

  Map<String, dynamic> toJSON() {
    return {'id': id, 'title': title, "description": description, "date": date};
  }

  static Event fromJSON(Map<String, dynamic> map) {
    return Event(
        id: map["id"],
        title: map["title"],
        description: map["description"],
        date: map["date"]);
  }

  @override
  String toString() {
    return "Event{id: $id, title: $title}";
  }
}
