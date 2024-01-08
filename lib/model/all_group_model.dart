class AllGroupModel {
  int? id;
  String? name;
  int? ownerId;

  AllGroupModel({
    required this.id,
    required this.name,
    required this.ownerId,
  });

  factory AllGroupModel.fromJson(Map<dynamic, dynamic> json) {
    return AllGroupModel(
      id: json['id'],
      name: json['name'],
      ownerId: json['owner_id'],
    );
  }
}
