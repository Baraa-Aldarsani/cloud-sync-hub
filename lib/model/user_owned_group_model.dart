class UserOwnedGroupModel {
  int? id;
  String? name;
  int? ownerId;
  UserOwnedGroupModel({
    required this.id,
    required this.name,
    required this.ownerId,
  });

  factory UserOwnedGroupModel.fromJson(Map<dynamic, dynamic> json) {
    return UserOwnedGroupModel(
      id: json['id'],
      name: json['name'],
      ownerId: json['owner_id'],
    );
  }
}
