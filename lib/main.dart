
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:streamingapp/controller/video_handle_controller.dart';
import 'package:streamingapp/screen/answer_screen.dart';
import 'package:streamingapp/screen/video_play_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GetMaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Video Player',
    home: MainPage(),
  );
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  var videoController= Get.put(VideoHandleController());

  var videoList= [
    'assets/videoone.mp4',
    'assets/videotwo.mp4',
    'assets/videothree.mp4',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Streaming App"),
      ),
      body: Column(
        children: [

          ListView.builder(
            itemCount: videoList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index){
              return InkWell(
                child: Container(
                  height: 50,
                  margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: Colors.grey.withOpacity(.4),
                  ),
                  child: Row(
                    children: [

                      ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        child: Image.network(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTEnzCBaXu7zwqI4Rz48Z-2EWU0Uwp1Br8moA&usqp=CAU",
                          height: 35,
                          width: 35,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        videoList[index].toString(),
                        style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black
                        ),
                      ),

                    ],
                  ),
                ),
                onTap: (){
                  videoController.countPlayBack.value= 0;
                  Get.to(VideoPlayScreen(), arguments: videoList[index]);
                },
              );
            },
          ),

          Container(
            height: 45,
            width: 200,
            margin: const EdgeInsets.only(top: 30, left: 10, right: 10),
            padding: const EdgeInsets.only(left: 5, right: 5),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: Colors.grey.withOpacity(.4),
            ),
            child: TextButton(
              onPressed: (){
                Get.to(AnswerScreen());
              },
              child: const Text(
                "See Answer",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ),


        ],
      ),
    );
  }
}