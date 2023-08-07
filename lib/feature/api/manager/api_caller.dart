import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/errors.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/utils/typedef.dart';

abstract class ApiCaller {
  Future<T> callApi<T>({
    required ConvertToModel<T> converter,
    required Request request,
  });
}

@LazySingleton(as: ApiCaller)
class ApiCallerImpl implements ApiCaller {
  @override
  Future<T> callApi<T>({
    required ConvertToModel<T> converter,
    required Request request,
  }) async {
    final result = await request();
    String logString = result.request?.url.toString() ?? 'null';
    logString = '$logString\nStatusCode: ${result.statusCode.toString()}';
    if (result.statusCode >= 200 && result.statusCode < 300) {
      logString =
          '$logString\n${result.body.isEmpty ? 'empty body' : result.body}';
      debugPrint(
        '--------------------- Start ---------------------\n'
        '$logString\n'
        '--------------------- End ---------------------',
      );
      dynamic decodedBody;
      try {
        decodedBody = json.decode(result.body);
      } on FormatException {
        decodedBody = result.body;
      }
      final decodedResult = result.body.isEmpty ? null : decodedBody;
      final bodyResult = converter(decodedResult);
      return bodyResult;
    }
    logString = '$logString \n ${result.body}';
    debugPrint(
      '--------------------- Start ---------------------\n'
      '$logString\n'
      '--------------------- End ---------------------',
    );
    if (result.statusCode == 401) throw const UnAuthorizeException();
    final errorMessage = handleError(result.body);
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
