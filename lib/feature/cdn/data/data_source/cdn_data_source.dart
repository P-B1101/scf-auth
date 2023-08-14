import 'dart:typed_data';

import 'package:injectable/injectable.dart';
import 'package:scf_auth/feature/cdn/domain/entity/branch_info.dart';
import 'package:scf_auth/feature/cdn/domain/entity/province_city.dart';

import '../../../../core/utils/enums.dart';
import '../../../../core/utils/extensions.dart';
import '../../../api/manager/api_caller.dart';
import '../../../api/manager/my_client.dart';
import '../../domain/entity/key_value.dart';

abstract class CDNDataSource {
  /// Request to get key value type of data from cdn using [urn].
  /// Call a [GET] request to the http://.... endpoint.
  ///
  Future<List<KeyValue>> getKeyValueItems(String urn);

  /// Upload file to cdn and return [urn].
  /// Call a [POST] request to the http://.... endpoint.
  ///
  Future<String> uploadFile(Uint8List file);

  /// Request to get list of branch from cdn.
  /// Call a [GET] request to the http://.... endpoint.
  ///
  Future<List<BranchInfo>> getBranchList();

  /// Request to get list of provinces and cities from cdn.
  /// Call a [GET] request to the http://.... endpoint.
  ///
  Future<List<ProvinceCity>> getListOfProvinces();
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
      await Future.delayed(const Duration(milliseconds: 1500));
      return [
        const KeyValue(id: '1', title: 'دارویی'),
        const KeyValue(id: '2', title: 'صنعت'),
        const KeyValue(id: '3', title: 'خودروسازی'),
      ];
    } else if (urn == CDNRequestType.scfRegistrationActivityType.toValue) {
      await Future.delayed(const Duration(milliseconds: 1000));
      return [
        const KeyValue(id: '4', title: 'تولیدی'),
        const KeyValue(id: '5', title: 'خدماتی'),
      ];
    }
    return [];
  }

  @override
  Future<String> uploadFile(Uint8List file) async {
    await Future.delayed(const Duration(milliseconds: 2500));
    return 'urn-${DateTime.now().millisecondsSinceEpoch}';
  }

  @override
  Future<List<BranchInfo>> getBranchList() async {
    await Future.delayed(const Duration(milliseconds: 2000));
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
    await Future.delayed(const Duration(milliseconds: 1500));
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
}
