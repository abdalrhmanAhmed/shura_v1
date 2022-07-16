import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shura/controllers/order_controller.dart';
import 'package:shura/controllers/warning_Controller.dart';
import 'package:shura/view/helpers/theme_helper.dart';
import 'package:shura/view/helpers/widgets/my_new_radio.dart';
import 'package:shura/view/helpers/widgets/my_radio_list_tile.dart';

class OrderScreen extends StatefulWidget with WarningController {
  OrderScreen(
      {required this.consoleName,
      required this.photo,
      this.order_id,
      this.service_name});
  final String consoleName;
  final photo;
  final order_id;
  final service_name;
  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final ordercontroller = Get.put(OrderController());
  final maincontroller = Get.put(WarningController());
  final _orderTitle = TextEditingController();
  Map<String, dynamic> _orderData = {};
  int _type = 1;
  int _duration = 1;
  String? selectedValue;

  final List<String> items = [
    'الاحد : 1 ص',
    'الاحد : 2 ص',
    'الاحد : 3 ص',
    'الاحد : 4 ص',
    'الاحد : 5 ص',
    'الاحد : 6 ص',
    'الاحد : 7 ص',
    'الاحد : 8 ص',
  ];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios),
            iconSize: 35,
          ),
          title: Center(
            child: Text(
              "حجز موعد",
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
              margin: EdgeInsets.only(top: 5, right: 55, left: 3, bottom: 10),
            )
          ],
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: Column(
              children: [
                SafeArea(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20, 2, 20, 0),
                    margin: EdgeInsets.fromLTRB(
                        5, 10, 20, 0), // This will be the login form
                    child: Column(
                      children: [
                        Center(
                          child: CircleAvatar(
                            foregroundColor: Colors.green,
                            radius: 100.0,
                            backgroundImage: NetworkImage(
                              'https://admin.shurasd.com/upload/catiguriesIcon/${widget.photo}',
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        buildName(),
                        SizedBox(height: 8.0),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              // session type buttons
                              Text(
                                "نوع الجلسة",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 84, 211, 147),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              // session type buttons
                              Row(
                                children: [
                                  MyRadioListTile<int>(
                                    value: 1,
                                    groupValue: _type,
                                    leading: 'فيديو',
                                    onChanged: (value) {
                                      setState(() => _type = value!);
                                      print(_type);
                                    },
                                  ),
                                  MyRadioListTile<int>(
                                    value: 2,
                                    groupValue: _type,
                                    leading: 'صوت',
                                    onChanged: (value) {
                                      setState(() => _type = value!);
                                      print(_type);
                                    },
                                  ),
                                  MyRadioListTile<int>(
                                    value: 3,
                                    groupValue: _type,
                                    leading: 'نص',
                                    onChanged: (value) {
                                      maincontroller.underDev('home');
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: 3),
                              // date and time buttons
                              Text(
                                "تاريخ  و زمن الجلسة",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 84, 211, 147),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 3),
                              // date and time buttons
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 5, 18, 0),
                                child: Row(
                                  children: [
                                    Center(
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton2(
                                          isExpanded: true,
                                          hint: Row(
                                            children: const [
                                              Icon(
                                                Icons.schedule,
                                                size: 16,
                                                color: Colors.white,
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  'موعد الجلسة',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                          items: items
                                              .map((item) =>
                                                  DropdownMenuItem<String>(
                                                    value: item,
                                                    child: Text(
                                                      item,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ))
                                              .toList(),
                                          value: selectedValue,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedValue = value as String;
                                            });
                                          },
                                          icon: const Icon(
                                            Icons.arrow_forward_ios_outlined,
                                          ),
                                          iconSize: 14,
                                          iconEnabledColor: Colors.white,
                                          iconDisabledColor: Colors.grey,
                                          buttonHeight: 45,
                                          buttonWidth: 250,
                                          buttonPadding: const EdgeInsets.only(
                                              left: 8, right: 8),
                                          buttonDecoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            border: Border.all(
                                              color: Colors.black26,
                                            ),
                                            color: Color(0xFF54D3C2),
                                          ),
                                          buttonElevation: 2,
                                          itemHeight: 40,
                                          itemPadding: const EdgeInsets.only(
                                              left: 14, right: 14),
                                          dropdownMaxHeight: 200,
                                          dropdownWidth: 200,
                                          dropdownPadding: null,
                                          dropdownDecoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            color: Color(0xFF54D3C2),
                                          ),
                                          dropdownElevation: 8,
                                          scrollbarRadius:
                                              const Radius.circular(40),
                                          scrollbarThickness: 6,
                                          scrollbarAlwaysShow: true,
                                          offset: const Offset(-20, 0),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 3),
                              // time of session text
                              Text(
                                "مدة الجلسة",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 84, 211, 147),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 3),
                              // time of session buttons
                              Row(
                                children: [
                                  MyNewRadio<int>(
                                    value: 1,
                                    groupValue: _duration,
                                    leading: '20 دقيقة',
                                    // title: Text('One'),
                                    onChanged: (value) {
                                      setState(() => _duration = value!);
                                      print(_duration);
                                    },
                                  ),
                                  MyNewRadio<int>(
                                    value: 2,
                                    groupValue: _duration,
                                    leading: '30 دقيقة',
                                    // title: Text('Two'),
                                    onChanged: (value) {
                                      setState(() => _duration = value!);
                                      print(_duration);
                                    },
                                  ),
                                  MyNewRadio<int>(
                                    value: 3,
                                    groupValue: _duration,
                                    leading: '40 دقيقة',
                                    // title: Text('Three'),
                                    onChanged: (value) {
                                      setState(() => _duration = value!);
                                      print(_duration);
                                    },
                                  ),
                                ],
                              ),
                              Text(
                                "عنوان الإستشارة",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 84, 211, 147),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 25),
                              // order laste view text
                              Container(
                                child: TextFormField(
                                  controller: _orderTitle,
                                  decoration: ThemeHelper().textInputDecoration(
                                      ' إدخال عنوان الإستشارة ',
                                      'عنوان الإستشارة'),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'يجب إدخال عنوان الإستشارة';
                                    }
                                    return null;
                                  },
                                ),
                                decoration:
                                    ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              SizedBox(height: 25),
                              // button to done
                              Container(
                                decoration:
                                    ThemeHelper().buttonBoxDecoration(context),
                                child: ElevatedButton(
                                  style: ThemeHelper().buttonStyle(),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(40, 10, 40, 10),
                                    child: Text(
                                      'تأكيد الموعد'.toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      print(_type);
                                      print(_duration);
                                      print(_orderTitle.text);
                                      _orderData['console_service_id'] = 1;
                                      _orderData['available_time_id'] = 1;

                                      ordercontroller.orderCreate(
                                          orderData: _orderData,
                                          consoleName: widget.consoleName,
                                          serviceName: widget.service_name,
                                          orderId: widget.order_id);
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildName() => Column(
        children: [
          Text(
            widget.consoleName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Color.fromARGB(255, 41, 109, 75),
            ),
          ),
        ],
      );
}
