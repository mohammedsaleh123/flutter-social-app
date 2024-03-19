import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class HomeController extends GetxController {
  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void dispose() {
    videoPlayerController!.dispose();
    super.dispose();
  }

  VideoPlayerController? videoPlayerController;
  bool isVideoPlaying = false;

  VideoPlayer displayVideo(String videoUrl) {
    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(videoUrl));
    videoPlayerController!.initialize();
    return VideoPlayer(videoPlayerController!);
  }

  switchBetweenImageAndVideo() {
    isVideoPlaying = !isVideoPlaying;
    update();
  }
}
