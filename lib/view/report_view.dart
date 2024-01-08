import 'package:cloud_sync_hub/controller/controller.dart';
import 'package:animations/animations.dart';
import 'package:cloud_sync_hub/core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'view.dart';

class ReportView extends StatelessWidget {
  ReportView({super.key});
  final _controller = Get.put(ReportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Reports",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
            ),
            const SizedBox(width: 50),
            Expanded(
              child: _buildReport(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReport(BuildContext context) {
    return FutureBuilder(
        future: _controller.getAllReport(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text("No Data"));
          }
          return ListView.builder(
            itemCount: _controller.report.length,
            itemBuilder: (context, index) {
              return OpenContainer(
                transitionType: ContainerTransitionType.fade,
                closedElevation: 3,
                closedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                closedBuilder: (context, action) {
                  return Container(
                    decoration: BoxDecoration(
                        color: index % 2 == 0
                            ? Colors.grey.shade100
                            : ColorPalette.color1,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15))),
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      leading: Icon(
                        _iconData(
                            _controller.report[index].fileModel!.extension!),
                        size: 48.0,
                        color: Colors.blue,
                      ),
                      title: Text(
                          '${_controller.report[index].fileModel!.name}.${_controller.report[index].fileModel!.extension}'),
                      subtitle: Text(
                          '${_controller.report[index].eventType!.name} by ${_controller.report[index].userModel!.name}'),
                      onTap: action,
                    ),
                  );
                },
                openBuilder: (context, action) {
                  return ReportDetails(report: _controller.report[index]);
                },
              );
            },
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
