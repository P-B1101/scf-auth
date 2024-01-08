import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../../../core/error/errors.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/utils/typedef.dart';

abstract class ApiCaller {
  Future<T> callApi<T>({
    required ConvertToModel<T> converter,
    required Request request,
    bool isFile = false,
  });

  Future<T> uploadFile<T>({
    required ConvertToModel<T> converter,
    required MultiPRequest request,
  });
}

@LazySingleton(as: ApiCaller)
class ApiCallerImpl implements ApiCaller {
  @override
  Future<T> callApi<T>({
    required ConvertToModel<T> converter,
    required Request request,
    bool isFile = false,
  }) async {
    final result = await request();
    return _handleCall(result, converter, isFile);
  }

  @override
  Future<T> uploadFile<T>({
    required ConvertToModel<T> converter,
    required MultiPRequest request,
  }) async {
    final streamResponse = await request().send();
    final response = await http.Response.fromStream(streamResponse);
    return _handleCall(response, converter);
  }

  Future<T> _handleCall<T>(
    http.Response result,
    ConvertToModel<T> converter, [
    bool isFile = false,
  ]) async {
    String logString = result.request?.url.toString() ?? 'null';
    logString = '$logString\nStatusCode: ${result.statusCode.toString()}';
    final body = isFile ? result.bodyBytes : utf8.decode(result.bodyBytes);
    if (result.statusCode >= 200 && result.statusCode < 300) {
      logString =
          '$logString\n${isFile || body.toString().isEmpty ? 'empty body' : body}';
      debugPrint(
        '--------------------- Start ---------------------\n'
        '$logString\n'
        '--------------------- End ---------------------',
      );
      dynamic decodedBody;
      try {
        decodedBody = isFile ? body : json.decode(body.toString());
      } on FormatException {
        decodedBody = body;
      }
      final decodedResult =
          !isFile && body.toString().isEmpty ? null : decodedBody;
      final bodyResult = converter(decodedResult, result.headers);
      return bodyResult;
    }
    logString = '$logString \n $body';
    debugPrint(
      '--------------------- Start ---------------------\n'
      '$logString\n'
      '--------------------- End ---------------------',
    );
    if (result.statusCode == 401) throw const UnAuthorizeException();
    if (result.statusCode == 403) throw const AccessDeniedException();
    final errorMessage =
        handleError(isFile ? utf8.decode(body as List<int>) : body.toString());
    throw ServerException(message: errorMessage);
  }

  String? handleError(String body) {
    if (body.isEmpty) return null;
    dynamic decodedBody;
    try {
      decodedBody = json.decode(body);
      final item = ErrorModel.fromJson(decodedBody);
      return item.message.isEmpty ? null : item.message;
    } on Exception {
      decodedBody = body;
    }
    return decodedBody?.toString();
  }
}
