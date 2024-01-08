import 'package:cloud_sync_hub/controller/controller.dart';
import 'package:cloud_sync_hub/core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final _controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Home",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
          ),
          Row(
            children: [
              const Text("suggested"),
              const SizedBox(width: 30),
              SizedBox(
                height: 50,
                width: 1150,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: 2,
                    itemBuilder: (BuildContext context, int index) {
                      return Obx(
                        () => Container(
                          decoration: BoxDecoration(
                            color: _controller.getColorButtons(index),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            border:
                                Border.all(width: 0.5, color: Colors.black54),
                          ),
                          width: 120,
                          height: 40,
                          child: ElevatedButton.icon(
                            style: ButtonStyle(
                              alignment: Alignment.centerLeft,
                              elevation: MaterialStateProperty.all(0),
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    return Colors.grey.withOpacity(0.2);
                                  }
                                  return Colors.transparent;
                                },
                              ),
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.all(10)),
                              side:
                                  MaterialStateProperty.resolveWith<BorderSide>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed)) {
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
                            },
                            icon: Icon(
                              _controller.icon[index],
                              color: Colors.black.withOpacity(0.8),
                              size: 20,
                            ),
                            label: Text(
                              _controller.text[index],
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(width: 10),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Obx(
            () => Expanded(
              child: _controller.selectSug.value == 0
                  ? _buildFiles(context)
                  : _buildFolder(context),
            ),
          ),
        ],
      ),
    ));
  }

  Widget _buildFiles(BuildContext context) {
    return FutureBuilder(
        future: _controller.getAllFile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: ColorPalette.color2,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    decoration: const BoxDecoration(
                        color: ColorPalette.color2,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 100,
                          width: 100,
                          child: CircleAvatar(
                            backgroundColor: Colors.black,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                color: Colors.black,
                                height: 30,
                                width: 180,
                              ),
                              const Icon(
                                Icons.more_vert,
                                color: Colors.black,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }
          if (snapshot.hasError) {
            return const Center(child: CircularProgressIndicator());
          }
          return SizedBox(
            width: MediaQuery.of(context).size.width - 200,
            height: MediaQuery.of(context).size.height - 210,
            child: GetBuilder(
              init: HomeController(),
              builder: (controller) => GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: controller.file.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Icon(
                            _iconData(controller.file[index].extension!),
                            size: 48.0,
                            color: Colors.blue,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 180,
                                child: Text('${controller.file[index].name}',
                                    style: const TextStyle(fontSize: 14.0)),
                              ),
                              IconButton(
                                  onPressed: () {
                                    controller.openDetailFile(
                                      context,
                                      controller.file[index],
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
        });
  }

  Widget _buildFolder(BuildContext context) {
    return FutureBuilder(
        future: _controller.getAllFolder(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return GridView.builder(
              itemCount: 10,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                mainAxisExtent: 50.0,
                childAspectRatio: 1.0,
              ),
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: ColorPalette.color2,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      color: ColorPalette.color1,
                    ),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const ListTile(
                        title: Text(""),
                        leading: Icon(Icons.folder),
                        trailing: Icon(Icons.more_vert),
                      ),
                    ),
                  ),
                );
              },
            );
          }
          if (snapshot.hasError) {
            return const Center(child: Text("No Data"));
          }
          return SizedBox(
            width: MediaQuery.of(context).size.width - 200,
            height: MediaQuery.of(context).size.height - 300,
            child: GetBuilder(
              init: HomeController(),
              builder: (controller) => GridView.builder(
                itemCount: controller.folder.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  mainAxisExtent: 50.0,
                  childAspectRatio: 1.0,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      color: ColorPalette.color1,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Get.find<ControlController>().changeSelectedValue(5,
                            folderModel: _controller.folder[index]);
                      },
                      child: ListTile(
                        key: _controller.tileKeys[index],
                        title: Text("${controller.folder[index].name}"),
                        leading: const Icon(Icons.folder),
                        trailing: IconButton(
                          icon: const Icon(Icons.more_vert),
                          onPressed: () {
                            controller.listMenu(
                                context,
                                controller.tileKeys[index],
                                controller.folder[index]);
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        });
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
