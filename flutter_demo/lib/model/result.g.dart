part of 'result.dart';

Result _$ResultFromJson(Map<String, dynamic> json) {
  return Result(
    json['code'] as int,
    json['method'] as String,
    json['requestPrams'] as String,
  );
}

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'code': instance.code,
      'method': instance.method,
      'requstPrams': instance.requestPrams,
    };
