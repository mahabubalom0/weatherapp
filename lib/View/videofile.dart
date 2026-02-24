import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Videofile extends StatefulWidget {
  const Videofile({super.key});

  @override
  State<Videofile> createState() => _VideofileState();
}

class _VideofileState extends State<Videofile> {

  late VideoPlayerController videocontroller;

  @override
  void initState() {
    super.initState();

    videocontroller = VideoPlayerController.networkUrl(
      Uri.parse("https://samplelib.com/lib/preview/mp4/sample-5s.mp4"),
    )
      ..initialize().then((_) {
        setState(() {});
        videocontroller.play();
      });
  }

  @override
  void dispose() {
    videocontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: videocontroller.value.isInitialized
            ? AspectRatio(
          aspectRatio: videocontroller.value.aspectRatio,
          child: VideoPlayer(videocontroller),
        )
            : const CircularProgressIndicator(),
      ),
    );
  }
}