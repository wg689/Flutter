import 'dart:async';
import 'package:flutter/material.dart' hide Page;
import 'package:tiziapp/chapter3/button.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'chapter2/2.2/router.dart';
import 'chapter2/getState.dart';
import 'chapter3/form.dart';
import 'chapter3/image_icon.dart';
import 'chapter3/progress.dart';
import 'chapter3/switch_checkbox.dart';
import 'chapter3/text.dart';
import 'chapter3/textfield.dart';
import 'common.dart';
import 'routes.dart';
// import 'chapter14/draw_main.dart' as custom;
import 'package:flukit/flukit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> _generateItem(BuildContext context, List<Page> children) {
    return children.map<Widget>((page) {
      return ListTile(
        title: Text(page.title),
        trailing: const Icon(Icons.keyboard_arrow_right),
        onTap: () => page.openPage(context),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter实战'),
        ),
        body: ListView(
          children: <Widget>[
            ExpansionTile(
              title: const Text('第一个flutter应用'),
              children: _generateItem(context, [
                Page('计数器', const CounterRoute(), withScaffold: false),
                Page('路由传值', const RouterTestRoute(), withScaffold: true),
                Page('Cupertino Demo', const CupertinoTestRoute(),
                    withScaffold: false),
                Page('子树中获取State对象', const GetStateObjectRoute(),
                    withScaffold: false),
                Page('state 的生命周期', const StateLifeCycleTest()),
              ]),
            ),
            ExpansionTile(
              title: const Text('基础组件'),
              children: _generateItem(context, [
                Page('按钮', const ButtonRoute()),
                Page("Form", const FormTestRoute(), showLog: false),
                Page("图片伸缩", const ImageAndIconRoute()),
                Page("复选框", const SwitchAndCheckBoxRoute()),
                Page("进度条", const ProgressRoute()),
                Page("文本框", const TextRoute()),
                Page("文本输入框", const FocusTestRoute()),
              ]),
            )
          ],
        ));
  }
}
