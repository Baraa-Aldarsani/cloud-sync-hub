// ignore_for_file: prefer_const_constructors_in_immutables, must_be_immutable

import 'package:cloud_sync_hub/controller/controller.dart';
import 'package:cloud_sync_hub/model/file_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlertDialogFiles extends StatelessWidget {
  AlertDialogFiles({super.key, required this.fileModel});
  FileModel? fileModel;

  final _controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ControlController(),
      builder: (controller) => AlertDialog(
        title: Text('File ${fileModel!.name}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MaterialButton(
              onPressed: () {
                Get.back();
                _controller.downloadFile(fileModel!);
              },
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
                side: const BorderSide(color: Colors.white),
              ),
              child: const Row(
                children: [
                  Icon(Icons.download),
                  SizedBox(width: 20),
                  Text(
                    "Download File",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            MaterialButton(
              onPressed: () {
                Get.back();
                _controller.checkIn(fileModel!.id!);
              },
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
                side: const BorderSide(color: Colors.white),
              ),
              child: const Row(
                children: [
                  Icon(Icons.lock),
                  SizedBox(width: 20),
                  Text(
                    "Check In",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            MaterialButton(
              onPressed: () {
                Get.back();
                _controller.checkOut(fileModel!.id!);
              },
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
                side: const BorderSide(color: Colors.white),
              ),
              child: const Row(
                children: [
                  Icon(Icons.lock_open),
                  SizedBox(width: 20),
                  Text(
                    "Check Out",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            MaterialButton(
              onPressed: () {
                Get.back();
                _controller.deleteFile(fileModel!.id!, fileModel!.name!);
              },
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
                side: const BorderSide(color: Colors.white),
              ),
              child: const Row(
                children: [
                  Icon(Icons.delete_sweep, color: Colors.redAccent),
                  SizedBox(width: 20),
                  Text(
                    "Delete File",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.redAccent,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
