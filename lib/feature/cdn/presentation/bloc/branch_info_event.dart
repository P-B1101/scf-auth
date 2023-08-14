part of 'branch_info_bloc.dart';

sealed class BranchInfoEvent extends Equatable {
  const BranchInfoEvent();

  @override
  List<Object> get props => [];
}

final class GetBranchInfoEvent extends BranchInfoEvent {}
