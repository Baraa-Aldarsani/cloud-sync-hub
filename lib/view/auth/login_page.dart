// ignore_for_file: must_be_immutable

import 'package:cloud_sync_hub/controller/auth_controller.dart';
import 'package:cloud_sync_hub/core/core.dart';
import 'package:cloud_sync_hub/view/auth/register_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
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
            width: 500,
            height: 400,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Row(
              children: [
                Image.asset(
                  width: 250,
                  height: 400,
                  "assets/images/auth2.png",
                  fit: BoxFit.fill,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        "LOGIN",
                        style: TextStyle(
                            fontSize: 36,
                            color: ColorPalette.primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 200,
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                          controller: controller.usernameController,
                          decoration: const InputDecoration(
                            hintText: "Username",
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
                      const SizedBox(
                        height: 10,
                      ),
                      Obx(
                        () => InkWell(
                          onTap: () {
                            if (formstate.currentState!.validate()) {
                              controller.circle.value = true;
                              controller.signInWithEmailAndPassword();
                            }
                          },
                          child: Container(
                            width: 200,
                            height: 40,
                            padding: const EdgeInsets.symmetric(vertical: 8),
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
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(RegisterPage());
                        },
                        child: Container(
                          width: 100,
                          height: 25,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                              color: ColorPalette.primaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          child: const Text(
                            "Register",
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
