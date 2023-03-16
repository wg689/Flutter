import 'package:flutter_bili_app/http/dao/login_dao.dart';
import 'package:hi_net/request/hi_base_request.dart';
import 'package:flutter_bili_app/util/hi_constants.dart';

abstract class BaseRequest extends HiBaseRequest {
  @override
  String url() {
    if (needLogin()) {
      addHeader(LoginDao.BOARDING_PASS, LoginDao.getBoardingPass());
    }
    return super.url();
  }

  Map<String, dynamic> header = {
    HiConstants.authTokenK: HiConstants.authTokenV,
    HiConstants.courseFlagK: HiConstants.courseFlagV
    // 'course-flag': 'fa',
    // //访问令牌，在课程公告获取
    // // "auth-token": "MjAyMC0wNi0yMyAwMzoyNTowMQ==fa",
    // "auth-token": "ZmEtMjAyMS0wNC0xMiAyMToyMjoyMC1mYQ==fa",
  };
}
