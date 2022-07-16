import 'dart:async';

import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:shura/controllers/main_controller.dart';
import 'package:shura/controllers/user_data_controller.dart';
import 'package:shura/controllers/warning_Controller.dart';
import 'package:shura/view/Profile_screens/prof.dart';
import 'package:shura/view/appointments_screens/appointments.dart';
import 'package:shura/view/helpers/widgets/primary_button.dart';
import 'package:shura/view/helpers/widgets/red_button.dart';
import 'package:shura/view/messages_screens/messages.dart';
import 'package:shura/view/notes_screens/notice.dart';
import 'package:shura/view/system_screens/about.dart';

import 'hom_page.dart';

import 'package:get/get.dart';

class MyPlugin extends StatefulWidget {
  @override
  State<MyPlugin> createState() => _MyPluginState();
}

class _MyPluginState extends State<MyPlugin> {
  final mainController = Get.find<MainController>();
  final warningcontroller = Get.put(WarningController());
  final gardcontroller = Get.put(UserDataContoller());

  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

  Future<void> share() async {
    await FlutterShare.share(
        title: 'تطبيق شورى',
        text:
            'إنضم الي أسرة تطبيق شورى الآن و احصل علي 1000 نقط لإستخدامها في إستشاراتك الشخصية .',
        linkUrl: 'https://shurasd.com',
        chooserTitle: 'تجربة');
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          backgroundColor: Color(0xFFF2F2F2),
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  Get.to(about());
                },
                icon: Icon(Icons.help),
              ),
              IconButton(
                onPressed: () {
                  share();
                },
                icon: Icon(Icons.share),
              ),
              IconButton(
                  onPressed: () {
                    Get.dialog(
                      Dialog(
                        backgroundColor: Color(0xFFF2F2F2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          height: 200,
                          width: 300,
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 30,
                                ),
                                Center(
                                  child: Text(
                                      'هل أنت متأكد من عملية تسجيل الخروج',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color:
                                              Color.fromARGB(137, 37, 37, 37))),
                                ),
                                SizedBox(height: 25),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: RedButton(
                                        label: 'نعم',
                                        onPress: () {
                                          warningcontroller.showAlert(
                                              "جاري معالجة طلبك",
                                              "جاري الخروج من الحساب",
                                              "opration");
                                          Timer(Duration(seconds: 2),
                                              () => mainController.logout());
                                        },
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: PrimaryButton(
                                        label: 'لأ',
                                        onPress: () {
                                          Get.back();
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  icon: Icon(Icons.logout)),
            ],
            backgroundColor: Color(0xFF54D3C2),
            leading: Container(
              margin: EdgeInsets.only(top: 5, right: 16, left: 3, bottom: 10),
              child: Stack(
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Get.to(notice());
                    },
                    icon: Icon(Icons.notifications_active_outlined),
                    iconSize: 30,
                    color: Colors.white,
                  ),
                  Positioned(
                    right: 13,
                    top: 10,
                    child: Container(
                      padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 15,
                        minHeight: 15,
                      ),
                      child: Text(
                        '2',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            ),
            bottom: TabBar(indicatorColor: Colors.white, tabs: [
              Tab(
                child: Text(
                  "الرئيسية",
                  style: TextStyle(fontSize: 13),
                ),
                icon: Icon(
                  Icons.home_outlined,
                  size: 28,
                ),
              ),
              Tab(
                child: Text(
                  "المواعيد",
                  style: TextStyle(fontSize: 13),
                ),
                icon: Icon(
                  Icons.access_time,
                  size: 28,
                ),
              ),
              Tab(
                child: Text(
                  "الرسائل",
                  style: TextStyle(fontSize: 13),
                ),
                icon: Icon(
                  Icons.mail,
                  size: 28,
                ),
              ),
              Tab(
                child: Text(
                  "حسابي",
                  style: TextStyle(fontSize: 15),
                ),
                icon: Icon(
                  Icons.perm_identity,
                  size: 28,
                ),
              ),
            ]),
          ),
          body: TabBarView(children: [
            Home_Page(),
            Appointments(),
            message(),
            prof(),
          ]),
        ));
  }
}
