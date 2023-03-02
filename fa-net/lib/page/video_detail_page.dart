import 'package:flutter/material.dart';
import 'package:flutter_bili_app/model/home_mo.dart';
import 'package:flutter_bili_app/util/view_util.dart';
import 'package:flutter_bili_app/widget/navigation_bar.dart';
import 'package:flutter_bili_app/widget/video_view.dart';

import '../model/video_model.dart';

class VideoDetailPage extends StatefulWidget {
  final VideoMo videoModel;
  const VideoDetailPage(this.videoModel);

  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  @override
  void initState() {
    super.initState();
    changeStatusBar(
        color: Colors.black, statusStyle: StatusStyle.LIGHT_CONTENT);
    // _controller =
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        _videoView(),
        Text("视频详情页 vid:${widget.videoModel.vid}"),
        Text("视频详情页 title:${widget.videoModel.title}"),
      ]),
    );
  }

  _videoView() {
    var model = widget.videoModel;
    return VideoView(url: model.url, cover: model.cover);
  }
}
