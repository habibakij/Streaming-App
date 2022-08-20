import 'package:get/get.dart';

class VideoHandleController extends GetxController {


  @override
  void onInit() {
    super.onInit();
  }

  RxBool idPlayVideo= true.obs;
  RxInt countPlayBack= 0.obs;
  RxList selectDialogList= [].obs;

}