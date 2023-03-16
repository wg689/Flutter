import 'package:hi_net/hi_net.dart';
import 'package:flutter_bili_app/http/request/video_deatail_request.dart';
import 'package:flutter_bili_app/model/video_deatail_mo.dart';

//详情页
class VideoDetailDao {
  static get(String vid) async {
    VideoDetailRequest request = VideoDetailRequest();
    request.pathParams = vid;
    var result = await HiNet.getInstance().fire(request);
    print(request);
    return VideoDetailMo.fromJson(result['data']);
  }
}
