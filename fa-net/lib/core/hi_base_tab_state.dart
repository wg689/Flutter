import 'package:flutter/material.dart';
import 'package:flutter_bili_app/http/core/hi_error.dart';
import 'package:flutter_bili_app/util/color.dart';
import 'package:flutter_bili_app/util/toast.dart';

import 'package:flutter_bili_app/http/core/hi_state.dart';

abstract class HiBaseTabState<M, L, T extends StatefulWidget>
    extends HiState<T> {
  List<L> dataList = [];
  int pageIndex = 1;
  bool loading = false;
  ScrollController scrollController = ScrollController();
  get contentChild;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      var dis = scrollController.position.maxScrollExtent -
          scrollController.position.pixels;
      print('dis:$dis');
      //当距离底部不足300时加载更多
      if (dis < 300 && !loading) {
        print('------_loadData---');
        loadData(loadMore: true);
      }
    });
    loadData();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // super.build(context);
    return RefreshIndicator(
        onRefresh: loadData,
        color: primary,
        child: MediaQuery.removePadding(
            removeTop: true, context: context, child: contentChild));
  }

  Future<M> getData(int pageIndex);

  ///从MO中解析出list数据
  List<L> parseList(M result);

  Future<void> loadData({loadMore = false}) async {
    if (loading) {
      print("正在加载");
      return;
    }
    loading = true;
    if (!loadMore) {
      pageIndex = 1;
    }
    var currentIndex = pageIndex + (loadMore ? 1 : 0);
    print('loading:currentIndex:$currentIndex');
    try {
      var result = await getData(currentIndex);
      setState(() {
        if (loadMore) {
          dataList = [...dataList, ...parseList(result)];
          if (parseList(result).length != 0) {
            //合成一个新数组
            pageIndex++;
          }
        } else {
          dataList = parseList(result);
        }
      });
      Future.delayed(Duration(milliseconds: 1000), () {
        loading = false;
      });
    } on NeedAuth catch (e) {
      loading = false;
      print(e);
      showWarnToast(e.message);
    } on HiNetError catch (e) {
      loading = false;
      print(e);
      showWarnToast(e.message);
    }
  }

  // bool get wantKeepAlive => true;
}
