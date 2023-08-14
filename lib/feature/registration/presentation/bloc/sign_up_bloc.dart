import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:scf_auth/feature/registration/domain/entity/address_info.dart';
import '../../../../core/error/failures.dart';
import '../../../cdn/domain/entity/branch_info.dart';
import '../../../cdn/domain/entity/key_value.dart';
import '../../../cdn/domain/entity/province_city.dart';
import '../../../cdn/domain/entity/upload_file_result.dart';
import '../../domain/entity/director.dart';
import '../../domain/entity/sign_up_request_body.dart';
import '../../domain/entity/sign_up_response.dart';
import '../../domain/entity/suggested_company.dart';
import '../../domain/use_case/sign_up.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

@injectable
class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUp _signUp;
  SignUpBloc(this._signUp) : super(SignUpInitial()) {
    on<SubmitSignUpEvent>(_onSubmitSignUpEvent, transformer: droppable());
  }

  Future<void> _onSubmitSignUpEvent(
    SubmitSignUpEvent event,
    Emitter<SignUpState> emit,
  ) async {
    emit(SignUpLoadingState());
    final body = SignUpRequestBody(
      address: event.address,
      documents: [
        event.statute,
        event.newspaper,
        event.balanceSheet,
        event.profitAndLossStatement,
        ...event.otherDocuments,
      ],
      economicNationalId: event.economicId,
      email: event.email,
      enterpriseFullName: event.companyTitle,
      industries: event.activityArea,
      mobile: event.mobileNumber,
      partners: event.suggestedComapnies,
      people: [
        event.ceoInfo,
        ...event.boardMemberInfo,
      ],
      serviceType: event.activityType,
      suggestedBranch: event.selectedBranch,
      telephone: event.phoneNumber,
      webSite: event.website,
    );
    final result = await _signUp(Params(body: body));
    final newState = await result.fold(
      (failure) async => failure.toState,
      (response) async => SignUpSuccessState(response),
    );
    emit(newState);
  }
}

extension FailureToState on Failure {
  SignUpState get toState {
    switch (runtimeType) {
      case ServerFailure:
        return SignUpFailureState(
          (this as ServerFailure).message,
        );
    }
    return const SignUpFailureState();
  }
}
