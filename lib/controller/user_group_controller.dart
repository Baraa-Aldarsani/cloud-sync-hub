// ignore_for_file: avoid_print

import 'package:cloud_sync_hub/controller/api_services.dart';
import 'package:cloud_sync_hub/model/model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserGroupController extends GetxController {
  var userGroup = <UserGroupModel>[].obs;
  var orderUser = <UserGroupModel>[].obs;

  Future<void> getUserGroup(FolderModel folder) async {
    try {
      final fetch = await ApiServices.getAllUserGroup(folder.id!);
      userGroup.assignAll(fetch);
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteUserInGroup(UserGroupModel userGroupModel) async {
    try {
      await ApiServices.deleteUserInGroup(userGroupModel);
      userGroup.removeWhere((userGroup) => userGroup.id == userGroupModel.id);
      update();
    } catch (e) {
      print(e);
      Get.snackbar('This user cannot be deleted', 'He’s an admin in the group.',
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.TOP,
          maxWidth: 500,
          colorText: Colors.white);
    }
  }

  Future<void> getOrderForUsers(FolderModel? folder) async {
    try {
      final fetch =
          await ApiServices.getOrderForUsers(folder?.id == 0 ? 0 : folder!.id!);
      orderUser.assignAll(fetch);
      update();
    } catch (e) {
      print(e);
    }
  }

  Future<void> acceptOrder(UserGroupModel orderModel) async {
    try {
      await ApiServices.acceptOrder(orderModel);
      orderUser.removeWhere((orderUser) => orderUser.id == orderModel.id);
      update();
    } catch (e) {
      print(e);
    }
  }

  Future<void> unAcceptOrder(UserGroupModel orderModel) async {
    try {
      await ApiServices.unAcceptOrder(orderModel);
      orderUser.removeWhere((orderUser) => orderUser.id == orderModel.id);
      update();
    } catch (e) {
      print(e);
    }
  }
}
