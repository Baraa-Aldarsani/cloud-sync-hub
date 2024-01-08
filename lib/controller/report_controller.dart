// ignore_for_file: avoid_print

import 'package:cloud_sync_hub/controller/controller.dart';
import 'package:cloud_sync_hub/model/report_model.dart';
import 'package:get/get.dart';

class ReportController extends GetxController {
  var report = <ReportModel>[].obs;

  Future<void> getAllReport() async {
    try {
      final fetchData = await ApiServices.getAllReport();
      report.assignAll(fetchData);
    } catch (e) {
      print(e);
    }
  }
}
