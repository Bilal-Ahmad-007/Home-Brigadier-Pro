import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homebrigadier_pro/utils/permission_manager.dart';

import 'app/routes/app_pages.dart';
import 'utils/connectivity_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ConnectivityService.connectivity();
  await StoragePermissionHandler.requestPermission();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Home Brigadier Pro",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
