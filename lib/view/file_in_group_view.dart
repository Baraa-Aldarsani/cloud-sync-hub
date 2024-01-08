// ignore_for_file: must_be_immutable

import 'package:cloud_sync_hub/controller/controller.dart';
import 'package:cloud_sync_hub/model/model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FileInGroupView extends StatelessWidget {
  FileInGroupView({super.key, required this.folderModel});
  FolderModel? folderModel;
  final _controller = Get.put(HomeController());
  final _controllerMove = Get.put(ControlController());
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
                    _controllerMove.changeSelectedValue(0);
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                Text(
                  "Files in ${folderModel?.name}",
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            FutureBuilder(
                future: _controller.getFileInGroup(folderModel!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Expanded(
                        child: Center(child: CircularProgressIndicator()));
                  }
                  if (snapshot.hasError) {
                    return const Expanded(
                        child: Center(child: Text("No Data")));
                  }
                  return SizedBox(
                    width: MediaQuery.of(context).size.width - 200,
                    height: MediaQuery.of(context).size.height - 210,
                    child: GetBuilder(
                      init: HomeController(),
                      builder: (controller) => GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                        ),
                        itemCount: controller.fileinGroup.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Icon(
                                    _iconData(controller
                                        .fileinGroup[index].extension!),
                                    size: 48.0,
                                    color: Colors.blue,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 180,
                                        child: Text(
                                            '${controller.fileinGroup[index].name}',
                                            style: const TextStyle(
                                                fontSize: 14.0)),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            controller.openDetailFile(
                                              context,
                                              controller.fileinGroup[index],
                                            );
                                          },
                                          icon: const Icon(Icons.more_vert))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }

  IconData _iconData(String extension) {
    if (extension == "txt") {
      return Icons.insert_drive_file;
    } else if (extension == "pdf") {
      return Icons.picture_as_pdf_sharp;
    } else if (extension == "docx") {
      return Icons.description;
    } else {
      return Icons.photo;
    }
  }
}
