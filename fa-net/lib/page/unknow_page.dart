import 'package:flutter/material.dart';

class UnknowPage extends StatefulWidget {
  @override
  _UnknowPageState createState() => _UnknowPageState();
}

class _UnknowPageState extends State<UnknowPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Text('404'),
      ),
    );
  }
}
