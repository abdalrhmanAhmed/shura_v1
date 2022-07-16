// ignore_for_file: sort_child_properties_last, avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shura/view/helpers/theme_helper.dart';

class ConsoleRegisterScreen extends StatefulWidget {
  const ConsoleRegisterScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RegistrationPageState();
  }
}

class _RegistrationPageState extends State<ConsoleRegisterScreen> {
  // final mainController = Get.find<MainController>();
  final _emailController = TextEditingController();
  final _userName = TextEditingController();
  final _userPhone = TextEditingController();
  final _passwordController = TextEditingController();
  final _rePasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _registerData = {};
  bool checkedValue = false;
  bool checkboxValue = false;
  String? selectedValue;
  File? image;

  Future pickImageg() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('feld to pick image : $e');
    }
  }

  Future pickImagec() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('feld to pick image : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(25, 50, 25, 10),
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // start avatar icon
                          GestureDetector(
                            child: Stack(
                              children: [
                                Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                          width: 5, color: Colors.white),
                                      color: Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 20,
                                          offset: Offset(5, 5),
                                        ),
                                      ],
                                    ),
                                    child: image != null
                                        ? Container(
                                            width: 130,
                                            height: 130,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: FileImage(image!),
                                              ),
                                            ),
                                          )
                                        : IconButton(
                                            onPressed: () {},
                                            icon: const Icon(Icons.person),
                                            iconSize: 80,
                                            color: Colors.black12,
                                          )),
                                InkWell(
                                  child: Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 100, 0, 0),
                                    child: Icon(
                                      Icons.add_circle,
                                      color: Colors.blue.shade700,
                                      size: 25.0,
                                    ),
                                  ),
                                  onTap: () => showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        _buildPopupDialog(context),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // end avatar icon

                          const SizedBox(height: 20),
                          // start user name
                          Container(
                            child: TextFormField(
                              controller: _userName,
                              decoration: ThemeHelper().textInputDecoration(
                                  ' اسم المستخدم ', 'ادخل اسم المستخدم'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'يجب إدخال إسم المستخدم';
                                }
                                return null;
                              },
                            ),
                            decoration:
                                ThemeHelper().inputBoxDecorationShaddow(),
                          ),
                          // end user name
                          const SizedBox(height: 20.0),
                          // start email
                          Container(
                            child: TextFormField(
                              controller: _emailController,
                              decoration: ThemeHelper().textInputDecoration(
                                  "الايميل", "ادخل الايميل"),
                              keyboardType: TextInputType.emailAddress,
                            ),
                            decoration:
                                ThemeHelper().inputBoxDecorationShaddow(),
                          ),
                          // end email
                          const SizedBox(height: 20.0),
                          // start phone number
                          Container(
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'يجب إدخال رقم الهاتف';
                                }
                                return null;
                              },
                              controller: _userPhone,
                              decoration: ThemeHelper().textInputDecoration(
                                  "رقم الهاتف", "ادخل رقم الهاتف"),
                              keyboardType: TextInputType.phone,
                            ),
                            decoration:
                                ThemeHelper().inputBoxDecorationShaddow(),
                          ),
                          // end phone number
                          const SizedBox(height: 20.0),
                          // start password
                          Container(
                            child: TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: ThemeHelper().textInputDecoration(
                                  "كلمة المرور", "ادخل كلمة المرور"),
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "من فضلك أدخل رقمك السري";
                                }
                                return null;
                              },
                            ),
                            decoration:
                                ThemeHelper().inputBoxDecorationShaddow(),
                          ),
                          // end password
                          const SizedBox(height: 20.0),
                          // start re password
                          Container(
                            child: TextFormField(
                              controller: _rePasswordController,
                              obscureText: true,
                              decoration: ThemeHelper().textInputDecoration(
                                  "تاكيد كلمة المرور",
                                  "ادخل تاكيد كلمة المرور"),
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "من فضلك أدخل رقمك السري";
                                }
                                return null;
                              },
                            ),
                            decoration:
                                ThemeHelper().inputBoxDecorationShaddow(),
                          ),
                          // end re password
                          const SizedBox(height: 10.0),
                          // start termes
                          FormField<bool>(
                            builder: (state) {
                              return Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Checkbox(
                                          value: checkboxValue,
                                          onChanged: (value) {
                                            setState(() {
                                              checkboxValue = value!;
                                              state.didChange(value);
                                            });
                                          }),
                                      const Text(
                                        "أوافق على جميع الشروط والأحكام.",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      state.errorText ?? '',
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  )
                                ],
                              );
                            },
                            validator: (value) {
                              if (!checkboxValue) {
                                return 'تحتاج إلى قبول الشروط والأحكام';
                              } else {
                                return null;
                              }
                            },
                          ),
                          // end termes
                          const SizedBox(height: 10.0),
                          // start gender
                          // end gender
                          const SizedBox(height: 10.0),
                          // start send button
                          Container(
                            decoration:
                                ThemeHelper().buttonBoxDecoration(context),
                            child: ElevatedButton(
                              style: ThemeHelper().buttonStyle(),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(40, 10, 40, 10),
                                child: Text(
                                  "تسجيل".toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _registerData['name'] = _userName.text;
                                  _registerData['email'] =
                                      _emailController.text;
                                  _registerData['password'] =
                                      _passwordController.text;
                                  _registerData['phone'] = _userPhone.text;
                                  _registerData['country'] = "Sudan";
                                  _registerData['gendor'] = 1;
                                  _registerData['type'] = 1;
                                  // authController.register(
                                  //     registerData: _registerData);
                                }
                              },
                            ),
                          ),
                          // end send button
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPopupDialog(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        title: const Text('إختيار الصورة عن طريق ...'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // ignore: deprecated_member_use
                RaisedButton(
                  padding: const EdgeInsets.all(30),
                  color: Colors.white,
                  child: const Icon(
                    Icons.camera,
                    color: Colors.blue,
                    size: 30,
                  ),
                  onPressed: () => pickImagec(),
                ),
                const SizedBox(
                  width: 25.0,
                ),
                // ignore: deprecated_member_use
                RaisedButton(
                  padding: const EdgeInsets.all(30),
                  color: Colors.white,
                  child: const Icon(
                    Icons.image,
                    color: Colors.blue,
                    size: 30,
                  ),
                  onPressed: () => pickImageg(),
                )
              ],
            )
          ],
        ),
        actions: <Widget>[
          // ignore: deprecated_member_use
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            textColor: Theme.of(context).primaryColor,
            child: const Text('إغلاق'),
          ),
        ],
      ),
    );
  }
}
