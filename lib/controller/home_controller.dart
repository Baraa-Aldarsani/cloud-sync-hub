// ignore_for_file: avoid_print

import 'dart:typed_data';

import 'package:cloud_sync_hub/controller/controller.dart';
import 'package:cloud_sync_hub/core/core.dart';
import 'package:cloud_sync_hub/model/model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:popup_menu/popup_menu.dart';
import 'package:file_picker/file_picker.dart';

class HomeController extends GetxController {
  RxInt selectedIndexButtons = 0.obs;
  RxInt selectSug = 0.obs;
  final List<GlobalKey> tileKeys = List.generate(100, (index) => GlobalKey());
  var folder = <FolderModel>[];
  var ownerGroup = <UserOwnedGroupModel>[];
  var file = <FileModel>[];
  var fileinGroup = <FileModel>[];
  RxList<Uint8List> addFile = <Uint8List>[].obs;
  List<String> text = [
    "Files",
    "Folder",
  ];

  List<IconData> icon = [
    Icons.file_copy,
    Icons.folder,
  ];

  @override
  void onInit() {
    getAllFile();
    super.onInit();
  }

  void changeColor(int index) {
    selectedIndexButtons.value = index;
    update();
  }

  Color getColorButtons(int index) {
    return selectedIndexButtons.value == index
        ? ColorPalette.color1
        : Colors.white;
  }

  void listMenu(BuildContext context, GlobalKey btnKey4, FolderModel folderId) {
    PopupMenu menu = PopupMenu(
        context: context,
        config: const MenuConfig(
          backgroundColor: ColorPalette.color2,
          lineColor: Colors.grey,
        ),
        items: [
          MenuItem.forList(
              title: 'Home',
              image:
                  const Icon(Icons.home, color: Color(0xFF181818), size: 20)),
          MenuItem.forList(
              title: 'Add File',
              image: const Icon(Icons.attach_file,
                  color: Color(0xFF181818), size: 20)),
          MenuItem.forList(
              title: 'Owner',
              image:
                  const Icon(Icons.group, color: Color(0xFF181818), size: 20)),
          MenuItem.forList(
              title: 'Users',
              image: const Icon(Icons.supervised_user_circle,
                  color: Color(0xFF181818), size: 20)),
          MenuItem.forList(
              title: 'Delete',
              image:
                  const Icon(Icons.delete, color: Colors.redAccent, size: 20))
        ],
        onClickMenu: (MenuItemProvider item) {
          onClickMenu(item, btnKey4, folderId);
        },
        onShow: onShow,
        onDismiss: onDismiss);
    menu.show(widgetKey: btnKey4);
  }

  void onClickMenu(
      MenuItemProvider item, GlobalKey btnKey4, FolderModel folder) async {
    print('Click menu -> ${item.menuTitle}');
    if (item.menuTitle == 'Delete') {
      deleteFolder(folder.id!);
    }
    if (item.menuTitle == 'Users') {
      Get.find<ControlController>().changeSelectedValue(3, folderModel: folder);
      final cont = Get.put(UserGroupController());
      cont.getUserGroup(folder);
    }
    if (item.menuTitle == 'Owner') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.dialog(
          OwnerAlertDialog(),
        );
      });
    }
    if (item.menuTitle == 'Add File') {
      await pickImages();
      if (addFile.isNotEmpty) {
        await addFileInGroup(addFile[0], folder.id!, fileName, fileExtension);
        addFile.clear();
      } else {
        print('No file selected');
      }
    }
  }

  void onDismiss() {
    print('Menu is dismiss');
  }

  void onShow() {
    print('Menu is show');
  }

  String fileName = '';
  String fileExtension = '';
  Future<void> pickImages() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'txt', 'pdf', 'docx'],
    );

    if (result != null) {
      List<Uint8List> pickedImages = result.files.map((file) {
        fileName = file.name;
        fileExtension = file.extension!;
        return file.bytes!;
      }).toList();

      addFile.addAll(pickedImages);
    }
  }

  Future<void> getAllFolder() async {
    try {
      final fetchData = await ApiServices.getAllFolder();
      folder.assignAll(fetchData);
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteFolder(int id) async {
    try {
      await ApiServices.deleteFolder(id);
      folder.removeWhere((folder) => folder.id == id);
      update();
    } catch (e) {
      print(e);
    }
  }

  void addFolderToFolderList(FolderModel newFolder) {
    folder.add(newFolder);
    update();
  }

  Future<void> getOwnedGroup() async {
    try {
      final fetchData = await ApiServices.getOwner();
      ownerGroup.assignAll(fetchData);
    } catch (e) {
      print(e);
    }
  }

  Future<void> getAllFile() async {
    try {
      final fetchData = await ApiServices.getFile();
      file.assignAll(fetchData);
    } catch (e) {
      print(e);
    }
  }

  Future<void> getFileInGroup(FolderModel folderModel) async {
    try {
      final fetchData = await ApiServices.getFileInGroup(folderModel);
      fileinGroup.assignAll(fetchData);
    } catch (e) {
      print(e);
    }
  }

  Future<void> addFileInGroup(
    Uint8List addFile,
    int folderId,
    String fileName,
    String fileExtension,
  ) async {
    try {
      await ApiServices.addFilInGroup(
          addFile, folderId, fileName, fileExtension);
    } catch (e) {
      print(e);
    }
  }

  void openDetailFile(BuildContext context, FileModel fileModel) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialogFiles(fileModel: fileModel);
      },
    );
  }

  Future<void> checkIn(int fileId) async {
    try {
      await ApiServices.checkIn(fileId);
      Get.snackbar(
        'Success Check In',
        '',
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.TOP,
        maxWidth: 500,
      );
    } catch (e) {
      Get.snackbar(
        'Check In failed',
        'The file is pre-booked.',
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.TOP,
        maxWidth: 500,
      );
      print(e);
    }
  }

  Future<void> checkOut(int fileId) async {
    try {
      await ApiServices.checkOut(fileId);
      Get.snackbar(
        'Success Check Out',
        '',
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.TOP,
        maxWidth: 500,
      );
    } catch (e) {
      Get.snackbar(
        'Check Out failed',
        'The file isn’t pre-booked.',
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.TOP,
        maxWidth: 500,
      );
      print(e);
    }
  }

  Future<void> deleteFile(int fileId, String name) async {
    try {
      await ApiServices.deleteFile(fileId);
      file.removeWhere((file) => file.id == fileId);
      update();
    } catch (e) {
      print(e);
    }
  }

  Future<void> downloadFile(FileModel fileModel) async {
    try {
      await ApiServices.downloadFile(fileModel);
    } catch (e) {
      print(e);
    }
  }
}
