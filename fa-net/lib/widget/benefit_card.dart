import 'package:flutter/material.dart';
import 'package:flutter_bili_app/model/profile_mo.dart';
import 'package:flutter_bili_app/util/view_util.dart';
import 'package:flutter_bili_app/widget/hi_blur.dart';

///增值服务
class BenefitCard extends StatelessWidget {
  final List<Benefit> benefitList;
  const BenefitCard({Key key, this.benefitList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, left: 10, right: 5),
      child: Column(
        children: [_buildTitle(), _buildBenefit(context)],
      ),
    );
  }

  _buildTitle() {
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 10),
      child: Row(
        children: [
          Text("增值服务",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          hiSpace(width: 10),
          Text('购买后登录慕课网再次点击打开查看',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]))
        ],
      ),
    );
  }

  _buildBenefit(BuildContext context) {
    var width = (MediaQuery.of(context).size.width -
            20 -
            (benefitList.length - 1) * 5) /
        benefitList.length;
    return Row(
      children: [
        ...benefitList.map((e) => _buildCard(context, e, width)).toSet()
      ],
    );
  }

  _buildCard(BuildContext context, Benefit mo, double width) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.only(right: 5, bottom: 7),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            alignment: Alignment.center,
            width: width,
            height: 60,
            decoration: BoxDecoration(color: Colors.deepOrangeAccent),
            child: Stack(
              children: [
                Positioned.fill(child: HiBlur()),
                Positioned.fill(
                    child: Center(
                  child: Text(
                    mo.name,
                    style: TextStyle(color: Colors.white54),
                    textAlign: TextAlign.center,
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
