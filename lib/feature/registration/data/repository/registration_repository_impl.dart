import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:otp_timer/otp_timer.dart';

import '../../../../core/error/failures.dart';
import '../../../cdn/data/data_source/cdn_data_source.dart';
import '../../../cdn/domain/entity/branch_info.dart';
import '../../../database/data/data_source/database_data_source.dart';
import '../../../jwt/manager/jwt_decoder.dart';
import '../../../repository_manager/repository_manager.dart';
import '../../../security/manager/security_manager.dart';
import '../../domain/entity/sign_up_request_body.dart';
import '../../domain/entity/sign_up_response.dart';
import '../../domain/repository/registration_repository.dart';
import '../data_source/registration_data_source.dart';
import '../model/sign_up_request_body_model.dart';
import '../model/token_model.dart';

@LazySingleton(as: RegistrationRepository)
class RegistrationRepositoryImpl implements RegistrationRepository {
  final RegistrationDataSource dataSource;
  final RepositoryHelper repositoryHelper;
  final DataBaseDataSource database;
  final SecurityManager securityManager;
  final MJwtDecoder jwtDecoder;
  final CDNDataSource cdnDataSource;

  const RegistrationRepositoryImpl({
    required this.dataSource,
    required this.repositoryHelper,
    required this.database,
    required this.securityManager,
    required this.jwtDecoder,
    required this.cdnDataSource,
  });
  void _saveTimerDuration(String token) {
    final decodedJson = jwtDecoder.decode(
      token: token,
      converter: (body) => TokenModel.fromJson(body, token),
    );
    OtpUtils.timerDuration = decodedJson.getDuration ?? OtpUtils.timerDuration;
  }

  Future<BranchInfo?> _tryToGetBranch(String? id) async {
    try {
      if (id == null) return null;
      final result = await cdnDataSource.getBranchList();
      final items = result.where((element) => id == element.id);
      if (items.isEmpty) return null;
      return items.first;
    } catch (error) {
      debugPrint(error.toString());
      return null;
    }
  }

  @override
  Future<Either<Failure, SignUpResponse>> signUp(SignUpRequestBody body) =>
      repositoryHelper.tryToAuthLoad(
        (token) => dataSource.signUp(
          body: SignUpRequestBodyModel.fromEntity(body),
          token: token,
        ),
      );

  @override
  Future<Either<Failure, String>> sendOtp(
    String phoneNumber,
    String? refrenceCode,
  ) =>
      repositoryHelper.tryToLoad(() async {
        final result = refrenceCode == null
            ? await dataSource.sendOtp(phoneNumber)
            : await dataSource.sendFollowUpOtp(
                phoneNumber: phoneNumber,
                refrenceCode: refrenceCode,
              );
        _saveTimerDuration(result);
        return result;
      });

  @override
  Future<Either<Failure, void>> validateOtp({
    required String code,
    required String otpToken,
    required bool isFollowUp,
  }) =>
      repositoryHelper.tryToLoad(() async {
        final result = isFollowUp
            ? await dataSource.validateFollowUpOtp(
                otpToken: otpToken,
                code: code,
              )
            : await dataSource.validateOtp(otpToken: otpToken, code: code);
        await database.saveAuth(securityManager.encode(result));
      });

  @override
  Future<Either<Failure, String>> resendOtp(String otpToken, bool isFollowUp) =>
      repositoryHelper.tryToLoad(() async {
        final result = isFollowUp
            ? await dataSource.resendFollowUpOtp(otpToken)
            : await dataSource.resendOtp(otpToken);
        _saveTimerDuration(result);
        return result;
      });

  @override
  Future<Either<Failure, SignUpRequestBody>> getSavedRegistrationInfo() =>
      repositoryHelper.tryToAuthLoad((token) async {
        final result = await dataSource.getSavedRegistrationInfo(token);
        return result.copyWith(
          suggestedBranch: await _tryToGetBranch(result.suggestedBranch?.id),
        );
      });

  @override
  Future<Either<Failure, SignUpResponse>> edit(SignUpRequestBody body) =>
      repositoryHelper.tryToAuthLoad(
        (token) => dataSource.edit(
          body: SignUpRequestBodyModel.fromEntity(body),
          token: token,
        ),
      );
}
