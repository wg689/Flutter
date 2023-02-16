import 'package:flutter_demo/http/core/hi_net.dart';
import 'package:flutter_demo/http/core/hi_net_adapter.dart';
import 'package:flutter_demo/http/request/base_request.dart';

class MockAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<dynamic>> send(BaseRequest request) {
    return Future<HiNetResponse>.delayed(Duration(microseconds: 1000), () {
      return HiNetResponse(
          data: {"code": 0, "message": 'success'}, statusCode: 403);
    });
  }
}
