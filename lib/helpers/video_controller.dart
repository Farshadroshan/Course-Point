import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:coursepoint/widget/full_screen_video.dart';

class VideoControlsHelper {
  static const int skipDuration = 10;

  static void skipForward(VideoPlayerController controller) {
    final Duration currentPosition = controller.value.position;
    final Duration newPosition = currentPosition + const Duration(seconds: skipDuration);

    if (newPosition <= controller.value.duration) {
      controller.seekTo(newPosition);
    } else {
      controller.seekTo(controller.value.duration);
    }
  }

  static void skipBackward(VideoPlayerController controller) {
    final Duration currentPosition = controller.value.position;
    final Duration newPosition = currentPosition - const Duration(seconds: skipDuration);

    if (newPosition >= Duration.zero) {
      controller.seekTo(newPosition);
    } else {
      controller.seekTo(Duration.zero);
    }
  }

  static void goToFullScreen(BuildContext context, VideoPlayerController controller) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenVideoScreen(controller: controller),
      ),
    );
  }
}
