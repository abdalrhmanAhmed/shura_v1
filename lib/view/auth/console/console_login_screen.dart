// ignore_for_file: library_private_types_in_public_api, sort_child_properties_last

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shura/controllers/auth/client/client_auth_controller.dart';
import 'package:shura/view/helpers/theme_helper.dart';
import 'package:shura/view/auth/console/console_register_screen.dart';
import 'package:shura/view/auth/forgot_password_page.dart';

class ConsoleLoginScreen extends StatefulWidget {
  const ConsoleLoginScreen({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<ConsoleLoginScreen> {
  final clientAuthController = Get.put(ClientAuthController());

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _loginData = {};

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              const Center(),
              SafeArea(
                child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    margin: const EdgeInsets.fromLTRB(
                        10, 10, 20, 10), // This will be the login form
                    child: Column(
                      children: [
                        Center(
                          child: Image.asset(
                            "images/shura.jpeg",
                            width: 350,
                          ),
                        ),
                        const SizedBox(height: 40.0),
                        Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Container(
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'يجب إدخال رقم الهاتف';
                                      }
                                      return null;
                                    },
                                    controller: _emailController,
                                    decoration:
                                        ThemeHelper().textInputDecoration(
                                      'رقم الهاتف',
                                      'ادخل رقم الهاتف',
                                    ),
                                    keyboardType: TextInputType.phone,
                                  ),
                                  decoration:
                                      ThemeHelper().inputBoxDecorationShaddow(),
                                ),
                                const SizedBox(height: 20.0),
                                Container(
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'يجب إدخال  كلمة السر';
                                      }
                                      return null;
                                    },
                                    controller: _passwordController,
                                    obscureText: true,
                                    decoration: ThemeHelper()
                                        .textInputDecoration(
                                            'كلمة المرور', 'ادخل كلمة المرور'),
                                  ),
                                  decoration:
                                      ThemeHelper().inputBoxDecorationShaddow(),
                                ),
                                const SizedBox(height: 10.0),
                                Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 20),
                                  alignment: Alignment.topRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.to(() => const ForgotPasswordPage());
                                    },
                                    child: const Text(
                                      "هل نسيت كلمة السر",
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: ThemeHelper()
                                      .buttonBoxDecoration(context),
                                  child: ElevatedButton(
                                    style: ThemeHelper().buttonStyle(),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          40, 10, 40, 10),
                                      child: Text(
                                        'دخول'.toUpperCase(),
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                    onPressed: () {
                                      //After successful login we will redirect to profile page. Let's create profile page now
                                      if (_formKey.currentState!.validate()) {
                                        _loginData['phone'] =
                                            _emailController.text;
                                        _loginData['password'] =
                                            _passwordController.text;
                                        clientAuthController.login(
                                            loginData: _loginData);
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(10, 20, 10, 20),
                                  //child: Text('Don\'t have an account? Create'),
                                  child: Text.rich(TextSpan(children: [
                                    const TextSpan(
                                        text: "ليس لديك حساب كمستشار ؟"),
                                    TextSpan(
                                      text: 'انشاء حساب',
                                      style: const TextStyle(
                                          color: Color(0xff00695c)),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Get.to(() =>
                                              const ConsoleRegisterScreen());
                                        },
                                    ),
                                  ])),
                                ),
                              ],
                            )),
                      ],
                    )),
              ),
              Row(
                children: [
                  Expanded(child: Container()),
                  Container(
                      width: 50,
                      height: 50,
                      margin: const EdgeInsets.only(
                          top: 5, bottom: 15, left: 10, right: 0),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                const Color(0xFFFCFCFC).withOpacity(0.8),
                                const Color(0xffffffff),
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.centerRight),
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30),
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                              topRight: Radius.circular(30)),
                          boxShadow: const [
                            BoxShadow(
                                offset: Offset(5, 8),
                                blurRadius: 10,
                                color: Color(0xFFE4EBEE))
                          ]),
                      child: Column(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.facebook_outlined),
                            iconSize: 33,
                            color: Colors.lightBlue,
                          ),
                        ],
                      )),
                  const SizedBox(
                    width: 15,
                  ),
                  Container(
                      width: 50,
                      height: 50,
                      margin: const EdgeInsets.only(
                          top: 5, bottom: 15, left: 10, right: 0),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                const Color(0xFFFCFCFC).withOpacity(0.8),
                                const Color(0xffffffff),
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.centerRight),
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30),
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                              topRight: Radius.circular(30)),
                          boxShadow: const [
                            BoxShadow(
                                offset: Offset(5, 8),
                                blurRadius: 10,
                                color: Color(0xFFE4EBEE))
                          ]),
                      child: Column(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.phone_enabled_outlined),
                            iconSize: 30,
                            color: Colors.green,
                          ),
                        ],
                      )),
                  const SizedBox(
                    width: 15,
                  ),
                  Container(
                      width: 50,
                      height: 50,
                      margin: const EdgeInsets.only(
                          top: 5, bottom: 15, left: 10, right: 0),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                const Color(0xFFFCFCFC).withOpacity(0.8),
                                const Color(0xffffffff),
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.centerRight),
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30),
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                              topRight: Radius.circular(30)),
                          boxShadow: const [
                            BoxShadow(
                                offset: Offset(5, 8),
                                blurRadius: 10,
                                color: Color(0xFFE4EBEE))
                          ]),
                      child: Column(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.language),
                            iconSize: 30,
                            color: Colors.redAccent,
                          ),
                        ],
                      )),
                  Expanded(child: Container()),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                  child: const Text(
                    "powered By : Eva Soft Solutions",
                    style: TextStyle(
                        color: Color(0xFF54D3C2), fontWeight: FontWeight.bold),
                  ),
                  onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
