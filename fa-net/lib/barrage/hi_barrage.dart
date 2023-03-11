import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bili_app/barrage/HiSocket.dart';
import 'package:flutter_bili_app/barrage/barrage_item.dart';
import 'package:flutter_bili_app/model/barrage_model.dart';
import 'package:flutter_bili_app/model/home_mo.dart';
import 'package:flutter_bili_app/util/barrage_view_util.dart';

import 'ibarrage.dart';

enum BarrageStatus { play, pause }

class HiBarrage extends StatefulWidget {
  final int lineCount;
  final String vid;
  final int speed;
  final double top;
  final bool autoPlay;

  const HiBarrage(
      {Key key,
      this.lineCount = 4,
      this.vid,
      this.speed = 800,
      this.top = 0,
      this.autoPlay = false})
      : super(key: key);
  @override
  HiBarrageState createState() => HiBarrageState();
}

class HiBarrageState extends State<HiBarrage> implements IBarrage {
  HiSocket _hiSocket;
  double _height;
  double _width;
  List<BarrageItem> _barrageItemList = [];
  List<BarrageModel> _barrageModelList = [];
  int _barrageIndex = 0;
  Random _random = Random();
  BarrageStatus _barrageStatus;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _hiSocket = HiSocket();

    // _hiSocket.open(widget.vid).listen((value) {
    //   _handleMessage(value);
    // });
    _handleMessage([
      BarrageModel(
          content: "qqeeeqqeeerqqeeerqqeeerqqeeerr",
          vid: '1',
          priority: 1,
          type: 1),
      BarrageModel(content: "222222222qqeeer", vid: '1', priority: 1, type: 1)
    ]);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleMessage(List<BarrageModel> modelList, {bool instant = false}) {
    if (instant) {
      _barrageModelList.insertAll(0, modelList);
    } else {
      _barrageModelList.addAll(modelList);
    }

    if (_barrageStatus == BarrageStatus.play) {
      play();
      return;
    }

    if (widget.autoPlay && _barrageStatus != BarrageStatus.pause) {
      play();
    }
  }

  void play() {
    _barrageStatus = BarrageStatus.play;
    print("action: play");
    if (_timer != null && _timer.isActive) return;
    _timer = Timer.periodic(Duration(milliseconds: widget.speed), (timer) {
      if (_barrageModelList.isNotEmpty) {
        var temp = _barrageModelList.removeAt(0);
        addBarrage(temp);
        print("start :${temp.content}");
      } else {
        print("all barage are send");
        _timer.cancel();
      }
    });
  }

  void addBarrage(BarrageModel model) {
    double perRowHeight = 30;
    var line = _barrageIndex % widget.lineCount;
    _barrageIndex++;
    var top = line * perRowHeight + widget.top;
    String id = '${_random.nextInt(10000)}:{model.content}}';
    var item = BarrageItem(
      id: id,
      top: top,
      child: BarrageViewUtil.barrageView(model),
      onComplete: _onComplete,
    );
    _barrageItemList.add(item);
    setState(() {});
  }

  void pause() {
    _barrageStatus = BarrageStatus.pause;
    _barrageItemList.clear();
    setState(() {});
    print('action:pause');
    _timer.cancel();
  }

  // void dispose() {
  //   if (_hiSocket != null) {
  //     _hiSocket.close();
  //   }
  //   if (_timer != null) {
  //     _timer.cancel();
  //   }
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = _width / 16 * 9;
    return SizedBox(
        width: _width,
        height: _height,
        child: Stack(
          children: [Container()]..addAll(_barrageItemList),
        ));
  }

  @override
  void send(String message) {
    if (message == null) return;
    _hiSocket.send(message);
    var model = [
      BarrageModel(content: message, vid: '-1', priority: 1, type: 1)
    ];
    _handleMessage(model);
  }

  void _onComplete(id) {
    print('done $id');
    _barrageItemList.removeWhere((element) => element.id == id);
  }
}
