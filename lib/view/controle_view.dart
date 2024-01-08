// ignore_for_file: must_be_immutable

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:cloud_sync_hub/controller/controller.dart';
import 'package:cloud_sync_hub/core/core.dart';
import 'package:cloud_sync_hub/view/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../model/model.dart';

class ControlView extends StatelessWidget {
  ControlView({super.key});
  final GlobalKey tileKeys = GlobalKey();
  FileModel? fileModel;
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ControlController(),
      builder: (controller) => Scaffold(
          backgroundColor: ColorPalette.scondaryColor.withOpacity(0.1),
          body: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.only(left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/logo.png",
                            width: 100,
                            height: 80,
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                left: 10, top: 4, bottom: 4),
                            alignment: Alignment.centerLeft,
                            height: 70,
                            width: 120,
                            child: Shimmer.fromColors(
                              baseColor: Colors.black,
                              highlightColor: ColorPalette.color1,
                              child: const Text(
                                'Cloud Sync Hub',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: 140,
                        height: 60,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.grey, blurRadius: 5)
                            ],
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: InkWell(
                          onTap: () {
                            controller.openAddFolderDialog(context);
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.add,
                                size: 30,
                              ),
                              Text(
                                "New Folder",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w300),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      buildNavigationButton(
                        icon: Icons.home,
                        label: "Home",
                        index: 0,
                        onPressed: () {
                          controller.changeSelectedValue(0);
                        },
                      ),
                      const SizedBox(height: 5),
                      buildNavigationButton(
                        icon: Icons.report,
                        label: "Reports",
                        index: 1,
                        onPressed: () {
                          controller.changeSelectedValue(1);
                        },
                      ),
                      const SizedBox(height: 5),
                      buildNavigationButton(
                        icon: Icons.list_alt,
                        label: "Orders",
                        index: 4,
                        onPressed: () {
                          controller.changeSelectedValue(4);
                        },
                      ),
                      const SizedBox(height: 20),
                      const Divider(
                          thickness: 1,
                          color: ColorPalette.color2,
                          endIndent: 20),
                      const SizedBox(height: 20),
                      buildNavigationButton(
                        icon: Icons.people_alt,
                        label: "Users",
                        index: 6,
                        onPressed: () {
                          controller.changeSelectedValue(6);
                        },
                      ),
                      const SizedBox(height: 5),
                      buildNavigationButton(
                        icon: Icons.group_work,
                        label: "Groups",
                        index: 7,
                        onPressed: () {
                          controller.changeSelectedValue(7);
                        },
                      ),
                      const SizedBox(height: 25),
                      const Divider(
                          thickness: 1.2,
                          color: ColorPalette.color2,
                          endIndent: 20),
                      const SizedBox(height: 25),
                      buildNavigationButton(
                        icon: Icons.settings,
                        label: "Settings",
                        index: 2,
                        onPressed: () {
                          controller.changeSelectedValue(2);
                        },
                      ),
                      const SizedBox(height: 5),
                      buildNavigationButton(
                        icon: Icons.logout,
                        label: "Logout",
                        index: 20,
                        onPressed: () async {
                          SharedPreferences sharedPreferences =
                              await SharedPreferences.getInstance();
                          sharedPreferences.clear();
                          Get.to(LoginPage());
                        },
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      width: 800,
                      height: 48,
                      decoration: BoxDecoration(
                        color: ColorPalette.color2,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: AutoCompleteTextField(
                        key: GlobalKey<AutoCompleteTextFieldState<String>>(),
                        controller: controller.textController,
                        clearOnSubmit: false,
                        suggestions: controller.suggestions,
                        textChanged: (text) {
                          controller.navigationValue == 0
                              ? controller.searchGroup(text)
                              : controller.searchUser(text);
                        },
                        textSubmitted: (text) {},
                        itemBuilder: (context, suggestion) => ListTile(
                          title: Text(suggestion),
                        ),
                        itemSorter: (a, b) => a.compareTo(b),
                        itemFilter: (suggestion, input) => suggestion
                            .toLowerCase()
                            .startsWith(input.toLowerCase()),
                        itemSubmitted: (suggestion) {
                          controller.textController.text = suggestion;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Search in Colud Sync Hub',
                          prefixIcon: Icon(Icons.search),
                          suffixIcon: Icon(Icons.select_all_sharp),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(16),
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height - 68,
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            color: Colors.white),
                        child: controller.currentScreen,
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }

  Widget buildNavigationButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required int index,
  }) {
    return GetBuilder(
      init: ControlController(),
      builder: (controller) => Container(
        decoration: BoxDecoration(
            color: controller.navigationValue == index
                ? ColorPalette.color1
                : ColorPalette.scondaryColor.withOpacity(0.1),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        width: 220,
        height: 35,
        child: ElevatedButton.icon(
          style: ButtonStyle(
            alignment: Alignment.centerLeft,
            elevation: MaterialStateProperty.all(0),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return Colors.grey.withOpacity(0.2);
                }
                return Colors.transparent;
              },
            ),
            padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
            side: MaterialStateProperty.resolveWith<BorderSide>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return const BorderSide(color: Colors.transparent);
                }
                return const BorderSide(color: Colors.transparent);
              },
            ),
          ),
          onPressed: onPressed,
          icon: Icon(
            icon,
            color: Colors.black.withOpacity(0.8),
            size: 20,
          ),
          label: Text(
            label,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
    );
  }
}
