import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:mawaheb_app/base/utils/api_helper.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({Key key, this.videoUid}) : super(key: key);

  final String videoUid;

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  VideoPlayerController _controller;
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      '$BASE_API/ws/public/metaFiles/${widget.videoUid}/view',
    );

    _chewieController = ChewieController(
      allowedScreenSleep: false,
      allowFullScreen: true,
      videoPlayerController: _controller,
      aspectRatio: 16 / 9,
      autoInitialize: true,
      autoPlay: false,
      showControls: true,
      showControlsOnInitialize: false,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Chewie(
      controller: _chewieController,
    );
  }
}
