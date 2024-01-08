// ignore_for_file: avoid_print, unused_local_variable, avoid_web_libraries_in_flutter

import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';
import 'package:cloud_sync_hub/model/model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';

const baseUrl = "http://192.168.43.146:8000/api";
//admin token
// const textToken = "25|YejVYbZY5Ikdp7NoGj5S90jKYRh1f3Fwubnr1pXs29280a04";
//ahmed token
// const textToken = "22|VBXbohEsDsNXveSSaKx4Ti9rupKo4Csa8ncx8IfUbf94dcf0";

class ApiServices {
  static Future<UserModel> signInWithEmailAndPassword(
      String name, String password) async {
    const url = '$baseUrl/login';
    final body = jsonEncode({'name': name, 'password': password});
    final headers = {'Content-Type': 'application/json'};
    final response =
        await http.post(Uri.parse(url), headers: headers, body: body);
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return UserModel.fromJson(responseData);
    } else {
      throw Exception('Error to Login');
    }
  }

  static Future<UserModel> createAccount(
      String firstName,
      String lastName,
      String email,
      String role,
      String password,
      String confirmPassword) async {
    const url = '$baseUrl/register';
    final body = jsonEncode({
      'name': firstName,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password': password,
      'password_confirmation': confirmPassword,
      'role_id': role,
    });
    final headers = {'Content-Type': 'application/json'};
    final response =
        await http.post(Uri.parse(url), headers: headers, body: body);
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return UserModel.fromJson(responseData);
    } else {
      throw Exception('Error to register');
    }
  }

  static Future<List<FolderModel>> getAllFolder() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    final token = sharedPref.getString("token");
    const url = '$baseUrl/allUserGroup';
    final headers = {'Authorization': 'Bearer $token'};
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data
          .map<FolderModel>((json) => FolderModel.fromJson(json))
          .toList();
    } else {
      throw "Faild get data";
    }
  }

  static Future<void> deleteFolder(int id) async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    final token = sharedPref.getString("token");
    const url = '$baseUrl/deleteGroup';
    final headers = {'Authorization': 'Bearer $token'};
    final response = await http.delete(
      Uri.parse(url),
      headers: headers,
      body: {
        "group_id": id.toString(),
      },
    );

    if (response.statusCode == 204 ||
        response.statusCode == 200 ||
        response.statusCode == 201) {
      print("Success Delete Folder");
    } else {
      throw "Faild Delete Folder";
    }
  }

  static Future<FolderModel> addFolder(String name) async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    final token = sharedPref.getString("token");
    const url = '$baseUrl/creatGroup';
    final headers = {'Authorization': 'Bearer $token'};
    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: {
        "name": name,
      },
    );
    if (response.statusCode == 201) {
      return FolderModel.fromJson(json.decode(response.body)['data'],
          addFolder: 1);
    } else {
      throw "Faild Add Folder";
    }
  }

  static Future<List<UserGroupModel>> getAllUserGroup(int groupId) async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    final token = sharedPref.getString("token");
    final url = '$baseUrl/groupUsers?group_id=${groupId.toString()}';
    final headers = {'Authorization': 'Bearer $token'};
    final response = await http.get(
      Uri.parse(url),
      headers: headers,
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data
          .map<UserGroupModel>((json) => UserGroupModel.fromJson(json))
          .toList();
    } else {
      throw "Faild get user group";
    }
  }

  static Future<List<UserGroupModel>> getOrderForUsers(int groupId) async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    final token = sharedPref.getString("token");
    final url =
        '$baseUrl/displayUserRequestForGroup?group_id=${groupId.toString()}';
    final headers = {'Authorization': 'Bearer $token'};
    final response = await http.get(
      Uri.parse(url),
      headers: headers,
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);

      if (jsonData.containsKey('data') && jsonData['data'] != null) {
        final List<dynamic> data = jsonData['data'];

        if (data.isNotEmpty) {
          return data
              .map<UserGroupModel>((json) => UserGroupModel.fromJson(json))
              .toList();
        } else {
          return [];
        }
      } else {
        print("Invalid data format in the response");
        return [];
      }
    } else {
      throw "Faild get user group";
    }
  }

  static Future<void> deleteUserInGroup(UserGroupModel userGroupModel) async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    final token = sharedPref.getString("token");
    const url = '$baseUrl/deleteUserFromGroup';
    final headers = {'Authorization': 'Bearer $token'};
    final response = await http.delete(Uri.parse(url), headers: headers, body: {
      "group_id": userGroupModel.groupId.toString(),
      "user_id": userGroupModel.id.toString(),
    });
    print("group_id ${userGroupModel.groupId}");
    print("group_id ${userGroupModel.id}");

    if (response.statusCode == 405) {
      print("Success delete user in group");
    } else {
      throw "Faild delete user in group";
    }
  }

  static Future<List<UserOwnedGroupModel>> getOwner() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    final token = sharedPref.getString("token");
    const url = '$baseUrl/allUserOwnedGroups';
    final headers = {'Authorization': 'Bearer $token'};
    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data
          .map<UserOwnedGroupModel>(
              (json) => UserOwnedGroupModel.fromJson(json))
          .toList();
    } else {
      throw "Faild get owner for group";
    }
  }

  static Future<List<FileModel>> getFile() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    final token = sharedPref.getString("token");
    const url = '$baseUrl/allUserFiles';
    final headers = {'Authorization': 'Bearer $token'};
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data.map<FileModel>((json) => FileModel.fromJson(json)).toList();
    } else {
      throw "Faild get Files";
    }
  }

  static Future<List<FileModel>> getFileInGroup(FolderModel folderModel) async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    final token = sharedPref.getString("token");
    final url = '$baseUrl/allGroupFiles?group_id=${folderModel.id.toString()}';
    final headers = {'Authorization': 'Bearer $token'};
    final response = await http.get(
      Uri.parse(url),
      headers: headers,
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data.map<FileModel>((json) => FileModel.fromJson(json)).toList();
    } else {
      throw "Faild get Files in Group";
    }
  }

  static Future<void> addFilInGroup(Uint8List file, int folderId,
      String fileName, String fileExtension) async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    final token = sharedPref.getString("token");
    const url = '$baseUrl/uploadFileToGroup';

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers['Authorization'] = 'Bearer $token';
    request.fields['group_id'] = folderId.toString();

    var multipartFile = http.MultipartFile.fromBytes('file', file.toList(),
        filename: '$fileName.$fileExtension',
        contentType: MediaType(fileName, fileExtension));
    request.files.add(multipartFile);

    var response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("success add File");
    } else {
      print("Error to add File");
    }
  }

  static Future<void> checkIn(int fileId) async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    final token = sharedPref.getString("token");
    const url = '$baseUrl/checkIn';
    final headers = {'Authorization': 'Bearer $token'};
    final response = await http.post(Uri.parse(url), headers: headers, body: {
      "file_id": fileId.toString(),
    });
    if (response.statusCode == 200) {
      print("Success Check IN");
    } else {
      throw "Faild Check In";
    }
  }

  static Future<void> checkOut(int fileId) async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    final token = sharedPref.getString("token");
    const url = '$baseUrl/checkOut';
    final headers = {'Authorization': 'Bearer $token'};
    final response = await http.post(Uri.parse(url), headers: headers, body: {
      "file_id": fileId.toString(),
    });
    if (response.statusCode == 200) {
      print("Success Check Out");
    } else {
      throw "Faild Check Out";
    }
  }

  static Future<void> deleteFile(int fileId) async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    final token = sharedPref.getString("token");
    const url = '$baseUrl/deleteFile';
    final headers = {'Authorization': 'Bearer $token'};
    final response = await http.delete(Uri.parse(url), headers: headers, body: {
      "file_id": fileId.toString(),
    });
    if (response.statusCode == 200) {
      print("Success Delete File");
    } else {
      throw "Faild Delete File";
    }
  }

  static Future<List<AllUserModel>> getAllUser() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    final token = sharedPref.getString("token");
    const url = '$baseUrl/displayAllUser';
    final headers = {'Authorization': 'Bearer $token'};
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data
          .map<AllUserModel>((json) => AllUserModel.fromJson(json))
          .toList();
    } else {
      throw "Faild get all user";
    }
  }

  static Future<List<AllGroupModel>> getAllGroup() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    final token = sharedPref.getString("token");
    const url = '$baseUrl/displayAllGroups';
    final headers = {'Authorization': 'Bearer $token'};
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data
          .map<AllGroupModel>((json) => AllGroupModel.fromJson(json))
          .toList();
    } else {
      throw "Faild get all group";
    }
  }

  static Future<void> acceptOrder(UserGroupModel orderModel) async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    final token = sharedPref.getString("token");
    const url = '$baseUrl/creatGroup';
    final headers = {'Authorization': 'Bearer $token'};
    final response = await http.post(Uri.parse(url), headers: headers, body: {
      "group_id": orderModel.groupId.toString(),
      "user_id": orderModel.id.toString(),
    });
    if (response.statusCode == 200) {
    } else {
      throw "Faild accept order";
    }
  }

  static Future<void> unAcceptOrder(UserGroupModel orderModel) async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    final token = sharedPref.getString("token");
    const url = '$baseUrl/unAcceptedRequest';
    final headers = {'Authorization': 'Bearer $token'};
    final response = await http.post(Uri.parse(url), headers: headers, body: {
      "group_id": orderModel.groupId.toString(),
      "user_id": orderModel.id.toString(),
    });
    if (response.statusCode == 200) {
    } else {
      throw "Faild un accept order";
    }
  }

  static Future<void> joinToGroup(AllGroupModel group) async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    final token = sharedPref.getString("token");
    const url = '$baseUrl/RequestToJoinGroup';
    final headers = {'Authorization': 'Bearer $token'};
    final response = await http.post(Uri.parse(url), headers: headers, body: {
      "group_id": group.id.toString(),
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("A request to join has been sent");
    } else {
      throw json.decode(response.body)['message'];
    }
  }

  static Future<void> downloadFile(FileModel fileModel) async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    final token = sharedPref.getString("token");
    final url = Uri.parse('$baseUrl/downloadFile');

    final data = {'file_id': fileModel.id.toString()};
    print(fileModel.id.toString());
    try {
      final response = await http.post(
        url,
        body: data,
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        print("Request succeeded");

        final Uint8List fileContent = Uint8List.fromList(response.bodyBytes);

        final blob = html.Blob([fileContent]);

        final url = html.Url.createObjectUrlFromBlob(blob);
        final anchor = html.AnchorElement(href: url)
          ..target = 'blank'
          ..download = '${fileModel.name}.${fileModel.extension}';
        html.document.body!.children.add(anchor);

        anchor.click();

        html.document.body!.children.remove(anchor);

        html.Url.revokeObjectUrl(url);

        print('File downloaded successfully');
      } else {
        print('Error downloading file: ${response.statusCode}');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }

  static Future<List<ReportModel>> getAllReport() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    final token = sharedPref.getString("token");
    const url = '$baseUrl/showReport';
    final headers = {'Authorization': 'Bearer $token'};
    final response = await http.get(Uri.parse(url), headers: headers);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['file_events'];
      return data
          .map<ReportModel>((json) => ReportModel.fromJson(json))
          .toList();
    } else {
      throw "Faild Load Report";
    }
  }
}
