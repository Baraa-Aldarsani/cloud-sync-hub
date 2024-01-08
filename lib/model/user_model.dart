// ignore_for_file: unused_label

import 'package:shared_preferences/shared_preferences.dart';

class UserModel {
  String? name;
  String? token;

  UserModel({this.name, this.token});

  UserModel.fromJson(Map<dynamic, dynamic> json) {
    _saveToken(json['data']['token']);
    token:
    json['data']['token'];
  }

  _saveToken(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    const key = 'token';
    final value = token;
    preferences.setString(key, value);
  }
}
