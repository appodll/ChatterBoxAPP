import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:chatapp/Constant/LoadingPage.dart';
import 'package:chatapp/Constant/internetConnectionScreen.dart';
import 'package:chatapp/Controller/UserData.dart';
import 'package:chatapp/Controller/sharedprefencesController.dart';
import 'package:chatapp/Model/profilimage.dart';
import 'package:chatapp/Screen/login%20page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Controller/internetconnection.dart';

class ProfilSettings extends StatefulWidget {
  const ProfilSettings({super.key});

  @override
  State<ProfilSettings> createState() => _ProfilSettingsState();
}

class _ProfilSettingsState extends State<ProfilSettings> {
  //void launcURL(Uri uri, bool inApp)async{
    //try{
      //if(await canLaunchUrl(uri)){
       // await launchUrl(uri, mode: LaunchMode.inAppWebView);
      //}else{
        //await launchUrl(uri, mode: LaunchMode.externalApplication);
      //}
    //}catch(e){
      /print(e.toString());
    //}
  //}
  @override
  void initState() {
    super.initState();
    UserData().userData();
  }
  Widget build(BuildContext context) {
    setState(() {
      InternetService().connectionCheck();
    });
    final userController = Get.put(UserData());
    userController.userData();
    return Obx(()=>
      Scaffold(
        appBar: AppBar(
          title: Text("Profil Edit"),
        ),
        body: userController.loading.value == false?Indicator():Container(
          height: Get.height,
          width: Get.width,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("lib/Assets/profilpage (1).png"), 
            fit: BoxFit.cover )
          ),
          child: BlurryContainer(
            blur: 10,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 200,
                    width: 200,
                    child: ProfilPage(),
                  ),
                  Text(userController.name.value, style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                  ),),
                  SizedBox(height: 300,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(onPressed: (){
                        //launcURL(Uri.parse("https://firebase-adminsdk-wussj@chatapp-a9eb5.iam.gserviceaccount.com"), true);
                      Get.to(ConnectionScreen());
                      }, icon: Icon(Icons.share_sharp,
                      color: Colors.black,size: 60,)),
                      IconButton(onPressed: ()async{
                        await DataSave().delete_data();
                        Get.off(Login());
                      }, icon: Icon(Icons.logout_rounded,
                      color: Colors.black,size: 60,))
                    ],
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
