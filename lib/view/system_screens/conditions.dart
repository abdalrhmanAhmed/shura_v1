import 'package:flutter/material.dart';

import 'package:get/get.dart';

class conditions extends StatefulWidget {
  conditions({Key? key}) : super(key: key);

  @override
  State<conditions> createState() => _conditionsState();
}

class _conditionsState extends State<conditions> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            leading: Container(
              child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.arrow_back_ios),
                iconSize: 35,
              ),
            ),
            title: Center(
              child: Text(
                "الشروط و الاحكام",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
            ),
            elevation: 0.5,
            iconTheme: IconThemeData(color: Colors.white),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                    Color(0xFF54D3C2),
                    Color(0xFF54D3C2),
                  ])),
            ),
            actions: [
              Container(
                margin: EdgeInsets.only(top: 5, right: 16, left: 3, bottom: 10),
                child: Stack(
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) {
                        //       return notice();
                        //     },
                        //   ),
                        // );
                      },
                      icon: Icon(Icons.notifications_active_outlined),
                      iconSize: 30,
                    ),
                    Positioned(
                      right: 13,
                      top: 10,
                      child: Container(
                        padding: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 12,
                          minHeight: 12,
                        ),
                        child: Text(
                          '7',
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
              )
            ],
          ),
          body: Center(child: Text("الشروط و الاحكام")),
          // floatingActionButtonLocation:
          //     FloatingActionButtonLocation.centerDocked,
          // bottomNavigationBar: MyPlugin(),
        ));
  }
}
