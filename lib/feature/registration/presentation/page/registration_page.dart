import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scf_auth/feature/cdn/presentation/bloc/branch_info_bloc.dart';
import 'package:scf_auth/feature/cdn/presentation/bloc/province_city_bloc.dart';
import 'package:scf_auth/feature/toast/manager/toast_manager.dart';

import '../../../../core/utils/enums.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../injectable_container.dart';
import '../../../cdn/presentation/bloc/key_value_item_bloc.dart';
import '../../../router/app_router.gr.dart';
import '../cubit/registration_controller_cubit.dart';
import '../widget/registration_step_menu_widget.dart';
import '../widget/registration_toolbar_widget.dart';

@RoutePage()
class RegistrationPage extends StatelessWidget {
  static const path = 'registration';
  const RegistrationPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RegistrationControllerCubit>(
          create: (context) => getIt<RegistrationControllerCubit>(),
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
      ],
      child: const _RegistrationPage(),
    );
  }
}

class _RegistrationPage extends StatefulWidget {
  const _RegistrationPage({
    Key? key,
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
      ],
      child: AutoTabsRouter(
        routes: const [
          CompanyIntroductionRoute(),
          ManagementIntroductionRoute(),
          DocumentsUploadRoute(),
          SuggestedCompanyRoute(),
          ContactInfoRoute(),
          SuggestedBranchRoute(),
        ],
        transitionBuilder: (context, child, animation) => FadeTransition(
          opacity: animation,
          child: child,
        ),
        builder: (context, child) {
          final tabsRouter = AutoTabsRouter.of(context);
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
    final PageRouteInfo route;
    switch (step) {
      case RegistrationSteps.companyIntroduction:
        route = const CompanyIntroductionRoute();
        break;
      case RegistrationSteps.managementIntroduction:
        route = const ManagementIntroductionRoute();
        break;
      case RegistrationSteps.documentsUpload:
        route = const DocumentsUploadRoute();
        break;
      case RegistrationSteps.suggestedCompany:
        route = const SuggestedCompanyRoute();
        break;
      case RegistrationSteps.contactInfo:
        route = const ContactInfoRoute();
        break;
      case RegistrationSteps.suggestedBranch:
        route = const SuggestedBranchRoute();
        break;
    }
    if (updateUrl) context.replaceRoute(route);
    context.read<RegistrationControllerCubit>().onPageClick(step);
  }

  void _handleInitialState() {
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
}
