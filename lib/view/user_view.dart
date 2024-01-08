// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:cloud_sync_hub/controller/controller.dart';
import 'package:cloud_sync_hub/core/core.dart';
import 'package:cloud_sync_hub/model/model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserView extends StatelessWidget {
  UserView({super.key, required this.folderModel});
  FolderModel? folderModel;
  final _controller = Get.put(ControlController());
  final _userGroup = Get.put(UserGroupController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      _controller.changeSelectedValue(0);
                    },
                    icon: const Icon(Icons.arrow_back)),
                Text(
                  "Users in ${folderModel!.name}",
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(left: 12, right: 12, top: 12),
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
                  Text("Application status",
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
                  future: _userGroup.getUserGroup(folderModel!),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return const Center(child: Text("No Data"));
                    }
                    return GetBuilder(
                      init: UserGroupController(),
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
                                    "${controller.userGroup[index].firstName} ${controller.userGroup[index].lastName}",
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                                SizedBox(
                                  width: 510,
                                  child: Text(
                                    "${controller.userGroup[index].email}",
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
                                        return Colors.redAccent;
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
                                    controller.deleteUserInGroup(
                                        _userGroup.userGroup[index]);
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  label: const Text(
                                    "Delete",
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
                        itemCount: _userGroup.userGroup.length,
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
