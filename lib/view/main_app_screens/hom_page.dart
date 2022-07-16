// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shura/controllers/categoriy_controller.dart';
import 'package:shura/models/categories_model.dart';
import 'package:shura/view/order_screens/sub.dart';
// import 'package:shura/view/screens/order_screens/sub.dart';

class Home_Page extends StatefulWidget {
  Home_Page({Key? key}) : super(key: key);

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  final categorieController = Get.put(CategoryController());
  late GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void initState() {
    categorieController.getcategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        // start body
        body: Obx(
          () {
            return categorieController.isLoding.value == true
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
                          setState(() async {
                            categorieController.getcategory();
                            var test = await GetStorage().read('login_first');
                            print("test : $test");
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
                      padding: const EdgeInsets.all(20),
                      // physics: BouncingScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2 / 3,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                      ),
                      itemCount: categorieController.cats.length,
                      itemBuilder: (context, index) {
                        return buildServices(categorieController.cats[index]);
                      },
                    ),
                  );
          },
        ),
      ),
    );
  }
}

Widget buildServices(CategoriesModel cats) {
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
                margin: EdgeInsets.only(top: 10),
                child: InkWell(
                  child: Image.network(
                    "https://admin.shurasd.com/${cats.icon}",
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                    height: 70,
                  ),
                ),
              ),
              SizedBox(
                height: 18,
              ),
              InkWell(
                child: Center(
                  child: Center(
                    child: Text(
                      "${cats.name}",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () {
        Get.to(() => sub(
              id: cats.id,
              tital: '${cats.name}',
            ));
      },
    )
  ]);
  ;
}
