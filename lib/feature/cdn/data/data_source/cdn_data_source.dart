import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:injectable/injectable.dart';
import 'package:mime/mime.dart';
import 'package:universal_html/html.dart' as universal_html;

import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/utils/extensions.dart';
import '../../../api/manager/api_caller.dart';
import '../../../api/manager/my_client.dart';
import '../../../env/env_manager.dart';
import '../../domain/entity/branch_info.dart';
import '../../domain/entity/key_value.dart';
import '../../domain/entity/province_city.dart';
import '../../domain/entity/upload_raw_result.dart';
import '../model/upload_raw_result_model.dart';

abstract class CDNDataSource {
  /// Request to get key value type of data from cdn using [urn].
  /// Call a [GET] request to the http://.... endpoint.
  ///
  Future<List<KeyValue>> getKeyValueItems(String urn);

  /// Upload file to cdn and return [UploadRawResult].
  /// Call a [POST] request to the http://.... endpoint.
  ///
  Future<UploadRawResult> uploadFile({
    required String token,
    required Uint8List file,
    required String name,
    required UploadFileType type,
  });

  /// Request to get list of branch from cdn.
  /// Call a [GET] request to the http://.... endpoint.
  ///
  Future<List<BranchInfo>> getBranchList();

  /// Request to get list of provinces and cities from cdn.
  /// Call a [GET] request to the http://.... endpoint.
  ///
  Future<List<ProvinceCity>> getListOfProvinces();

  /// Request to get file from cdn.
  /// Call a [GET] request to the http://.... endpoint.
  ///
  Future<void> downloadFile({
    required String token,
    required String urn,
  });
}

@LazySingleton(as: CDNDataSource)
class CDNDataSourceImpl implements CDNDataSource {
  final MyClient client;
  final ApiCaller apiCaller;
  const CDNDataSourceImpl({
    required this.apiCaller,
    required this.client,
  });

  @override
  Future<List<KeyValue>> getKeyValueItems(String urn) async {
    if (urn == CDNRequestType.scfRegistrationActivityArea.toValue) {
      await Future.delayed(const Duration(milliseconds: 100));
      return const [
        KeyValue(id: '1', title: 'دارویی'),
        KeyValue(id: '2', title: 'صنعت'),
        KeyValue(id: '3', title: 'خودروسازی'),
      ];
    }
    throw const ServerException(
      message: 'Mock info has not Implemented yet!!!!',
    );
  }

  @override
  Future<UploadRawResult> uploadFile({
    required String token,
    required Uint8List file,
    required String name,
    required UploadFileType type,
  }) async {
    return apiCaller.uploadFile(
      converter: (body, headers) => UploadRawResultModel.fromJson(body),
      request: () {
        final request = http.MultipartRequest(
          'POST',
          EnvManager.getUri(path: type.toValue),
        );
        final bytes = file;
        final mimeType = MediaType.parse(lookupMimeType(name) ?? 'image/png');
        request.files.add(
          http.MultipartFile.fromBytes(
            'file',
            bytes,
            filename: name,
            contentType: mimeType,
          ),
        );
        request.headers.addAll({
          'Authorization': 'Bearer $token',
        });
        return request;
      },
    );
  }

  @override
  Future<List<BranchInfo>> getBranchList() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return const [
      BranchInfo(
        id: '1',
        title: 'ناهید غربی',
        lat: 35.778227,
        lng: 51.418700,
      ),
      BranchInfo(
        id: '2',
        title: 'صبا',
        lat: 35.771445,
        lng: 51.421553,
      ),
      BranchInfo(
        id: '3',
        title: 'بخارست',
        lat: 35.730896,
        lng: 51.417418,
      ),
    ];
  }

  @override
  Future<List<ProvinceCity>> getListOfProvinces() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return const [
      ProvinceCity(
        id: '1',
        title: 'تهران',
        cities: [
          ProvinceCity(id: '4', title: 'تهران', cities: []),
          ProvinceCity(id: '5', title: 'اسلامشهر', cities: []),
        ],
      ),
      ProvinceCity(
        id: '2',
        title: 'مازندران',
        cities: [
          ProvinceCity(id: '6', title: 'بابل', cities: []),
          ProvinceCity(id: '7', title: 'آمل', cities: []),
        ],
      ),
      ProvinceCity(
        id: '3',
        title: 'گیلان',
        cities: [
          ProvinceCity(id: '8', title: 'رشت', cities: []),
          ProvinceCity(id: '9', title: 'آستانه', cities: []),
        ],
      ),
    ];
  }

  @override
  Future<void> downloadFile({
    required String token,
    required String urn,
  }) async {
    final result = await apiCaller.callApi(
      isFile: true,
      converter: (body, headers) {
        debugPrint(body?.toString());
        final disposition = headers['content-disposition'] ?? '';
        final fileName =
            disposition.substring(disposition.lastIndexOf('filename=') + 9);
        return (file: body, fileName: fileName);
      },
      request: () => client.get(
        EnvManager.getUri(
          path: 'scf-backoffice/download/document/$urn',
          query: {
            'asAttachment': 'true',
          },
        ),
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
    if (!kIsWeb) return;
    final mimeType = lookupMimeType(result.fileName);
    final base64data = base64Encode(result.file);
    final a = universal_html.AnchorElement(
      href: mimeType == null
          ? 'base64,$base64data'
          : 'data:$mimeType;base64,$base64data',
    );
    debugPrint('name: ${result.fileName}');
    a.download = result.fileName;
    a.click();
    a.remove();
  }
}
