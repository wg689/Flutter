import 'package:flutter/material.dart';
import 'package:flutter_bili_app/model/profile_mo.dart';
import 'package:flutter_bili_app/util/view_util.dart';

class CourseCard extends StatelessWidget {
  final List<Course> courseList;
  const CourseCard({Key key, this.courseList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, left: 10, right: 5),
      child: Column(
        children: [_buildTitle(), ..._buildCardList(context)],
      ),
    );
  }

  _buildTitle() {
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 10),
      child: Row(
        children: [
          Text("职场进阶",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          hiSpace(width: 10),
          Text('带你突破技术瓶颈',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]))
        ],
      ),
    );
  }

  _buildCardList(BuildContext context) {
    var courseGroup = Map();
    courseList.forEach((mo) {
      if (!courseGroup.containsKey(mo.group)) {
        courseGroup[mo.group] = [];
      }
      List list = courseGroup[mo.group];
      list.add(mo);
    });
    return courseGroup.entries.map((e) {
      List list = e.value;
      var width =
          (MediaQuery.of(context).size.width - 20 - (list.length - 1) * 5) /
              list.length;
      var height = width / 16 * 6;
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [...list.map((mo) => _buildCard(mo, width, height))],
      );
    });
  }

  _buildCard(Course mo, double width, double height) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.only(right: 5, bottom: 7),
        child: cachedImage(mo.cover, width: width, height: height),
      ),
    );
  }
}
