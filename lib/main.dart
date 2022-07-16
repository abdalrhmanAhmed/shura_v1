import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shura/api_services/api.dart';
import 'package:shura/controllers/main_controller.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/services.dart';
import 'api_services/auth_api.dart';

void main() async {
  await GetStorage.init();
  AuthApi.initializeInterceptors();
  Api.initializeInterceptors();
  runApp(const MyApp());
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.unknown,
        // etc.
      };
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    super.initState();
  }

  final mainController = Get.put(MainController());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
              backgroundColor: const Color.fromARGB(255, 247, 255, 250),
              body: Column(
                children: [
                  const SizedBox(height: 100),
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 80),
                      child: Image.asset("images/shura_logo.png"),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(child: Container()),
                  const Text(
                    "Powered by : Eva Soft Solutions",
                    style: TextStyle(
                        color: Color.fromARGB(255, 92, 92, 92),
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  const SizedBox(height: 20)
                ],
              ))),
      theme: ThemeData(fontFamily: "Ciro"),
    );
  }
}
