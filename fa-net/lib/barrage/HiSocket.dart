import 'package:flutter/cupertino.dart';
import 'package:flutter_bili_app/http/dao/login_dao.dart';
import 'package:flutter_bili_app/model/barrage_model.dart';
import 'package:flutter_bili_app/util/hi_constants.dart';
import 'package:web_socket_channel/io.dart';

class HiSocket implements ISocket {
  static const _URL = 'wss://api.devio.org/uapi/fa/barrage';
  IOWebSocketChannel _channel;

  ValueChanged<List<BarrageModel>> _callBack;
  int _intervalSeconds = 50;
  @override
  void close() {
    if (_channel != null) {
      _channel.sink.close();
    }
  }

  @override
  ISocket listen(callBack) {
    _callBack = callBack;
    return this;
  }

  @override
  ISocket send(String message) {
    _channel.sink.add(message);
    return this;
  }

  @override
  ISocket open(String vid) {
    _channel = IOWebSocketChannel.connect(_URL + vid,
        headers: _headers(), pingInterval: Duration(seconds: _intervalSeconds));
    _channel.stream.handleError((error) {
      print('连接发生错误$error');
    }).listen((message) {
      _handleMessage(message);
    });
  }

  _headers() {
    Map<String, dynamic> header = {
      HiConstants.authTokenK: HiConstants.authTokenK,
      HiConstants.courseFlagK: HiConstants.courseFlagK
    };
    header[LoginDao.BOARDING_PASS] = LoginDao.getBoardingPass();
    return header;
  }

  void _handleMessage(message) {
    print('received:$message');
    var result = BarrageModel.fromJsonString(message);
    if (result != null && _callBack != null) {
      _callBack(result);
    }
  }
}

abstract class ISocket {
  ISocket open(String vid);

  ISocket send(String message);

  void close();

  ISocket listen(ValueChanged<List<BarrageModel>> callBack);
}
