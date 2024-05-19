import 'package:chatapp/Controller/data%20check.dart';
import 'package:chatapp/Screen/ProfileSetting.dart';
import 'package:chatapp/Screen/allUsersMessagestables.dart';
import 'package:chatapp/Screen/allUsersSearch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../Controller/sendMessagesController.dart';

class NavigatorBAR extends StatefulWidget {
  const NavigatorBAR({super.key});

  @override
  State<NavigatorBAR> createState() => _NavigatorBARState();
}

class _NavigatorBARState extends State<NavigatorBAR> {
  var checkRepeat = false;
  var checkRepeat_message = false;
  var checkRepeat_account = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(horizontal: 24),
      height: 60,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromRGBO(44, 32, 217, 0.541),
          Color.fromRGBO(71, 1, 147, 0.835)
        ]),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 30)
        ],
        
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(onTap: ()async{
            
            setState(() {
              checkRepeat = true;
              Future.delayed(Duration(milliseconds: 500),(){
                setState(() {
                  checkRepeat = false;
                });
                
              });
            });
            await Get.to(AllUsersSearch());
          }, 
          child: LottieBuilder.asset("lib/Assets/system-regular-42-search.json", animate: true,repeat: checkRepeat,),),
          GestureDetector(onTap: ()async{
            
            setState(() {
              checkRepeat_message = true;
              Future.delayed(Duration(milliseconds: 500),(){
                setState(() {
                  checkRepeat_message = false;
                  
                });
                
              });
            });
            await Get.to(AllusersMessagesTables());
          }, child: LottieBuilder.asset("lib/Assets/system-regular-47-chat (1).json", animate: true, repeat: checkRepeat_message,),),
          GestureDetector(onTap: (){
            setState(() {
              checkRepeat_account = true;
              Future.delayed(Duration(milliseconds: 500),(){
                setState(() {
                  checkRepeat_account = false;
                });
                
              });
            });
            Get.to(ProfilSettings());
          }, child: LottieBuilder.asset("lib/Assets/system-regular-8-account (1).json", animate: true, repeat: checkRepeat_account,),),
        ],
      ),
    );
  }
}