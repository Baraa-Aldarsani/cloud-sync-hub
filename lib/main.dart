import 'package:cloud_sync_hub/core/core.dart';
import 'package:cloud_sync_hub/view/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// SharedPreferences? sharedPreferences;
// bool? checkLogin;

void main() async {
  // sharedPreferences = await SharedPreferences.getInstance();
  // final val = sharedPreferences?.getString("token") ?? 0;
  // if (val != 0) {
  //   checkLogin = true;
  // } else {
  //   checkLogin = false;
  // }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Cloud Sync Hub',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: ColorPalette.color1),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
