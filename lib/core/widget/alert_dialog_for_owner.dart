import 'package:cloud_sync_hub/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OwnerAlertDialog extends StatelessWidget {
  OwnerAlertDialog({super.key});
  final _controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Owner for group'),
      content: FutureBuilder(
          future: _controller.getOwnedGroup(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox(
                  height: 200,
                  width: 100,
                  child: Center(child: CircularProgressIndicator()));
            }
            if (snapshot.hasError) {
              return const Center(child: Text("No Data"));
            }
            return SizedBox(
              height: 200,
              width: 100,
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return Container(
                    height: 40,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left:10),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Colors.white,
                    ),
                    child: Text(
                      "${_controller.ownerGroup[index].name}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemCount: _controller.ownerGroup.length,
              ),
            );
          }),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Ok'),
        ),
      ],
    );
  }
}
