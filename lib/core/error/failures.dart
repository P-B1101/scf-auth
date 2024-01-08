import 'package:equatable/equatable.dart';
import 'package:scf_auth/core/utils/ui_utils.dart';

import 'exceptions.dart';

abstract class Failure extends Equatable {
  const Failure();
  @override
  List<Object?> get props => [];
}

/// Return [ServerFailure] from Repository to the UseCase
///
/// if [ServerException] thrown in the DataSource.
///
class ServerFailure extends Failure {
  final String? message;
  const ServerFailure({
    this.message,
  });

  @override
  List<Object?> get props => [message];
}

/// Return [NoInternetConnectionFailure] from Repository to the UseCase
///
/// if [NetworkInfo.isConnected] return false.
///

class NoInternetConnectionFailure extends Failure {}

/// Return [AuthenticationFailure] from Repository to the UseCase
///
/// if status code is 401 happend.
///
class AuthenticationFailure extends Failure {}

/// Return [MultiDeviceFailure] from Repository to the UseCase
///
/// if status code is 421 happend.
///
class MultiDeviceFailure extends Failure {}

/// Return [AccessDeniedFailure] from Repository to the UseCase
///
/// if status code is 403 happend.
///
class AccessDeniedFailure extends Failure {}

/// Return [FileSizeFailure] from Repository to the UseCase
///
/// if selected file size exceed from [Utils.maxFileSizeAllowed] byte
///
class FileSizeFailure extends Failure {
  final int size;
  const FileSizeFailure(this.size);

  @override
  List<Object?> get props => [size];
}

/// Return [FileExtensionFailure] from Repository to the UseCase
///
/// if selected file extension are not [zip, pdf, jpeg, png]
///
class FileExtensionFailure extends Failure {
  final String extensions;
  const FileExtensionFailure(this.extensions);

  @override
  List<Object?> get props => [extensions];
}

/// Return [CancelSelectFileFailure] from Repository to the UseCase
///
/// if user cancel selection file flow
///
class CancelSelectFileFailure extends Failure {}
