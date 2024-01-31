import 'package:get/get.dart';
import '../core/classes/crud.dart';


class InitialBindings extends Bindings {
  @override
  void dependencies() {
    // Start 
    Get.put(Crud()) ; 
  }
}