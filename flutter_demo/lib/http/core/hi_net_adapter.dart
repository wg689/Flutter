import 'dart:convert';
import 'package:flutter_demo/http/request/base_request.dart';

abstract class HiNetAdapter {
  Future<HiNetResponse> send(BaseRequest request);
}

class HiNetResponse<T> {
  HiNetResponse(
      {this.data,
      this.request,
      this.statusCode,
      this.statusMessage,
      this.extra});

  T? data;

  BaseRequest? request;

  int? statusCode;

  String? statusMessage;

  // ignore: unnecessary_question_mark
  dynamic? extra;

  @override
  String toString() {
    if (data is Map) {
      return json.encode(data);
    }
    return data.toString();
  }
}
