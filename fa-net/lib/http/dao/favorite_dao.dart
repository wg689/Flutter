import 'package:flutter_bili_app/http/core/hi_net.dart';
import 'package:flutter_bili_app/http/request/favorite_request.dart';
import 'package:flutter_bili_app/http/request/base_request.dart';
import 'package:flutter_bili_app/http/request/cancel_favorite_request.dart';
import 'package:flutter_bili_app/http/request/favorite_request.dart';
import 'package:flutter_bili_app/page/favorite_page.dart';

class FavoriteDao {
  static favorite(String vid, bool favorite) async {
    BaseRequest request =
        favorite ? FavoriteRequest() : CancelFavoriteRequest();
    request.pathParams = vid;
    var result = await HiNet.getInstance().fire(request);
    print(result);
    return result;
  }
}
