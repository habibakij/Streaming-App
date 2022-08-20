
import 'dart:developer';

import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:get/get.dart';
import 'package:streamingapp/controller/video_handle_controller.dart';

class VideoPlayerWidget extends StatelessWidget {
  VideoPlayerWidget({Key? key, required this.controller}) : super(key: key);
  final VideoPlayerController controller;
  final videoHandlerController= Get.put(VideoHandleController());
  int countPlayBack= 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        controller != null && controller.value.isInitialized ?
        Container(
          alignment: Alignment.topCenter,
          child: Stack(
            children: <Widget>[
              buildVideo(),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: VideoProgressIndicator(
                  controller,
                  allowScrubbing: true,
                ),
              ),
            ],
          ),
        ) : Container(
          margin: EdgeInsets.zero,
          height: 200,
          child: const Center(child: CircularProgressIndicator()),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

            TextButton(
              onPressed: (){
                if(countPlayBack == 0){
                  playBackPopUpDialog(context);
                }
                countPlayBack= 1;
                videoPlaced((currentPosition) => currentPosition - const Duration(seconds: 5));
              },
              child: const Icon(
                Icons.fast_rewind,
                size: 50,
                color: Colors.blue,
              ),
            ),
            TextButton(
              onPressed: (){
                if(controller.value.isPlaying){
                  controller.pause();
                  videoHandlerController.idPlayVideo.value= false;
                } else {
                  controller.play();
                  videoHandlerController.idPlayVideo.value= true;
                }
              },
              child: Obx(() => Icon(
                videoHandlerController.idPlayVideo.value == false ? Icons.play_arrow : Icons.pause,
                size: 50,
                color: Colors.blue,
              ),),
            ),
            TextButton(
              onPressed: (){
                videoPlaced((currentPosition) => currentPosition + const Duration(seconds: 5));
              },
              child: const Icon(
                Icons.fast_forward,
                size: 50,
                color: Colors.blue,
              ),
            ),


          ],
        ),

      ],
    );
  }

  Widget buildVideo() => Stack(
    children: <Widget>[
      buildVideoPlayer(),
      //Positioned.fill(child: BasicOverlayWidget(controller: controller,)),
    ],
  );

  Widget buildVideoPlayer() => AspectRatio(
    aspectRatio: controller.value.aspectRatio,
    child: VideoPlayer(controller),
  );

  Future videoPlaced(Duration Function(Duration currentPosition) builder)async{
    final currentPosition= await controller.position;
    final newPosition= builder(currentPosition!);
    await controller.seekTo(newPosition);
  }


  Future<void> playBackPopUpDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return DelayedDisplay(
          delay: const Duration(milliseconds: 100),
          slidingBeginOffset: const Offset(0.0, 0.10),
          child: CupertinoAlertDialog(
            title: const Text(
              "Alert",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            content: Container(
              height: 100,
              width: 150,
              margin: EdgeInsets.zero,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Do you like this video?",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  Container(
                    height: 1,
                    margin: const EdgeInsets.only(top: 10),
                    color: Colors.grey,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [

                      TextButton(
                        onPressed: (){
                          videoHandlerController.selectDialogList.value.add("YES");
                          log("check_: ${videoHandlerController.selectDialogList}");
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "YES",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ),

                      Container(
                        width: 1,
                        height: 50,
                        color: Colors.grey,
                      ),

                      TextButton(
                        onPressed: (){
                          videoHandlerController.selectDialogList.value.add("NO");
                          log("check_: ${videoHandlerController.selectDialogList}");
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "NO",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ),


                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }




}