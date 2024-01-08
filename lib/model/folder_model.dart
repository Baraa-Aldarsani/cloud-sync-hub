class FolderModel {
  int? id;
  int? ownerId;
  String? name;
  FolderModel({required this.id, required this.name, required this.ownerId});

  factory FolderModel.fromJson(Map<dynamic, dynamic> json,{int addFolder = 0}) {
    if(addFolder == 1){
      return FolderModel(
      id: json['id'],
      name: json['name'],
      ownerId: json['owner_id'],
    );
    }
    return FolderModel(
      id: json['group']['id'],
      name: json['group']['name'],
      ownerId: json['group']['owner_id'],
    );
  }
}
