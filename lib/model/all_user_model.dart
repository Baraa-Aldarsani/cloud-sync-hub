class AllUserModel {
  int? id;
  String? name;
  String? email;
  String? firstName;
  String? lastName;
  int? roleId;
  AllUserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.roleId,
  });

  factory AllUserModel.fromJson(Map<dynamic, dynamic> json) {
    return AllUserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      roleId: json['role_id'],
    );
  }
}
