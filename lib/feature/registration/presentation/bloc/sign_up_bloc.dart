import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/utils/enums.dart';
import '../../domain/use_case/edit.dart';
import '../../domain/entity/address_info.dart';
import '../../../../core/error/failures.dart';
import '../../../cdn/domain/entity/branch_info.dart';
import '../../../cdn/domain/entity/key_value.dart';
import '../../../cdn/domain/entity/upload_file_result.dart';
import '../../domain/entity/director.dart';
import '../../domain/entity/sign_up_request_body.dart';
import '../../domain/entity/sign_up_response.dart';
import '../../domain/entity/suggested_company.dart';
import '../../domain/use_case/sign_up.dart' as s;

part 'sign_up_event.dart';
part 'sign_up_state.dart';

@injectable
class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final s.SignUp _signUp;
  final Edit _edit;
  SignUpBloc(
    this._signUp,
    this._edit,
  ) : super(SignUpInitial()) {
    on<SubmitSignUpEvent>(_onSubmitSignUpEvent, transformer: droppable());
  }

  Future<void> _onSubmitSignUpEvent(
    SubmitSignUpEvent event,
    Emitter<SignUpState> emit,
  ) async {
    emit(SignUpLoadingState());
    final body = SignUpRequestBody(
      address: event.address,
      uploadedDocuments: [
        event.statute,
        event.newspaper,
        event.balanceSheet,
        event.profitAndLossStatement,
        ...event.otherDocuments,
      ],
      nationalId: event.economicId,
      email: event.email,
      businessUnitFullName: event.companyTitle,
      activityAreas: event.activityArea,
      mobile: event.mobileNumber,
      associatedBusinessUnits: event.suggestedComapnies,
      directors: [
        event.ceoInfo,
        ...event.boardMemberInfo,
      ],
      serviceType: event.activityType,
      suggestedBranch: event.selectedBranch,
      telephone: event.phoneNumber,
      webSite: event.website,
      iban: event.iban,
    );
    final result = event.isEdit
        ? await _edit(Params(body: body))
        : await _signUp(s.Params(body: body));
    final newState = await result.fold(
      (failure) async => failure.toState,
      (response) async => SignUpSuccessState(
        response: response,
        hasIban: event.iban.isNotEmpty,
      ),
    );
    emit(newState);
  }
}

extension FailureToState on Failure {
  SignUpState get toState => switch (this) {
        ServerFailure(message: String? message) => SignUpFailureState(message),
        AuthenticationFailure() => SignUpUnAuthorizeFailureState(),
        _ => const SignUpFailureState(),
      };
}
