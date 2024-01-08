// ignore_for_file: avoid_print

import 'package:cloud_sync_hub/controller/controller.dart';
import 'package:cloud_sync_hub/model/model.dart';
import 'package:get/get.dart';

class AllUserController extends GetxController {
  var allUser = <AllUserModel>[].obs;

  Future<void> getAllUser() async {
    try {
      final fetchData = await ApiServices.getAllUser();
      allUser.assignAll(fetchData);
    } catch (e) {
      print(e);
    }
  }
}
