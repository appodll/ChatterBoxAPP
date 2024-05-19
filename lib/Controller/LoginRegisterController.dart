import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController{
  Rx<TextEditingController> register_name = TextEditingController().obs;
  Rx<TextEditingController> register_email = TextEditingController().obs;
  Rx<TextEditingController> register_password = TextEditingController().obs;
  Rx<TextEditingController> login_email= TextEditingController().obs;
  Rx<TextEditingController> login_password= TextEditingController().obs;
  Rx<TextEditingController> forgot_password= TextEditingController().obs;
  /////////////////////////////////////////////////////////////////////////
  Rx<TextEditingController> send_message_controller= TextEditingController().obs;
}