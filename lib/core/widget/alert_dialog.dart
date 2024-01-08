import 'package:cloud_sync_hub/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddFolderDialog extends StatelessWidget {
  AddFolderDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ControlController(),
      builder: (controller) => AlertDialog(
        title: const Text('New Folder'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller.folderNameController,
              decoration: const InputDecoration(
                labelText: 'Folder Name',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              controller.addFolder();
              Navigator.of(context).pop();
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }
}
