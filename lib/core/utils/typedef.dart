import 'package:http/http.dart';

typedef ConvertToModel<T> = T Function(
  dynamic body,
  Map<String, String> headers,
);
typedef Request = Future<Response> Function();
typedef LoadOrFail<T> = Future<T> Function();
typedef MultiPRequest = MultipartRequest Function();
typedef AuthorizedLoadOrFail<T> = Future<T> Function(String token);
