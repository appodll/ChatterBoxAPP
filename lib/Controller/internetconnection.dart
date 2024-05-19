import 'package:chatapp/Constant/internetConnectionScreen.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetService{
  Future<void>connectionCheck()async{
    final bool isConnected = await InternetConnectionChecker().hasConnection;
    if (isConnected == false){
      Get.off(ConnectionScreen());
    }
  }
}