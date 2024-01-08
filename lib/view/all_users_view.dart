// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:cloud_sync_hub/controller/controller.dart';
import 'package:cloud_sync_hub/core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllUserView extends StatelessWidget {
  AllUserView({super.key});

  final _controller = Get.put(AllUserController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Users",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 12, right: 25, top: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Name",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w300,
                          color: Colors.blue)),
                  Text("Email",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w300,
                          color: Colors.blue)),
                  Text("Add User to Group",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w300,
                          color: Colors.blue)),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 12, right: 12, top: 12),
              child: Divider(thickness: 1, color: Colors.black),
            ),
            Expanded(
              child: FutureBuilder(
                  future: _controller.getAllUser(),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return const Center(child: Text("No Data"));
                    }
                    return GetBuilder(
                      init: AllUserController(),
                      builder: (controller) => ListView.separated(
                        itemBuilder: (context, index) {
                          return Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: index % 2 == 0
                                    ? Colors.grey.shade100
                                    : ColorPalette.color1,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(15))),
                            padding: const EdgeInsets.only(
                                left: 12, right: 12, top: 12, bottom: 12),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 515,
                                  child: Text(
                                    "${controller.allUser[index].firstName} ${controller.allUser[index].lastName}",
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                                SizedBox(
                                  width: 520,
                                  child: Text(
                                    "${controller.allUser[index].email}",
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                                ElevatedButton.icon(
                                  style: ButtonStyle(
                                    alignment: Alignment.centerLeft,
                                    elevation: MaterialStateProperty.all(0),
                                    backgroundColor: MaterialStateProperty
                                        .resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.pressed)) {
                                          return Colors.grey.withOpacity(0.2);
                                        }
                                        return Colors.blue;
                                      },
                                    ),
                                    padding: MaterialStateProperty.all(
                                        const EdgeInsets.all(10)),
                                    side: MaterialStateProperty.resolveWith<
                                        BorderSide>(
                                      (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.pressed)) {
                                          return const BorderSide(
                                              color: Colors.transparent);
                                        }
                                        return const BorderSide(
                                            color: Colors.transparent);
                                      },
                                    ),
                                  ),
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.person_add_alt,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  label: const Text(
                                    "Add User",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                        separatorBuilder: ((context, index) =>
                            const SizedBox(height: 10)),
                        itemCount: _controller.allUser.length,
                      ),
                    );
                  })),
            )
          ],
        ),
      ),
    );
  }
}
