class EventTypeModel {
  int? id;
  String? name;
  String? description;

  EventTypeModel({
    required this.id,
    required this.name,
    required this.description,
  });
  factory EventTypeModel.fromJson(Map<dynamic, dynamic> json) {
    return EventTypeModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }
}
