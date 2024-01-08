import 'model.dart';

class ReportModel {
  int? id;
  String? details;
  FileModel? fileModel;
  UserGroupModel? userModel;
  EventTypeModel? eventType;

  ReportModel({
    required this.id,
    required this.details,
    required this.fileModel,
    required this.userModel,
    required this.eventType,
  });

  factory ReportModel.fromJson(Map<dynamic, dynamic> json) {
    return ReportModel(
      id: json['id'],
      details: '',
      fileModel: FileModel.fromJson(json['file']),
      userModel: UserGroupModel.fromJson(json['user'], report: true),
      eventType: EventTypeModel.fromJson(json['event_type']),
    );
  }
}
