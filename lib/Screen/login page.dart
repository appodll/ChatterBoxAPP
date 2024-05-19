import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:chatapp/Constant/LoadingPage.dart';
import 'package:chatapp/Controller/internetconnection.dart';
import 'package:chatapp/Screen/forgotpassword.dart';
import 'package:chatapp/Screen/register%20page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../Controller/Auth/AuthConroller.dart';
import '../Controller/LoginRegisterController.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
  
}

class _LoginState extends State<Login> {
  RxBool visibly = true.obs;
  @override
  void initState() {
    super.initState();
    
  }
  Widget build(BuildContext context) {
    setState(() {
      InternetService().connectionCheck();
    });
    final _auth = Get.put(Auth());
    final _ctrl = Get.put(RegisterController());
    return Scaffold(
      body: Center(
        child: Obx(
          () => _auth.loading.value == true? Indicator():SingleChildScrollView(
            child: Container(
              height: Get.height,
              width: Get.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("lib/Assets/bg login.png"),
                      fit: BoxFit.cover)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: Get.height / 5,
                  ),
                  BlurryContainer(
                    height: 300,
                    width: Get.width - 20,
                    blur: 13,
                    elevation: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: Get.width - 50,
                          child: TextField(
                            style: TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            controller: _ctrl.login_email.value,
                            decoration: InputDecoration(
                              
                              labelText: "Email",
                              labelStyle: TextStyle(color: Colors.white),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(67, 6, 137, 1),
                                  )),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(37, 6, 137, 1),)),
                              prefixIcon: Icon(Icons.email),
                              prefixIconColor: Colors.white
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: Get.width - 50,
                          child: TextField(
                            style: TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            obscureText: visibly.value,
                            controller: _ctrl.login_password.value,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(onPressed: (){
                                setState(() {
                                  visibly.value = !visibly.value;
                                });
                              }, icon: Icon(visibly.value == true? Icons.visibility_off: Icons.visibility, color: Colors.white,)),
                              labelText: "Password",
                              labelStyle: TextStyle(color: Colors.white),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(67, 6, 137, 1),
                                  )),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(37, 6, 137, 1))),
                              prefixIcon: Icon(Icons.lock_outline_rounded),
                              prefixIconColor: Colors.white
                              
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 7,
                            ),
                            TextButton(
                                onPressed: () {
                                  Get.to(ForGotPassw(), transition: Transition.rightToLeftWithFade);
                                },
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 17),
                                ))
                          ],
                        ),
                        SizedBox(
                            width: Get.width - 70,
                            height: 55,
                            child: ElevatedButton(
                              onPressed: () {
                                _auth.signin(
                                    email: _ctrl.login_email.value.text,
                                    password: _ctrl.login_password.value.text);
                              },
                              child: Text(
                                "SIGN IN",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Color.fromARGB(255, 9, 0, 133)),
                                  shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)))),
                            ))
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: Get.height / 3.6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't you have an account?",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                            onPressed: () {
                              Get.off(REGISTER(),
                                  transition: Transition.rightToLeftWithFade);
                            },
                            child: Text(
                              "SING UP",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
