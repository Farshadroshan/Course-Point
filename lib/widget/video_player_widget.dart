

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatelessWidget{

  final VideoPlayerController controller;
  final bool isMuted;
  final bool isPlaying;
  final VoidCallback toggleMute;
  final VoidCallback togglePlayPause;
  final VoidCallback skipForward;
  final VoidCallback skipBackward;
  final VoidCallback goToFullScreen;

  const VideoPlayerWidget ({
    Key? key,
    required this.controller,
    required this.isMuted,
    required this.isPlaying,
    required this.toggleMute,
    required this.togglePlayPause,
    required this.skipForward,
    required this.skipBackward,
    required this.goToFullScreen,
  }):super (key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
      child: Container(
        width: double.infinity,
        height: mediaQuery.size.height * 0.24,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            controller.value.isInitialized
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: AspectRatio(
                      aspectRatio: controller.value.aspectRatio,
                      child: Stack(
                        children: [
                          VideoPlayer(controller),
                          Positioned.fill(
                            child: Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onDoubleTap: skipBackward,
                                    child: Container(color: Colors.transparent),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onDoubleTap: skipForward,
                                    child: Container(color: Colors.transparent),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : const Center(child: CircularProgressIndicator()),
            Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      isMuted ? Icons.volume_off : Icons.volume_up,
                      color: Colors.white,
                    ),
                    onPressed: toggleMute,
                  ),
                  IconButton(
                    icon: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                    ),
                    onPressed: togglePlayPause,
                  ),
                  Expanded(
                    child: VideoProgressIndicator(
                      controller,
                      allowScrubbing: true,
                      colors: const VideoProgressColors(
                        playedColor: Colors.teal,
                        bufferedColor: Colors.grey,
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.fullscreen, color: Colors.white),
                    onPressed: goToFullScreen,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}