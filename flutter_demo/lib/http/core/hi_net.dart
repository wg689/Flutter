import 'package:flutter_demo/http/core/doi_adaptor.dart';

import '../request/base_request.dart';

import 'hi_error.dart';
import 'hi_net_adapter.dart';
import 'mock_adapter.dart';

class HiNet {
  HiNet._();
  static HiNet? _instance;
  static HiNet? getInstance() {
    _instance ??= HiNet._();
    return _instance;
  }

  Future fire(BaseRequest request) async {
    late HiNetResponse response;
    var error;
    try {
      response = await send(request);
    } on HiNetError catch (e) {
      error = e;
      response = e.data;
      printLog(e.message);
    } catch (e) {
      error = e;
      printLog(e);
    }

    // ignore: unnecessary_null_comparison
    if (response == null) {
      printLog(error);
    }

    var result = response.data;
    printLog(result);
    var status = response.statusCode;
    switch (status) {
      case 200:
        return result;
      case 401:
        throw NeedLogin();
        break;
      case 403:
        throw NeedAuth(result.toString(), data: result);
        break;
      default:
        throw HiNetError(status!, result.toString(), data: result);
        break;
    }
  }

  Future<HiNetResponse<dynamic>> send(BaseRequest request) async {
    HiNetAdapter adapter = DioAdapter();
    return adapter.send(request);
  }

  void printLog(log) {
    // ignore: avoid_print
    print('hi_net:' + log.toString());
  }
}
