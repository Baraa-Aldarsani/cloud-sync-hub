import 'package:cloud_sync_hub/model/model.dart';
import 'package:flutter/material.dart';

class ReportDetails extends StatelessWidget {
  final ReportModel report;

  const ReportDetails({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'File Name : ${report.fileModel!.name}.${report.fileModel!.extension}'),
            Text('${report.eventType!.name} by: ${report.userModel!.name}'),
            Text('Email : ${report.userModel!.email}'),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
