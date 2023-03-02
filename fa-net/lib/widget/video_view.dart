import 'package:flutter/material.dart';
import 'package:flutter_bili_app/util/color.dart';
import 'package:flutter_bili_app/util/view_util.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart' hide MaterialControls;
import 'package:flutter_bili_app/widget/hi_video_controls.dart';

class VideoView extends StatefulWidget {
  final String url;
  final String cover;
  final bool autoPlay;
  final bool looping;
  final double aspectRatio;
  final Widget overlayUI;

  const VideoView(
      {Key key,
      this.url,
      this.cover,
      this.autoPlay = false,
      this.looping = false,
      this.aspectRatio = 16 / 9,
      this.overlayUI})
      : super(key: key);

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;

  get _placeholder => FractionallySizedBox(
        widthFactor: 1,
        child: cachedImage(widget.cover),
      );
  get _progressColors => ChewieProgressColors(
      playedColor: primary,
      handleColor: primary,
      backgroundColor: Colors.grey,
      bufferedColor: primary[50]);
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double playerHeight = screenWidth / widget.aspectRatio;
    return Container(
      width: screenWidth,
      height: playerHeight,
      color: Colors.grey,
      child: Chewie(
        controller: _chewieController,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(widget.url);
    _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        aspectRatio: widget.aspectRatio,
        autoPlay: widget.autoPlay,
        looping: widget.looping,
        placeholder: _placeholder,
        allowPlaybackSpeedChanging: false,
        allowMuting: false,
        materialProgressColors: _progressColors,
        customControls: MaterialControls(
          showLoadingOnInitialize: false,
          showBigPlayIcon: false,
          // overlayUI: widget.overlayUI,
        ));
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
    _chewieController.dispose();
  }
}
