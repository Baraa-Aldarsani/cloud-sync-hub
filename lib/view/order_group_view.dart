// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:cloud_sync_hub/controller/controller.dart';
import 'package:cloud_sync_hub/core/core.dart';
import 'package:cloud_sync_hub/model/model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class OrderGroupView extends StatelessWidget {
  OrderGroupView({super.key});
  final _controller = Get.put(HomeController());
  final _userGroup = Get.put(UserGroupController());
  FolderModel? folderModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Orders",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
            ),
            Row(
              children: [
                const Text("groups"),
                const SizedBox(width: 30),
                SizedBox(
                  height: 50,
                  width: 1170,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: FutureBuilder(
                        future: _controller.getAllFolder(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return ListView.separated(
                             
                              scrollDirection: Axis.horizontal,
                              itemCount: 9,
                              itemBuilder: (BuildContext context, int index) {
                                return Shimmer.fromColors(
                                  baseColor: ColorPalette.color2,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: _controller.getColorButtons(index),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(15)),
                                    ),
                                    width: 120,
                                    height: 40,
                                    child: ElevatedButton.icon(
                                      style: ButtonStyle(
                                        alignment: Alignment.centerLeft,
                                        elevation: MaterialStateProperty.all(0),
                                        backgroundColor: MaterialStateProperty
                                            .resolveWith<Color>(
                                          (Set<MaterialState> states) {
                                            if (states.contains(
                                                MaterialState.pressed)) {
                                              return Colors.grey
                                                  .withOpacity(0.2);
                                            }
                                            return Colors.transparent;
                                          },
                                        ),
                                        padding: MaterialStateProperty.all(
                                            const EdgeInsets.all(10)),
                                        side: MaterialStateProperty.resolveWith<
                                            BorderSide>(
                                          (Set<MaterialState> states) {
                                            if (states.contains(
                                                MaterialState.pressed)) {
                                              return const BorderSide(
                                                  color: Colors.transparent);
                                            }
                                            return const BorderSide(
                                                color: Colors.transparent);
                                          },
                                        ),
                                      ),
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.folder,
                                        color: Colors.black.withOpacity(0.8),
                                        size: 20,
                                      ),
                                      label: const Text(
                                        '',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const SizedBox(width: 10),
                            );
                          }
                          return Expanded(
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: _controller.folder.length,
                              itemBuilder: (BuildContext context, int index) {
                                folderModel = _controller.folder[index];
                                return Obx(
                                  () => Container(
                                    decoration: BoxDecoration(
                                      color: _controller.getColorButtons(index),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(15)),
                                      border: Border.all(
                                          width: 0.5, color: Colors.black54),
                                    ),
                                    width: 120,
                                    height: 40,
                                    child: ElevatedButton.icon(
                                      style: ButtonStyle(
                                        alignment: Alignment.centerLeft,
                                        elevation: MaterialStateProperty.all(0),
                                        backgroundColor: MaterialStateProperty
                                            .resolveWith<Color>(
                                          (Set<MaterialState> states) {
                                            if (states.contains(
                                                MaterialState.pressed)) {
                                              return Colors.grey.withOpacity(0.2);
                                            }
                                            return Colors.transparent;
                                          },
                                        ),
                                        padding: MaterialStateProperty.all(
                                            const EdgeInsets.all(10)),
                                        side: MaterialStateProperty.resolveWith<
                                            BorderSide>(
                                          (Set<MaterialState> states) {
                                            if (states.contains(
                                                MaterialState.pressed)) {
                                              return const BorderSide(
                                                  color: Colors.transparent);
                                            }
                                            return const BorderSide(
                                                color: Colors.transparent);
                                          },
                                        ),
                                      ),
                                      onPressed: () {
                                        _controller.changeColor(index);
                                        _controller.selectSug.value = index;
                                        folderModel = _controller.folder[index];
                                        _userGroup.getOrderForUsers(folderModel);
                                      },
                                      icon: Icon(
                                        Icons.folder,
                                        color: Colors.black.withOpacity(0.8),
                                        size: 20,
                                      ),
                                      label: Text(
                                        _controller.folder[index].name!,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const SizedBox(width: 10),
                            ),
                          );
                        }),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: 12, right: 40, top: 12),
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
                  future: _userGroup.getOrderForUsers(
                      folderModel ?? FolderModel(id: 0, name: '', ownerId: 0)),
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
                                    "${controller.orderUser[index].firstName} ${controller.orderUser[index].lastName}",
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                                SizedBox(
                                  width: 460,
                                  child: Text(
                                    "${controller.orderUser[index].email}",
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                                _buildRowBtn(controller.orderUser[index]),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: ((context, index) =>
                            const SizedBox(height: 10)),
                        itemCount: controller.orderUser.length,
                      ),
                    );
                  })),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRowBtn(UserGroupModel orderModel) {
    return Row(
      children: [
        _ElvatedBtn(
          icon: Icons.remove,
          color: Colors.white,
          text: "Refusal",
          backgroundColor: Colors.red.shade600,
          onPressed: () {
            _userGroup.unAcceptOrder(orderModel);
          },
        ),
        const SizedBox(width: 20),
        _ElvatedBtn(
          icon: Icons.add,
          color: Colors.white,
          text: "Acceptance",
          backgroundColor: Colors.blue.shade600,
          onPressed: () {
            _userGroup.acceptOrder(orderModel);
          },
        ),
      ],
    );
  }

  Widget _ElvatedBtn(
      {required IconData icon,
      required String text,
      required Color color,
      required Color backgroundColor,
      required VoidCallback onPressed}) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        alignment: Alignment.centerLeft,
        elevation: MaterialStateProperty.all(0),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.grey.withOpacity(0.2);
            }
            return backgroundColor;
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
        color: color,
        size: 20,
      ),
      label: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}
