// ignore_for_file: avoid_print

import 'package:cloud_sync_hub/controller/controller.dart';
import 'package:cloud_sync_hub/core/core.dart';
import 'package:cloud_sync_hub/model/model.dart';
import 'package:cloud_sync_hub/view/controle_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  RxBool circle = false.obs;
  Future<void> signInWithEmailAndPassword() async {
    final name = usernameController.text;
    final password = passwordController.text;
    try {
      final UserModel user =
          await ApiServices.signInWithEmailAndPassword(name, password);
      _saveToken(user.token.toString());
      Get.offAll( ControlView());
    } catch (e) {
      circle.value = false;
      usernameController.clear();
      passwordController.clear();
      update();
      Get.snackbar(
        'Login failed',
        'Please try again.',
        backgroundColor: ColorPalette.scondaryColor,
        snackPosition: SnackPosition.BOTTOM,
        maxWidth: 500,
      );
      print(e.toString());
    }
  }

  Future<void> createAccount() async {
    final firstName = usernameController.text;
    final lastName = lastNameController.text;
    final email = emailController.text;
    final role = roleController.text;
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;
    try {
      final UserModel user = await ApiServices.createAccount(
          firstName, lastName, email, role, password, confirmPassword);
      _saveToken(user.token.toString());
      Get.offAll( ControlView());
    } catch (e) {
      circle.value = false;
      usernameController.clear();
      lastNameController.clear();
      emailController.clear();
      roleController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
      update();
      Get.snackbar(
        'Register failed',
        'Please try again.',
        backgroundColor: ColorPalette.scondaryColor,
        snackPosition: SnackPosition.BOTTOM,
        maxWidth: 500,
      );
      print(e.toString());
    }
  }

  _saveToken(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    const key = 'token';
    final value = token;
    preferences.setString(key, value);
  }

  bool isValidEmail(String email) {
    String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regExp = RegExp(emailPattern);
    return regExp.hasMatch(email);
  }

  
}
