import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mawaheb_app/base/utils/api_helper.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({Key? key, this.videoUid, this.videoUrl}) : super(key: key);

  final String? videoUid;
  final String? videoUrl;

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      widget.videoUrl ?? '$BASE_API/ws/public/metaFiles/${widget.videoUid}/view',
    );

    _chewieController = ChewieController(
      allowedScreenSleep: false,
      allowFullScreen: true,
      videoPlayerController: _controller,
      aspectRatio: 16 / 9,
      autoInitialize: true,
      deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
      deviceOrientationsOnEnterFullScreen: [DeviceOrientation.landscapeLeft],
      autoPlay: false,
      showControls: true,
      showControlsOnInitialize: false,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Chewie(
      controller: _chewieController,
    );
  }
}

class VideoPlayerWidget2 extends StatefulWidget {
  const VideoPlayerWidget2({Key? key, this.videoUid, this.videoUrl}) : super(key: key);

  final String? videoUid;
  final String? videoUrl;

  @override
  _VideoPlayerWidgetState2 createState() => _VideoPlayerWidgetState2();
}

class _VideoPlayerWidgetState2 extends State<VideoPlayerWidget2> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      widget.videoUrl ?? '$BASE_API/ws/public/metaFiles/${widget.videoUid}/view',
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
  void didUpdateWidget(VideoPlayerWidget2 oldWidget) {
    print('my debug 11111');
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoUrl != widget.videoUrl) {
      print('my debug 22222');

      _controller.dispose();
      _chewieController.dispose();
      _controller = VideoPlayerController.network(
        widget.videoUrl ?? '$BASE_API/ws/public/metaFiles/${widget.videoUid}/view',
      );

      _chewieController = ChewieController(
        allowedScreenSleep: false,
        allowFullScreen: true,
        videoPlayerController: _controller,
        aspectRatio: 16 / 9,
        autoInitialize: true,
        autoPlay: true,
        showControls: true,
        showControlsOnInitialize: false,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Chewie(
      controller: _chewieController,
    );
  }
}
