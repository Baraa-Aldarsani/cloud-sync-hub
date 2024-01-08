// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:cloud_sync_hub/controller/all_group_controller.dart';
import 'package:cloud_sync_hub/core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllGroupView extends StatelessWidget {
  AllGroupView({super.key});

  final _controller = Get.put(AllGroupController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Groups",
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
                  future: _controller.getAllGroup(),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return const Center(child: Text("No Data"));
                    }
                    return GetBuilder(
                      init: AllGroupController(),
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
                                left: 12, right: 60, top: 12, bottom: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${controller.allGroup[index].name}",
                                  style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w300),
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
                                  onPressed: () {
                                    _controller.joinToGroup(controller.allGroup[index]);
                                  },
                                  icon: const Icon(
                                    Icons.group_add_outlined,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  label: const Text(
                                    "Request to join",
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
                        itemCount: _controller.allGroup.length,
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
