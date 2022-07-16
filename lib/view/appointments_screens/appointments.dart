// ignore_for_file: camel_case_types, non_constant_identifier_names, unnecessary_string_interpolations

import 'dart:async';

import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shura/controllers/console/console_orders_controller.dart';
import 'package:shura/controllers/main_controller.dart';
import 'package:shura/controllers/warning_Controller.dart';
import 'package:shura/models/appointment_model.dart';
import 'package:shura/models/client/client_apointment_model.dart';
import 'package:shura/view/chates/vidoeCall.dart';

class Appointments extends StatefulWidget {
  @override
  State<Appointments> createState() => _appointmentsState();
}

class _appointmentsState extends State<Appointments> {
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();
  final ClinetConteoller = Get.put(ConsoleOrdersController());
  final mainController = Get.find<MainController>();
  final warningcontroller = Get.put(WarningController());
  late GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void initState() {
    super.initState();
    ClinetConteoller.clientOrders();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Color(0xFFF2F2F2),
          // start body
          body: Obx(
            () {
              return ClinetConteoller.isLoding.value == true
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF54D3C2),
                      ),
                    )
                  : RefreshIndicator(
                      backgroundColor: Color(0xFF54D3C2),
                      color: Colors.white.withAlpha(59),
                      onRefresh: () {
                        return Future.delayed(
                          Duration(seconds: 1),
                          () {
                            /// adding elements in list after [1 seconds] delay
                            /// to mimic network call
                            ///
                            /// Remember: setState is necessary so that
                            /// build method will run again otherwise
                            /// list will not show all elements
                            setState(() {
                              ClinetConteoller.clientOrders();
                            });

                            // showing snackbar
                            _scaffoldKey.currentState!.showSnackBar(
                              SnackBar(
                                content: const Text('تم تحديث البيانات بنجاح'),
                              ),
                            );
                          },
                        );
                      },
                      child: GridView.builder(
                        padding: const EdgeInsets.all(12),
                        // physics: BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: 1.42,
                          crossAxisSpacing: 0,
                          mainAxisSpacing: 0,
                        ),
                        itemCount: ClinetConteoller.clientApointment.length,
                        itemBuilder: (context, index) {
                          return buildAppointment(
                              ClinetConteoller.clientApointment[index]);
                        },
                      ),
                    );
            },
          ),
        ));
  }

  // Widget buildConsole(ClientApointmentModel Clinet) {
  //   var day = "";
  //   switch (Clinet.day) {
  //     case '1':
  //       day = "السبت";
  //       break;
  //     case '2':
  //       day = "الأحد";
  //       break;
  //     case '3':
  //       day = "الإثنين";
  //       break;
  //     case '4':
  //       day = "الثلاثاء";
  //       break;
  //     case '5':
  //       day = "الاربعاء";
  //       break;
  //     case '6':
  //       day = "الخميس";
  //       break;
  //     case '7':
  //       day = "الجمعة";
  //       break;
  //     default:
  //   }
  //   var iconColor = Color.fromARGB(255, 211, 84, 84);
  //   if (Clinet.status == 1) {
  //     iconColor = Color.fromARGB(255, 130, 211, 84);
  //   } else if (Clinet.status == 2) {
  //     iconColor = Color.fromARGB(255, 84, 202, 211);
  //   }
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 20.0),
  //     child: ListTile(
  //       leading: CircleAvatar(
  //         radius: 30.0,
  //         backgroundImage: Clinet.photo != null
  //             ? NetworkImage(
  //                 'http://192.168.9.5:2010/upload/catiguriesIcon/${Clinet.photo}',
  //               )
  //             : const NetworkImage(
  //                 'https://shurasd.com/assets/favicon.ico',
  //               ),
  //       ),
  //       title: Text(
  //         "${Clinet.name}",
  //         style: const TextStyle(
  //           fontSize: 15.0,
  //           color: Colors.black,
  //         ),
  //       ),
  //       subtitle: Text(
  //         "طلب إستشارة في ${Clinet.service} في يوم ${day} من ${Clinet.from}  الي ${Clinet.to}",
  //         overflow: TextOverflow.ellipsis,
  //         style: const TextStyle(
  //           fontSize: 11.0,
  //           color: Colors.grey,
  //         ),
  //       ),
  //       trailing: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           Icon(
  //             Icons.radio_button_checked,
  //             color: iconColor,
  //           ),
  //         ],
  //       ),
  //       onTap: () {
  //         print(Clinet.status);
  //         Clinet.status == 0 || Clinet.status == -1
  //             ? warningcontroller.showAlert(
  //                 'الطلب غير مكتمل', "هذا الطلب غير جاهز بعد", "danger")
  //             : Get.to(() => VideoCallScreen());
  //       },
  //     ),
  //   );
  // }

  Widget buildAppointment(ClientApointmentModel appointment) {
    late String status = "لم يتم قبول الطلب بعد";
    var day = "";
    switch (appointment.day) {
      case '1':
        day = "السبت";
        break;
      case '2':
        day = "الأحد";
        break;
      case '3':
        day = "الإثنين";
        break;
      case '4':
        day = "الثلاثاء";
        break;
      case '5':
        day = "الاربعاء";
        break;
      case '6':
        day = "الخميس";
        break;
      case '7':
        day = "الجمعة";
        break;
      default:
    }
    switch (appointment.status) {
      case 1:
        status = "تم قبول الطلب";
        break;
      case 2:
        status = "يمكنك الدخول للطلب الآن";
        break;
      default:
    }
    return Column(children: [
      SizedBox(
        height: 10,
      ),
      InkWell(
        child: Card(
          child: Container(
            margin: EdgeInsets.all(8),
            // width: MediaQuery.of(context).size.width * 0.45,
            height: 200,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.white.withAlpha(50),
                  Colors.white.withAlpha(59),
                ], begin: Alignment.bottomCenter, end: Alignment.centerRight),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                    topRight: Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(5, 8),
                    blurRadius: 10,
                    color: Color(0xFF54D3C2).withAlpha(25),
                  )
                ]),
            child: Column(
              children: [
                Container(
                  height: 100,
                  margin: EdgeInsets.only(top: 5),
                  child: InkWell(
                    child: appointment.photo != null
                        ? Image.network(
                            'https://admin.shurasd.com/upload/catiguriesIcon/${appointment.photo}',
                          )
                        : Image.network(
                            'https://shurasd.com/assets/images/shura2.png'),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                InkWell(
                  child: Center(
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            "لديك موعد مع ${appointment.name} يوم ${day} من الساعة ${appointment.from} الي الساعة ${appointment.to} حالته الآن ${status}",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Center(
                            child: Icon(
                              Icons.radio_button_checked,
                              color: appointment.status == 1
                                  ? Colors.greenAccent
                                  : appointment.status == 2
                                      ? Colors.grey
                                      : Colors.redAccent,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        onTap: () {
          if (appointment.status != 1) {
            Get.defaultDialog(
              title: "طلب غير لآئق",
              middleText: "يبدو ان الوقت الآن غير مناسب لبدأ الموعد",
              backgroundColor: Colors.red.withOpacity(.9),
              titleStyle: const TextStyle(color: Colors.white),
              middleTextStyle: const TextStyle(color: Colors.white),
              radius: 30,
              content: Center(
                child: Column(
                  children: const [
                    Text(
                      ' ... عند ظهور هذة الرساة فهاذا يعني',
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      'وقت الموعد المحدد لم يتم بعد -',
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.right,
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      'تم إلغاء الموعد من قبل المستشار -',
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.right,
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      'تم إلغاء الموعد برغبة منك -',
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.right,
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 30,
                    )
                  ],
                ),
              ),
            );
          } else {
            Get.to(() => VideoCallScreen());
          }
        },
      )
    ]);
  }
}
