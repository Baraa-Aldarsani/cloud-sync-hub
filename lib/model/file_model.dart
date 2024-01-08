class FileModel {
  int? id;
  String? name;
  String? extension;
  String? path;
  int? groupId;
  int? userId;
  bool? isActive;
  bool? isReserved;
  FileModel({
    required this.id,
    required this.name,
    required this.extension,
    required this.path,
    required this.groupId,
    required this.userId,
    required this.isActive,
    required this.isReserved,
  });
  factory FileModel.fromJson(Map<dynamic, dynamic> json) {
    return FileModel(
      id: json['id'],
      name: json['name'],
      extension: json['extension'],
      path: json['path'],
      groupId: json['group_id'],
      userId: json['user_id'],
      isActive: json['is_active'],
      isReserved: json['is_reserved'],
    );
  }
}
