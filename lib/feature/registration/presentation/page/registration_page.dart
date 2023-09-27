import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scf_auth/feature/registration/presentation/widget/company_introduction/company_introduction_widget.dart';
import 'package:scf_auth/feature/registration/presentation/widget/contact_info/contact_info_widget.dart';
import 'package:scf_auth/feature/registration/presentation/widget/documents_upload/documents_upload_widget.dart';
import 'package:scf_auth/feature/registration/presentation/widget/management_introduction/management_introduction_widget.dart';
import 'package:scf_auth/feature/registration/presentation/widget/suggested_branch/suggested_branch_widget.dart';
import 'package:scf_auth/feature/registration/presentation/widget/suggested_company/suggested_company_widget.dart';

import '../../../../core/utils/enums.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../injectable_container.dart';
import '../../../cdn/presentation/bloc/branch_info_bloc.dart';
import '../../../cdn/presentation/bloc/key_value_item_bloc.dart';
import '../../../cdn/presentation/bloc/province_city_bloc.dart';
import '../../../dialog/manager/dialog_manager.dart';
import '../../../router/app_router.gr.dart';
import '../../../toast/manager/toast_manager.dart';
import '../bloc/sign_up_bloc.dart';
import '../cubit/registration_controller_cubit.dart';
import '../widget/finalize/finalize_info_widget.dart';
import '../widget/registration_step_menu_widget.dart';
import '../widget/registration_toolbar_widget.dart';

@RoutePage()
class RegistrationPage extends StatelessWidget {
  static const path = 'registration';
  final String? phoneNumber;
  const RegistrationPage({
    super.key,
    @PathParam() this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RegistrationControllerCubit>(
          create: (context) => RegistrationControllerCubit(phoneNumber),
        ),
        BlocProvider<ActivityAreaBloc>(
          create: (context) => getIt<ActivityAreaBloc>(),
        ),
        BlocProvider<ActivityTypeBloc>(
          create: (context) => getIt<ActivityTypeBloc>(),
        ),
        BlocProvider<BranchInfoBloc>(
          create: (context) => getIt<BranchInfoBloc>(),
        ),
        BlocProvider<ProvinceCityBloc>(
          create: (context) => getIt<ProvinceCityBloc>(),
        ),
        BlocProvider<SignUpBloc>(
          create: (context) => getIt<SignUpBloc>(),
        ),
      ],
      child: _RegistrationPage(phoneNumber: phoneNumber),
    );
  }
}

class _RegistrationPage extends StatefulWidget {
  final String? phoneNumber;
  const _RegistrationPage({
    Key? key,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  State<_RegistrationPage> createState() => __RegistrationPageState();
}

class __RegistrationPageState extends State<_RegistrationPage> {
  @override
  void initState() {
    super.initState();
    _handleInitialState();
  }

  @override
  Widget build(BuildContext context) {
    if (invalidPhoneNumber) return const SizedBox();
    return MultiBlocListener(
      listeners: [
        BlocListener<BranchInfoBloc, BranchInfoState>(
          listener: (context, state) => _handleBranchInfoState(state),
        ),
        BlocListener<ActivityAreaBloc, KeyValueItemState>(
          listener: (context, state) => _handleKeyValueItemState(state),
        ),
        BlocListener<ActivityTypeBloc, KeyValueItemState>(
          listener: (context, state) => _handleKeyValueItemState(state),
        ),
        BlocListener<ProvinceCityBloc, ProvinceCityState>(
          listener: (context, state) => _handleProvinceCityState(state),
        ),
        BlocListener<SignUpBloc, SignUpState>(
          listener: (context, state) => _handleSignUpState(state),
        ),
      ],
      child: AutoTabsRouter(
        routes: [
          CompanyIntroductionRoute(),
          ManagementIntroductionRoute(),
          DocumentsUploadRoute(),
          SuggestedCompanyRoute(),
          ContactInfoRoute(),
          SuggestedBranchRoute(),
          FinalizeInfoRoute(),
        ],
        transitionBuilder: (context, child, animation) => FadeTransition(
          opacity: animation,
          child: child,
        ),
        builder: (context, child) {
          final tabsRouter = AutoTabsRouter.of(context);
          //Todo: Fixing menu bar later
          return Scaffold(
            body: Column(
              children: [
                const RegistrationToolbarWidget(),
                RegistrationStepMenuWidget(
                  onStepClick: (step) {
                    tabsRouter.setActiveIndex(step.index);
                    _onStepClick(step);
                  },
                ),
                Expanded(child: child),
              ],
            ),
          );
        },
      ),
    );
  }

  void _onStepClick(RegistrationSteps step, [bool updateUrl = true]) {
    final String route;
    switch (step) {
      case RegistrationSteps.companyIntroduction:
        route = CompanyIntroductionWidget.path;
        break;
      case RegistrationSteps.managementIntroduction:
        route = ManagementIntroductionWidget.path;
        break;
      case RegistrationSteps.documentsUpload:
        route = DocumentsUploadWidget.path;
        break;
      case RegistrationSteps.suggestedCompany:
        route = SuggestedCompanyWidget.path;
        break;
      case RegistrationSteps.contactInfo:
        route = ContactInfoWidget.path;
        break;
      case RegistrationSteps.suggestedBranch:
        route = SuggestedBranchWidget.path;
        break;
      case RegistrationSteps.finalize:
        route = FinalizeInfoWidget.path;
        break;
    }
    if (updateUrl) {
      context.router.navigateNamed(route);
    }
    context.read<RegistrationControllerCubit>().onPageClick(step);
  }

  void _handleInitialState() async {
    if (invalidPhoneNumber) {
      context.replaceRoute(const LandingRoute());
      return;
    }
    if (!mounted) return;
    _handleInitialTab();
    context.read<ActivityAreaBloc>().add(const GetKeyValueItemEvent(
          requestType: CDNRequestType.scfRegistrationActivityArea,
        ));
    context.read<ActivityTypeBloc>().add(const GetKeyValueItemEvent(
          requestType: CDNRequestType.scfRegistrationActivityType,
        ));
    context.read<BranchInfoBloc>().add(GetBranchInfoEvent());
    context.read<ProvinceCityBloc>().add(GetProvinceCityEvent());
  }

  void _handleInitialTab() {
    final uri = Uri.base;
    final path = uri.pathSegments.lastOrNull;
    final tab = path?.pathToRegistrationStep;
    if (tab != null) _onStepClick(tab, false);
  }

  void _handleBranchInfoState(BranchInfoState state) {
    if (state is BranchInfoFailureState) {
      getIt<ToastManager>()
          .showFailureToast(context: context, message: state.message);
    }
  }

  void _handleKeyValueItemState(KeyValueItemState state) {
    if (state is KeyValueItemFailureState) {
      getIt<ToastManager>()
          .showFailureToast(context: context, message: state.message);
    }
  }

  void _handleProvinceCityState(ProvinceCityState state) {
    if (state is ProvinceCityFailureState) {
      getIt<ToastManager>()
          .showFailureToast(context: context, message: state.message);
    }
  }

  void _handleSignUpState(SignUpState state) async {
    if (state is SignUpFailureState) {
      getIt<ToastManager>()
          .showFailureToast(context: context, message: state.message);
    } else if (state is SignUpSuccessState) {
      await DialogManager.instance.showSuccessSubmitDialog(
        context: context,
        trackingId: state.response.trackingId,
      );
      if (!mounted) return;
      context.replaceRoute(const LandingRoute());
    }
  }

  bool get invalidPhoneNumber {
    if (widget.phoneNumber == null) return true;
    if (!widget.phoneNumber!.isValidMobileNumber) return true;
    return false;
  }
}
