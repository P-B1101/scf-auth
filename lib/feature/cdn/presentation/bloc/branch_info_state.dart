part of 'branch_info_bloc.dart';

sealed class BranchInfoState extends Equatable {
final List<BranchInfo> items;

  const BranchInfoState({
    this.items = const [],
  });

  @override
  List<Object?> get props => [items];
}

final class BranchInfoInitial extends BranchInfoState {}

final class BranchInfoLoadingState extends BranchInfoState {
  const BranchInfoLoadingState({
    required super.items,
  });
}

final class BranchInfoSuccessState extends BranchInfoState {
  const BranchInfoSuccessState({
    required super.items,
  });
}

final class BranchInfoFailureState extends BranchInfoState {
  final String? message;
  const BranchInfoFailureState({
    this.message,
    required super.items,
  });

  @override
  List<Object?> get props => [items, message];
}
