
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../widget_item/video_pleyer_wid.dart';
import 'package:get/get.dart';

class VideoPlayScreen extends StatefulWidget {
  @override
  _VideoPlayScreenState createState() => _VideoPlayScreenState();
}

class _VideoPlayScreenState extends State<VideoPlayScreen> {
  late VideoPlayerController controller;
  var getVideoFile;

  @override
  void initState() {
    super.initState();
    getVideoFile= Get.arguments;
    log("check_ar: $getVideoFile");
    controller = VideoPlayerController.asset(getVideoFile)
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) => controller.play());
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMuted = controller.value.volume == 0;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Streaming App"),
      ),
      body: Column(
        children: [

          VideoPlayerWidget(controller: controller),

        ],
      ),
    );
  }
}