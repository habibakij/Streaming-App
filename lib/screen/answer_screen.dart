
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:streamingapp/controller/video_handle_controller.dart';

class AnswerScreen extends StatelessWidget {
  final videoHandlerController= Get.put(VideoHandleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dialog Answer List",),
      ),
      body: videoHandlerController.selectDialogList.isEmpty ? const Center(
        child: Text("Empty", style: TextStyle(fontSize: 18)),
      ) : Obx(() => ListView.builder(
        itemCount: videoHandlerController.selectDialogList.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index){
          return Container(
            height: 50,
            margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
            padding: const EdgeInsets.only(left: 10, right: 5),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: Colors.grey.withOpacity(.3),
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              "Answer: ${videoHandlerController.selectDialogList[index].toString()}",
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
          );
        },
      ),),
    );
  }
}
