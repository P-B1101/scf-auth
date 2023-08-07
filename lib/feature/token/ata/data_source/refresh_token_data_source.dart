import 'package:injectable/injectable.dart';

import '../../../api/manager/api_caller.dart';
import '../../../api/manager/my_client.dart';

abstract class RefreshTokenDataSource {}

@LazySingleton(as: RefreshTokenDataSource)
class RefreshTokenDataSourceImpl implements RefreshTokenDataSource {
  final MyClient client;
  final ApiCaller apiCaller;

  const RefreshTokenDataSourceImpl({
    required this.client,
    required this.apiCaller,
  });
}
