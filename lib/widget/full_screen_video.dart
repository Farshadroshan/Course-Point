
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class FullScreenVideoScreen extends StatefulWidget {
  final VideoPlayerController controller;
  const FullScreenVideoScreen({super.key, required this.controller});

  @override
  State<FullScreenVideoScreen> createState() => _FullScreenVideoScreenState();
}

class _FullScreenVideoScreenState extends State<FullScreenVideoScreen> {
  bool _isPlaying = true;
  bool _controlsVisible = true;
  // Define the skip duration in seconds for fullscreen mode
  final int _skipDuration = 10;

  @override
  void initState() {
    super.initState();
    // Set to landscape orientation for true fullscreen
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    
    // Set to true fullscreen (hide status bar)
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    
    // Start playing the video
    if (!widget.controller.value.isPlaying) {
      widget.controller.play();
      _isPlaying = true;
    }
    
    // Hide controls after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _controlsVisible = false;
        });
      }
    });
  }

  @override
  void dispose() {
    // Restore orientation when exiting fullscreen
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    
    // Restore system UI
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (widget.controller.value.isPlaying) {
        widget.controller.pause();
        _isPlaying = false;
      } else {
        widget.controller.play();
        _isPlaying = true;
      }
    });
  }

  void _skipForward() {
    final Duration currentPosition = widget.controller.value.position;
    final Duration newPosition = currentPosition + Duration(seconds: _skipDuration);
    
    // Make sure we don't skip past the end of the video
    if (newPosition <= widget.controller.value.duration) {
      widget.controller.seekTo(newPosition);
    } else {
      widget.controller.seekTo(widget.controller.value.duration);
    }
  }

  void _skipBackward() {
    final Duration currentPosition = widget.controller.value.position;
    final Duration newPosition = currentPosition - Duration(seconds: _skipDuration);
    
    // Make sure we don't skip before the beginning of the video
    if (newPosition >= Duration.zero) {
      widget.controller.seekTo(newPosition);
    } else {
      widget.controller.seekTo(Duration.zero);
    }
  }

  void _toggleControls() {
    setState(() {
      _controlsVisible = !_controlsVisible;
    });
    
    // Hide controls after 3 seconds if they were just shown
    if (_controlsVisible) {
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          setState(() {
            _controlsVisible = false;
          });
        }
      });
    }
  }

  void _exitFullScreen() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: _toggleControls,
        child: Stack(
          children: [
            // Video player takes the full screen
            Center(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: SizedBox(
                    width: widget.controller.value.size.width,
                    height: widget.controller.value.size.height,
                    child: VideoPlayer(widget.controller),
                  ),
                ),
              ),
            ),
            
            // Double tap areas for skipping
            Positioned.fill(
              child: Row(
                children: [
                  // Left half for backward skip
                  Expanded(
                    child: GestureDetector(
                      onDoubleTap: _skipBackward,
                      child: Container(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                  // Right half for forward skip
                  Expanded(
                    child: GestureDetector(
                      onDoubleTap: _skipForward,
                      child: Container(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Controls overlay
            AnimatedOpacity(
              opacity: _controlsVisible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: Visibility(
                visible: _controlsVisible,
                child: Container(
                  color: Colors.black.withOpacity(0.4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Top bar with exit button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.close, color: Colors.white, size: 30),
                            onPressed: _exitFullScreen,
                          ),
                        ],
                      ),
                      
                      // Center play/pause button
                      Center(
                        child: IconButton(
                          icon: Icon(
                            _isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                            color: Colors.white,
                            size: 70,
                          ),
                          onPressed: _togglePlayPause,
                        ),
                      ),
                      
                      // Bottom controls
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            // Progress bar
                            VideoProgressIndicator(
                              widget.controller,
                              allowScrubbing: true,
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              colors: const VideoProgressColors(
                                playedColor: Colors.teal,
                                bufferedColor: Colors.grey,
                                backgroundColor: Colors.white,
                              ),
                            ),
                            
                            // Control buttons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.replay_10, color: Colors.white, size: 30),
                                  onPressed: _skipBackward,
                                ),
                                IconButton(
                                  icon: Icon(
                                    _isPlaying ? Icons.pause : Icons.play_arrow,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  onPressed: _togglePlayPause,
                                ),
                                IconButton(
                                  icon: const Icon(Icons.forward_10, color: Colors.white, size: 30),
                                  onPressed: _skipForward,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}