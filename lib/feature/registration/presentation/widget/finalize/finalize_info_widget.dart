import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scf_auth/core/components/button/m_button.dart';
import 'package:scf_auth/feature/registration/presentation/widget/contact_info/contact_info_widget.dart';
import 'package:scf_auth/feature/registration/presentation/widget/documents_upload/documents_upload_widget.dart';
import 'package:scf_auth/feature/registration/presentation/widget/management_introduction/management_introduction_widget.dart';
import 'package:scf_auth/feature/registration/presentation/widget/suggested_branch/suggested_branch_widget.dart';
import 'package:scf_auth/feature/registration/presentation/widget/suggested_company/suggested_company_widget.dart';

import '../../../../../core/utils/assets.dart';
import '../../../../../core/utils/enums.dart';
import '../../../../../core/utils/ui_utils.dart';
import '../../../../language/manager/localizatios.dart';
import '../../cubit/registration_controller_cubit.dart';
import '../company_introduction/company_introduction_widget.dart';
import 'address_contact_info_widget.dart';
import 'board_members_intro_widget.dart';
import 'company_intro_widget.dart';
import 'files_widget.dart';
import 'suggested_branch_widget.dart';
import 'suggested_comapnies_widget.dart';

@RoutePage()
class FinalizeInfoWidget extends StatefulWidget {
  static const path = 'finalize-info';
  const FinalizeInfoWidget({
    super.key,
    @PathParam.inherit() String? phoneNumber,
  });

  @override
  State<FinalizeInfoWidget> createState() => _FinalizeInfoWidgetState();
}

class _FinalizeInfoWidgetState extends State<FinalizeInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return const _BodyWidget();
  }
}

class _BodyWidget extends StatefulWidget {
  const _BodyWidget({Key? key}) : super(key: key);

  @override
  State<_BodyWidget> createState() => __BodyWidgetState();
}

class __BodyWidgetState extends State<_BodyWidget> {
  // final _

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 48),
                  _title,
                  const SizedBox(height: 67),
                  CompanyIntroWidget(
                    onCompanyIntroEditClick: _onCompanyIntroEditClick,
                  ),
                  const SizedBox(height: 100),
                  BoardMembersIntroWidget(
                    onBoardMembersIntroEditClick: _onBoardMembersIntroEditClick,
                  ),
                  const SizedBox(height: 100),
                  FilesWidget(
                    onFileEditClick: _onFilesEditClick,
                    onSeeDocumentClick: _onSeeDocumentClick,
                  ),
                  const SizedBox(height: 100),
                  SuggestedCompaniesWidget(
                    onSuggestedCompanyEditClick: _onSuggestedCompanyEditClick,
                  ),
                  const SizedBox(height: 100),
                  AddressContactInfoWidget(
                    onAddressContactEditClick: _onAddressContactEditClick,
                    onWatchingLocationClick: _onWatchingLocationClick,
                  ),
                  const SizedBox(height: 100),
                  FinalizeSuggestedBranchWidget(
                      onSuggestedBranchEditClick: _onSuggestedBranchEditClick),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.symmetric(vertical: 16),
          child: MButtonWidget(
            width: UiUtils.maxInputSize,
            onClick: _onFinalSubmitClick,
            title: Strings.of(context).final_review_and_submit,
          ),
        ),
        //Todo: button
      ],
    );
  }

  Widget get _title => Builder(
        builder: (context) => Text.rich(
          style: const TextStyle(
            fontSize: 20,
            fontWeight: Fonts.regular400,
            color: MColors.primaryTextColor,
          ),
          TextSpan(
            children: [
              TextSpan(text: Strings.of(context).register_your_info),
              TextSpan(
                text: ' ${Strings.of(context).complete}',
                style: const TextStyle(color: MColors.primaryColor),
              ),
              TextSpan(
                text: ' ${Strings.of(context).review_info}',
              ),
              TextSpan(
                text: ' ${Strings.of(context).correction}',
                style: const TextStyle(color: MColors.primaryColor),
              ),
              TextSpan(
                text: ' ${Strings.of(context).verb}',
              ),
            ],
          ),
        ),
      );

  void _onCompanyIntroEditClick() {
    context.read<RegistrationControllerCubit>().onPageClick(
          RegistrationSteps.companyIntroduction,
        );
    AutoTabsRouter.of(context)
        .setActiveIndex(RegistrationSteps.companyIntroduction.index);
    context.navigateNamedTo(CompanyIntroductionWidget.path);
  }

  void _onBoardMembersIntroEditClick() {
    context.read<RegistrationControllerCubit>().onPageClick(
          RegistrationSteps.managementIntroduction,
        );
    AutoTabsRouter.of(context)
        .setActiveIndex(RegistrationSteps.managementIntroduction.index);
    context.navigateNamedTo(ManagementIntroductionWidget.path);
  }

  void _onFilesEditClick() {
    context.read<RegistrationControllerCubit>().onPageClick(
          RegistrationSteps.documentsUpload,
        );
    AutoTabsRouter.of(context)
        .setActiveIndex(RegistrationSteps.documentsUpload.index);
    context.navigateNamedTo(DocumentsUploadWidget.path);
  }

  void _onSuggestedCompanyEditClick() {
    context.read<RegistrationControllerCubit>().onPageClick(
          RegistrationSteps.suggestedCompany,
        );
    AutoTabsRouter.of(context)
        .setActiveIndex(RegistrationSteps.suggestedCompany.index);
    context.navigateNamedTo(SuggestedCompanyWidget.path);
  }

  void _onAddressContactEditClick() {
    context.read<RegistrationControllerCubit>().onPageClick(
          RegistrationSteps.contactInfo,
        );
    AutoTabsRouter.of(context)
        .setActiveIndex(RegistrationSteps.contactInfo.index);
    context.navigateNamedTo(ContactInfoWidget.path);
  }

  void _onSuggestedBranchEditClick() {
    context.read<RegistrationControllerCubit>().onPageClick(
          RegistrationSteps.suggestedBranch,
        );
    AutoTabsRouter.of(context)
        .setActiveIndex(RegistrationSteps.suggestedBranch.index);
    context.navigateNamedTo(SuggestedBranchWidget.path);
  }

  void _onWatchingLocationClick() {
    
  }
  
  void _onSeeDocumentClick() {
    //Todo: Complete it later
    //Todo: This function should be able to download the uploaded file
  }
  void _onFinalSubmitClick() {
    //Todo: Complete it later
  }
}
