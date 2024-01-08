// ignore_for_file: must_be_immutable

import 'package:cloud_sync_hub/controller/controller.dart';
import 'package:cloud_sync_hub/core/core.dart';
import 'package:cloud_sync_hub/view/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  final controller = Get.put(AuthController());
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.primaryColor,
      body: Form(
        key: formstate,
        child: Center(
          child: Container(
            width: 1000,
            height: 600,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Row(
              children: [
                Image.asset(
                  width: 500,
                  height: 600,
                  "assets/images/auth2.png",
                  fit: BoxFit.fill,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 80),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Register",
                        style: TextStyle(
                            fontSize: 48,
                            color: ColorPalette.primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 200,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your first name';
                                }
                                return null;
                              },
                              controller: controller.usernameController,
                              decoration: const InputDecoration(
                                hintText: "First Name",
                                suffixIconColor: ColorPalette.primaryColor,
                                suffixIcon: Icon(Icons.person),
                                hintStyle: TextStyle(
                                  color: ColorPalette.primaryColor,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ColorPalette.primaryColor)),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          SizedBox(
                            width: 200,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your last name';
                                }
                                return null;
                              },
                              controller: controller.lastNameController,
                              decoration: const InputDecoration(
                                hintText: "Last Name",
                                suffixIconColor: ColorPalette.primaryColor,
                                suffixIcon: Icon(Icons.person),
                                hintStyle: TextStyle(
                                  color: ColorPalette.primaryColor,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ColorPalette.primaryColor)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 200,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter an email';
                                }
                                if (!controller.isValidEmail(value)) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                              controller: controller.emailController,
                              decoration: const InputDecoration(
                                hintText: "Email",
                                suffixIconColor: ColorPalette.primaryColor,
                                suffixIcon: Icon(Icons.person),
                                hintStyle: TextStyle(
                                  color: ColorPalette.primaryColor,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ColorPalette.primaryColor)),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          SizedBox(
                            width: 200,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a role';
                                }
                                return null;
                              },
                              controller: controller.roleController,
                              decoration: const InputDecoration(
                                hintText: "Role",
                                suffixIconColor: ColorPalette.primaryColor,
                                suffixIcon: Icon(Icons.roller_shades),
                                hintStyle: TextStyle(
                                  color: ColorPalette.primaryColor,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ColorPalette.primaryColor)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 200,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a password';
                                }
                                if (value.length < 8) {
                                  return 'Password must be at least 8 char';
                                }
                                return null;
                              },
                              controller: controller.passwordController,
                              decoration: const InputDecoration(
                                hintText: "Password",
                                suffixIconColor: ColorPalette.primaryColor,
                                suffixIcon: Icon(Icons.lock),
                                hintStyle: TextStyle(
                                  color: ColorPalette.primaryColor,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ColorPalette.primaryColor)),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          SizedBox(
                            width: 200,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a confirm password';
                                }
                                if (value.length < 8) {
                                  return 'Password must be at least 8 char';
                                }
                                return null;
                              },
                              controller: controller.confirmPasswordController,
                              decoration: const InputDecoration(
                                hintText: "Confirm Password",
                                suffixIconColor: ColorPalette.primaryColor,
                                suffixIcon: Icon(Icons.lock),
                                hintStyle: TextStyle(
                                  color: ColorPalette.primaryColor,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ColorPalette.primaryColor)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          if (formstate.currentState!.validate()) {
                            controller.circle.value = true;
                            controller.createAccount();
                          }
                        },
                        child: Obx(
                          () => Container(
                            width: 300,
                            height: 50,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                                color: ColorPalette.primaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            child: controller.circle.value == true
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    "Register",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22),
                                  ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(LoginPage());
                        },
                        child: Container(
                          width: 150,
                          height: 35,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                              color: ColorPalette.primaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          child: const Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
