import 'package:injectable/injectable.dart';

import '../../../security/manager/security_manager.dart';
import '../../domain/repository/database_repository.dart';
import '../data_source/database_data_source.dart';

@LazySingleton(as: DatabaseRepository)
class DatabaseRepositoryImpl implements DatabaseRepository {
  final DataBaseDataSource dataSource;
  final SecurityManager securityManager;

  const DatabaseRepositoryImpl({
    required this.dataSource,
    required this.securityManager,
  });
}
