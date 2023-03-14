import 'package:flutter/material.dart';
import 'package:flutter_bili_app/util/color.dart';
import 'package:flutter_bili_app/util/view_util.dart';

class BarrageInput extends StatelessWidget {
  final VoidCallback onTabClose;
  const BarrageInput({Key key, @required this.onTabClose}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController editingcontroller = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Expanded(
              child: GestureDetector(
            onTap: () {
              if (onTabClose != null) onTabClose();
            },
            child: Container(
              color: Colors.blue,
            ),
          )),
          SafeArea(
              child: Container(
            color: Colors.red,
            child: Row(
              children: [
                hiSpace(width: 15),
                _buildInput(editingcontroller, context),
                _buildSendBtn(editingcontroller, context)
              ],
            ),
          ))
        ],
      ),
    );
  }

  void _send(String text, BuildContext context) {
    if (text.isNotEmpty) {
      if (onTabClose != null) onTabClose();
      Navigator.pop(context, text);
    }
  }

  _buildInput(TextEditingController editingController, BuildContext context) {
    return Expanded(
        child: Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
      child: TextField(
        autofocus: true,
        controller: editingController,
        onSubmitted: (value) {
          _send(value, context);
        },
        cursorColor: primary,
        decoration: InputDecoration(
            isDense: true,
            contentPadding:
                EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            border: InputBorder.none,
            hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
            hintText: "发个友善的弹幕见证当下"),
      ),
    ));
  }

  _buildSendBtn(TextEditingController editingController, BuildContext context) {
    return InkWell(
      onTap: () {
        var text = editingController.text?.trim() ?? "";
        _send(text, context);
      },
      child: Container(
        padding: EdgeInsets.all(10),
        child: Icon(Icons.send_rounded, color: Colors.grey),
      ),
    );
  }
}
