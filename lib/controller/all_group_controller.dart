// ignore_for_file: avoid_print

import 'package:cloud_sync_hub/model/model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class AllGroupController extends GetxController {
  var allGroup = <AllGroupModel>[].obs;

  Future<void> getAllGroup() async {
    try {
      final fetchData = await ApiServices.getAllGroup();
      allGroup.assignAll(fetchData);
    } catch (e) {
      print(e);
    }
  }

  Future<void> joinToGroup(AllGroupModel group) async {
    try {
       await ApiServices.joinToGroup(group);
      Get.snackbar(
        "A request to join has been sent",
        'Wait until the application is accepted',
        backgroundColor: Colors.blue,
        snackPosition: SnackPosition.TOP,
        maxWidth: 500,
      );
    } catch (e) {
      print(e);
      Get.snackbar(
        e.toString(),
        'The file isn’t pre-booked.',
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.TOP,
        maxWidth: 500,
      );
    }
  }
}
