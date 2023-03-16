// import 'package:h/http/core/hi_net.dart';
import 'package:flutter_bili_app/http/request/favorite_request.dart';
import 'package:flutter_bili_app/http/request/base_request.dart';
import 'package:flutter_bili_app/http/request/cancel_favorite_request.dart';
import 'package:flutter_bili_app/http/request/favorite_request.dart';
import 'package:hi_net/request/hi_base_request.dart';
import 'package:flutter_bili_app/page/favorite_page.dart';
import 'package:hi_net/hi_net.dart';

class FavoriteDao {
  static favorite(String vid, bool favorite) async {
    HiBaseRequest request =
        favorite ? FavoriteRequest() : CancelFavoriteRequest();
    request.pathParams = vid;
    var result = await HiNet.getInstance().fire(request);
    print(result);
    return result;
  }
}
