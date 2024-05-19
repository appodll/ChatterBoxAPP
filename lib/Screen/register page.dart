import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:chatapp/Controller/Auth/AuthConroller.dart';
import 'package:chatapp/Controller/LoginRegisterController.dart';
import 'package:chatapp/Constant/LoadingPage.dart';
import 'package:chatapp/Screen/login%20page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/internetconnection.dart';

class REGISTER extends StatefulWidget {
  const REGISTER({super.key});

  @override
  State<REGISTER> createState() => _REGISTERState();
}

class _REGISTERState extends State<REGISTER> {
  RxBool visibly = true.obs;
  @override

  Widget build(BuildContext context) {
    setState(() {
      InternetService().connectionCheck();
    });
    final _auth = Get.put(Auth());
    final _ctrl = Get.put(RegisterController());
    return Scaffold(
      body: Obx(()=>
        _auth.loading.value == true? Indicator():SingleChildScrollView(
          child: Container(
            height: Get.height,
            width: Get.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("lib/Assets/registerbg.jpeg"),
                    fit: BoxFit.cover)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Container(
                  padding: EdgeInsets.only(top: Get.height / 6),
                  child: BlurryContainer(
                    elevation: 200,
                    height: 350,
                    blur: 15,
                    
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        
                        Container(
                          width: Get.width - 50,
                          child: TextField(
                            style: TextStyle(color: Colors.white),
                            controller: _ctrl.register_name.value,
                            decoration: InputDecoration(
                              labelText: "Username",
                              labelStyle: TextStyle(color: Colors.white),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(67, 6, 137, 1),
                                  )),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(50, 6, 137, 1),)),
                              prefixIcon: Icon(Icons.account_circle_rounded),
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
                            controller: _ctrl.register_email.value,
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
                                      color: Color.fromRGBO(6, 9, 137, 0.8))),
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
                            obscureText: visibly.value,
                            controller: _ctrl.register_password.value,
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
                                      color: Color.fromRGBO(6, 9, 137, 0.8))),
                              prefixIcon: Icon(Icons.lock),
                              prefixIconColor: Colors.white
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                            width: Get.width - 70,
                            height: 55,
                            child: ElevatedButton(
                              onPressed: () async {
                                await _auth.singup(
                                    email: _ctrl.register_email.value.text.toString(),
                                    name: _ctrl.register_name.value.text.toString(),
                                    password: _ctrl.register_password.value.text.toString());
                              },
                              child: Text(
                                "SIGN UP",
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
                ),
                Container(
                  padding: EdgeInsets.only(top: Get.height / 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Do you have an account?",
                        style:
                            TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                          onPressed: () {
                            Get.off(Login(),
                                transition: Transition.leftToRightWithFade);
                          },
                          child: Text(
                            "SING IN",
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
    );
  }
}
