import 'package:flutter_bili_app/http/core/hi_net.dart';
import 'package:flutter_bili_app/http/request/ranking_request.dart';
import 'package:flutter_bili_app/model/ranking_mo.dart';

class RankingDao {
  static get(String sort, {int pageIndex = 1, pageSize = 10}) async {
    RankingRequest request = RankingRequest();
    request
        .add("sort", sort)
        .add("pageSize", pageSize)
        .add("pageIndex", pageIndex);
    var result = await HiNet.getInstance().fire(request);
    return RankingMo.fromJson(result["data"]);
  }
}
