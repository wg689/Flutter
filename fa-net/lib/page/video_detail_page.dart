// import 'dart:html' hide Platform;
import 'dart:io';

import 'package:flutter/material.dart' hide NavigationBar;
import 'package:flutter_bili_app/barrage/HiSocket.dart';
import 'package:flutter_bili_app/barrage/hi_barrage.dart';
import 'package:flutter_bili_app/http/core/hi_error.dart';
import 'package:flutter_bili_app/http/core/hi_net.dart';
import 'package:flutter_bili_app/http/dao/video_deatail_dao.dart';
import 'package:flutter_bili_app/model/home_mo.dart';
import 'package:flutter_bili_app/model/video_deatail_mo.dart';
import 'package:flutter_bili_app/model/video_model.dart';
import 'package:flutter_bili_app/util/toast.dart';
import 'package:flutter_bili_app/util/view_util.dart';
import 'package:flutter_bili_app/widget/HiTab.dart';
import 'package:flutter_bili_app/widget/appbar.dart';
import 'package:flutter_bili_app/widget/expand_tile.dart';
import 'package:flutter_bili_app/widget/navigation_bar.dart';
import 'package:flutter_bili_app/widget/video_header.dart';
import 'package:flutter_bili_app/widget/video_large_card.dart';
import 'package:flutter_bili_app/widget/video_toolbar.dart';
import 'package:flutter_bili_app/widget/video_view.dart';
import 'package:flutter_bili_app/http/dao/favorite_dao.dart';

class VideoDetailPage extends StatefulWidget {
  final VideoModel videoModel;
  const VideoDetailPage(this.videoModel);

  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage>
    with TickerProviderStateMixin {
  TabController _controller;
  List tabs = ["简介", "评论66"];
  VideoDetailMo videoDetailMo;
  VideoModel videoModel;
  List<VideoModel> videoList = [];
  HiSocket _hiSocket;

  var _barrageKey = GlobalKey<HiBarrageState>();

  @override
  void initState() {
    super.initState();
    // _barrageKey.currentState.pause;
    print("initStatevideoModel:${widget.videoModel}");

    videoModel = widget.videoModel;
    changeStatusBar(
        color: Colors.black, statusStyle: StatusStyle.LIGHT_CONTENT);
    _controller = TabController(length: tabs.length, vsync: this);
    _loadDetail();
    _initSocket();
  }

  void _initSocket() {
    print('初始化socket:${videoModel.vid}');
    _hiSocket = HiSocket();
    // _hiSocket.open(videoModel.vid).listen((value) {
    // print('收到: $value');
    // });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: videoModel.url != null
            ? MediaQuery.removePadding(
                removeTop: Platform.isIOS,
                context: context,
                child: Column(
                  children: [
                    NavigationBar(
                      color: Colors.black,
                      statusStyle: StatusStyle.LIGHT_CONTENT,
                      height: Platform.isAndroid ? 0 : 46,
                    ),
                    _buildBideoView(),
                    // _tabBar()
                    _buildTabNavigation(),
                    Flexible(
                        child: TabBarView(
                      controller: _controller,
                      children: [
                        _buildDetailList(),
                        Container(
                          child: Text("敬请期待"),
                        )
                      ],
                    ))
                  ],
                ),
              )
            : Container());
  }

  _buildBideoView() {
    print("videoModel:${videoModel}");
    var model = videoModel;
    return VideoView(
      url: model.url,
      cover: model.cover,
      overlayUI: videoAppBar(),
      barrageUI: HiBarrage(key: _barrageKey, vid: model.vid, autoPlay: true),
    );
  }

  _tabBar() {
    return HiTab(
      tabs.map<Tab>((name) {
        return Tab(text: name);
      }).toList(),
      controller: _controller,
    );
  }

  _buildTabNavigation() {
    return Material(
      elevation: 5,
      shadowColor: Colors.grey[100],
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 20),
        height: 39,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _tabBar(),
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(
                Icons.ac_unit_outlined,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildDetailList() {
    return ListView(
      padding: EdgeInsets.all(0),
      children: [...buildContends(), ..._buildVideoList()],
    );
  }

  buildContends() {
    return [
      Container(
        child: VideoHeader(owner: videoModel.owner),
      ),
      ExpandableContent(mo: videoModel),
      VideoToolBar(
        detailMo: videoDetailMo,
        videoModel: videoModel,
        onLike: _doLike,
        onUnLike: _onUnLike,
        onFavorite: _onFavorite,
      )
    ];
  }

  _loadDetail() async {
    try {
      VideoDetailMo result = await VideoDetailDao.get(videoModel.vid);
      print(result);
      setState(() {
        videoDetailMo = result;
        videoModel = result.videoInfo;
        videoList = result.videoList;
      });
    } on NeedAuth catch (e) {
      print(e);
      showWarnToast(e.message);
    } on HiNetError catch (e) {
      print(e);
    }
  }

  void _doLike() {}

  ///取消点赞
  void _onUnLike() {}

  ///收藏
  void _onFavorite() async {
    try {
      var result =
          FavoriteDao.favorite(videoModel.vid, !videoDetailMo.isFavorite);
      print(result);
      videoDetailMo.isFavorite = !videoDetailMo.isFavorite;
      if (videoDetailMo.isFavorite) {
        videoModel.favorite += 1;
      } else {
        videoModel.favorite -= 1;
      }
      setState(() {
        videoDetailMo = videoDetailMo;
        videoModel = videoModel;
      });
      showToast(result['msg']);
    } on NeedAuth catch (e) {
      print(e);
      showWarnToast(e.message);
    } on HiNetError catch (e) {
      print(e);
    }
  }

  _buildVideoList() {
    return videoList
        .map((VideoModel mo) => VideoLargeCard(videoModel: mo))
        .toList();
  }
}
