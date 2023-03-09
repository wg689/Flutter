import 'package:flutter/material.dart';
import 'package:flutter_bili_app/http/core/hi_error.dart';
import 'package:flutter_bili_app/http/dao/profile_dao.dart';
import 'package:flutter_bili_app/http/dao/video_deatail_dao.dart';
import 'package:flutter_bili_app/model/profile_mo.dart';
import 'package:flutter_bili_app/util/toast.dart';
import 'package:flutter_bili_app/util/view_util.dart';
import 'package:flutter_bili_app/widget/hi_blur.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileMo _profileMo;
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 160,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                titlePadding: EdgeInsets.only(left: 0),
                title: _buildHead(),
                background: Stack(
                  children: [
                    Positioned.fill(
                        child: cachedImage(
                            "https://www.devio.org/img/beauty_camera/beauty_camera4.jpg")),
                    Positioned.fill(
                        child: HiBlur(
                      sigma: 20,
                      child: null,
                    ))
                  ],
                ),
              ),
            )
          ];
        },
        body: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text("标题$index"),
              );
            },
            itemCount: 20),
      ),
    );
  }

  void _loadData() async {
    try {
      ProfileMo result = await ProfileDao.get();
      print(result);
      setState(() {
        _profileMo = result;
      });
    } on NeedAuth catch (e) {
      print(e);
      showWarnToast(e.message);
    } on HiNetError catch (e) {
      print(e);
      showWarnToast(e.message);
    }
  }

  _buildHead() {
    if (_profileMo == null) return Container();

    return Container(
      alignment: Alignment.bottomLeft,
      padding: EdgeInsets.only(bottom: 30, left: 10),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(23),
            child: cachedImage(_profileMo.face, width: 46, height: 46),
          ),
          hiSpace(width: 8),
          Text(
            _profileMo.name,
            style: TextStyle(fontSize: 11, color: Colors.grey),
          )
        ],
      ),
    );
  }
}
