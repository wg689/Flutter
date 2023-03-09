// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bili_app/model/home_mo.dart';

class ProfileMo {
  String name;
  String face;
  int fans;
  int favorite;
  int like;
  int coin;
  int browsing;
  List<BannerMo> bannerList;
  List<Course> courseList;
  List<Benefit> benefitList;

  ProfileMo(
      {this.name,
      this.face,
      this.fans,
      this.favorite,
      this.like,
      this.coin,
      this.browsing,
      this.bannerList,
      this.courseList});

  ProfileMo.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    face = json['face'];
    fans = json['favorite'];
    like = json['like'];
    coin = json['coin'];
    browsing = json["browsing"];

    if (json['bannerList'] != null) {
      bannerList = new List<BannerMo>.empty(growable: true);
      json['bannerList'].forEach((v) {
        bannerList.add(new BannerMo.fromJson(v));
      });
    }

    if (json['courseList'] != null) {
      courseList = new List<Course>();
      json['courseList'].forEach((v) {
        courseList.add(new Course.fromJson(v));
      });
    }

    if (json['benefitList'] != null) {
      benefitList = new List<Benefit>.empty(growable: true);
      json['benefitList'].forEach((v) {
        benefitList.add(new Benefit.fromJson(v));
      });
    }
  }
}

class Course {
  String name;
  String cover;
  String url;
  int group;
  Course({this.name, this.cover, this.url, this.group});

  Course.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    cover = json['cover'];
    url = json['url'];
    group = json['group'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['cover'] = this.cover;
    data['url'] = this.group;
    return data;
  }
}

class Benefit {
  String name;
  String url;
  Benefit({this.name, this.url});

  Benefit.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
  }
}
