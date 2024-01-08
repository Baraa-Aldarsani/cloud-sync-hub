class UserGroupModel {
  int? id;
  String? firstName;
  String? name;
  String? lastName;
  String? email;
  int? roleId;
  int? groupId;
  UserGroupModel({
    required this.groupId,
    required this.id,
    required this.name,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.roleId,
  });

  factory UserGroupModel.fromJson(Map<dynamic, dynamic> json,
      {bool report = false}) {
    if (report) {
      return UserGroupModel(
        groupId: 0, 
        id: json['id'],
        name: json['name'],
        email: json['email'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        roleId: json['role_id'],
      );
    }
    return UserGroupModel(
      groupId: json['group_id'],
      id: json['user']['id'],
      name: json['user']['name'],
      email: json['user']['email'],
      firstName: json['user']['first_name'],
      lastName: json['user']['last_name'],
      roleId: json['user']['role_id'],
    );
  }
}
