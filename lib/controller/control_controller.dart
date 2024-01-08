// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:cloud_sync_hub/controller/api_services.dart';
import 'package:cloud_sync_hub/model/model.dart';
import 'package:cloud_sync_hub/view/file_in_group_view.dart';
import 'package:cloud_sync_hub/view/view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../core/core.dart';
import 'home_controller.dart';

class ControlController extends GetxController {
  Widget _currentScreen = HomePage();
  get currentScreen => _currentScreen;
  int _navigationbar = 0;
  get navigationValue => _navigationbar;

  void changeSelectedValue(int selected, {FolderModel? folderModel}) {
    _navigationbar = selected;
    update();
    switch (selected) {
      case 0:
        {
          _currentScreen = HomePage();
          break;
        }
      case 1:
        {
          _currentScreen = ReportView();
          break;
        }
      case 2:
        {
          _currentScreen = const SettingPage();
          break;
        }
      case 3:
        {
          _currentScreen = UserView(folderModel: folderModel);
          break;
        }
      case 4:
        {
          _currentScreen = OrderGroupView();
          break;
        }
      case 5:
        {
          _currentScreen = FileInGroupView(folderModel: folderModel);
          break;
        }
      case 6:
        {
          _currentScreen = AllUserView();
          break;
        }
      case 7:
        {
          _currentScreen = AllGroupView();
          break;
        }
    }
  }

  final TextEditingController folderNameController = TextEditingController();

  void openAddFolderDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddFolderDialog();
      },
    );
  }

  Future<void> addFolder() async {
    final String name = folderNameController.text;
    try {
      final newFolder = await ApiServices.addFolder(name);
      folderNameController.clear();
      Get.find<HomeController>().addFolderToFolderList(newFolder);
      update();
    } catch (e) {
      print(e);
      Get.snackbar('This name exists before', 'Please enter another name.',
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.TOP,
          maxWidth: 500,
          colorText: Colors.white);
    }
  }

  // TextEditingController textController = TextEditingController();
  // RxList<String> suggestions = <String>[].obs;

  // void updateSuggestions(String input) {
  //   suggestions.value = suggestionsList
  //       .where(
  //           (element) => element.toLowerCase().startsWith(input.toLowerCase()))
  //       .toList();
  // }

  // List<String> suggestionsList = [
  //   'Item 1',
  //   'Item 2',
  //   'Item 3',
  // ];

  // final searchResults = <AllGroupModel>[].obs;

  // Future<void> searchGroup(String query) async {
  //   try {
  //     // SharedPreferences sharedPref = await SharedPreferences.getInstance();
  //     // final token = sharedPref.getString("token");
  //     final headers = {'Authorization': 'Bearer $textToken'};
  //     final response = await http.get(
  //         Uri.parse('http://192.168.43.146:8000/api/searchGroup?name=$query'),
  //         headers: headers);

  //     if (response.statusCode == 200) {
  //       try {
  //         final List<dynamic> data = jsonDecode(response.body)['data'];
  //         searchResults.assignAll(
  //             data.map((json) => AllGroupModel.fromJson(json)).toList());
  //         print(searchResults.length);
  //       } catch (error) {
  //         print('Error decoding JSON: $error');
  //       }
  //     } else {
  //       throw Exception('Failed to load data');
  //     }
  //   } catch (error) {
  //     print('Error: $error');
  //   }
  // }

  TextEditingController textController = TextEditingController();
  RxList<String> suggestions = <String>[].obs;

  Future<void> searchGroup(String query) async {
    try {
      SharedPreferences sharedPref = await SharedPreferences.getInstance();
      final token = sharedPref.getString("token");
      final headers = {'Authorization': 'Bearer $token'};
      final response = await http.get(
        Uri.parse('http://192.168.43.146:8000/api/searchGroup?name=$query'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        try {
          final List<dynamic> data = jsonDecode(response.body)['data'];
          suggestions.assignAll(
            data.map((json) => json['name'] as String).toList(),
          );
        } catch (error) {
          print('Error decoding JSON: $error');
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> searchUser(String query) async {
    try {
      SharedPreferences sharedPref = await SharedPreferences.getInstance();
      final token = sharedPref.getString("token");
      final headers = {'Authorization': 'Bearer $token'};
      final response = await http.get(
        Uri.parse('http://192.168.43.146:8000/api/searchUser?name=$query'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        try {
          final List<dynamic> data = jsonDecode(response.body)['data'];
          suggestions.assignAll(
            data.map((json) => json['name'] as String).toList(),
          );
        } catch (error) {
          print('Error decoding JSON: $error');
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  void printaa() {
    print("=======================");
  }
}
