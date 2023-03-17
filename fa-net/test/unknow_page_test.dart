import 'package:flutter/material.dart';
import 'package:flutter_bili_app/page/unknow_page.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('测试page', (WidgetTester widgetTester) async {
    var app = MaterialApp(
      home: UnknowPage(),
    );
    // await WidgetTester.pumpWidget(app);
    expect((find.text('404')), findsOneWidget);
  });
}
