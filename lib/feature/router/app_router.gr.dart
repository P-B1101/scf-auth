// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:flutter/material.dart' as _i10;
import 'package:scf_auth/feature/landing/presentation/page/landing_page.dart'
    as _i4;
import 'package:scf_auth/feature/registration/presentation/page/registration_page.dart'
    as _i6;
import 'package:scf_auth/feature/registration/presentation/widget/company_introduction/company_introduction_widget.dart'
    as _i1;
import 'package:scf_auth/feature/registration/presentation/widget/contact_info/contact_info_widget.dart'
    as _i2;
import 'package:scf_auth/feature/registration/presentation/widget/documents_upload/documents_upload_widget.dart'
    as _i3;
import 'package:scf_auth/feature/registration/presentation/widget/management_introduction/management_introduction_widget.dart'
    as _i5;
import 'package:scf_auth/feature/registration/presentation/widget/suggested_branch/suggested_branch_widget.dart'
    as _i7;
import 'package:scf_auth/feature/registration/presentation/widget/suggested_company/suggested_company_widget.dart'
    as _i8;

abstract class $AppRouter extends _i9.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i9.PageFactory> pagesMap = {
    CompanyIntroductionRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.CompanyIntroductionWidget(),
      );
    },
    ContactInfoRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.ContactInfoWidget(),
      );
    },
    DocumentsUploadRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.DocumentsUploadWidget(),
      );
    },
    LandingRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.LandingPage(),
      );
    },
    ManagementIntroductionRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.ManagementIntroductionWidget(),
      );
    },
    RegistrationRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<RegistrationRouteArgs>(
          orElse: () => RegistrationRouteArgs(
              phoneNumber: pathParams.optString('phoneNumber')));
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.RegistrationPage(
          key: args.key,
          phoneNumber: args.phoneNumber,
        ),
      );
    },
    SuggestedBranchRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.SuggestedBranchWidget(),
      );
    },
    SuggestedCompanyRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.SuggestedCompanyWidget(),
      );
    },
  };
}

/// generated route for
/// [_i1.CompanyIntroductionWidget]
class CompanyIntroductionRoute extends _i9.PageRouteInfo<void> {
  const CompanyIntroductionRoute({List<_i9.PageRouteInfo>? children})
      : super(
          CompanyIntroductionRoute.name,
          initialChildren: children,
        );

  static const String name = 'CompanyIntroductionRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i2.ContactInfoWidget]
class ContactInfoRoute extends _i9.PageRouteInfo<void> {
  const ContactInfoRoute({List<_i9.PageRouteInfo>? children})
      : super(
          ContactInfoRoute.name,
          initialChildren: children,
        );

  static const String name = 'ContactInfoRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i3.DocumentsUploadWidget]
class DocumentsUploadRoute extends _i9.PageRouteInfo<void> {
  const DocumentsUploadRoute({List<_i9.PageRouteInfo>? children})
      : super(
          DocumentsUploadRoute.name,
          initialChildren: children,
        );

  static const String name = 'DocumentsUploadRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i4.LandingPage]
class LandingRoute extends _i9.PageRouteInfo<void> {
  const LandingRoute({List<_i9.PageRouteInfo>? children})
      : super(
          LandingRoute.name,
          initialChildren: children,
        );

  static const String name = 'LandingRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i5.ManagementIntroductionWidget]
class ManagementIntroductionRoute extends _i9.PageRouteInfo<void> {
  const ManagementIntroductionRoute({List<_i9.PageRouteInfo>? children})
      : super(
          ManagementIntroductionRoute.name,
          initialChildren: children,
        );

  static const String name = 'ManagementIntroductionRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i6.RegistrationPage]
class RegistrationRoute extends _i9.PageRouteInfo<RegistrationRouteArgs> {
  RegistrationRoute({
    _i10.Key? key,
    String? phoneNumber,
    List<_i9.PageRouteInfo>? children,
  }) : super(
          RegistrationRoute.name,
          args: RegistrationRouteArgs(
            key: key,
            phoneNumber: phoneNumber,
          ),
          rawPathParams: {'phoneNumber': phoneNumber},
          initialChildren: children,
        );

  static const String name = 'RegistrationRoute';

  static const _i9.PageInfo<RegistrationRouteArgs> page =
      _i9.PageInfo<RegistrationRouteArgs>(name);
}

class RegistrationRouteArgs {
  const RegistrationRouteArgs({
    this.key,
    this.phoneNumber,
  });

  final _i10.Key? key;

  final String? phoneNumber;

  @override
  String toString() {
    return 'RegistrationRouteArgs{key: $key, phoneNumber: $phoneNumber}';
  }
}

/// generated route for
/// [_i7.SuggestedBranchWidget]
class SuggestedBranchRoute extends _i9.PageRouteInfo<void> {
  const SuggestedBranchRoute({List<_i9.PageRouteInfo>? children})
      : super(
          SuggestedBranchRoute.name,
          initialChildren: children,
        );

  static const String name = 'SuggestedBranchRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i8.SuggestedCompanyWidget]
class SuggestedCompanyRoute extends _i9.PageRouteInfo<void> {
  const SuggestedCompanyRoute({List<_i9.PageRouteInfo>? children})
      : super(
          SuggestedCompanyRoute.name,
          initialChildren: children,
        );

  static const String name = 'SuggestedCompanyRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}
