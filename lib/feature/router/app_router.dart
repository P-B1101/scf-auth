import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../registration/presentation/widget/company_introduction/company_introduction_widget.dart';
import '../registration/presentation/widget/contact_info/contact_info_widget.dart';
import '../registration/presentation/widget/documents_upload/documents_upload_widget.dart';
import '../registration/presentation/widget/finalize/finalize_info_widget.dart';
import '../registration/presentation/widget/management_introduction/management_introduction_widget.dart';
import '../registration/presentation/widget/suggested_company/suggested_company_widget.dart';

import '../registration/presentation/page/registration_page.dart';
import '../registration/presentation/widget/suggested_branch/suggested_branch_widget.dart';
import 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page|Screen|Widget,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/',
          page: LandingRoute.page,
        ),
        RedirectRoute(path: '/${RegistrationPage.path}', redirectTo: '/'),
        AutoRoute(
          path: '/${RegistrationPage.path}/:followup/:phonenumber',
          page: RegistrationRoute.page,
          children: [
            RedirectRoute(path: '', redirectTo: CompanyIntroductionWidget.path),
            AutoRoute(
              path: CompanyIntroductionWidget.path,
              page: CompanyIntroductionRoute.page,
            ),
            AutoRoute(
              path: ManagementIntroductionWidget.path,
              page: ManagementIntroductionRoute.page,
            ),
            AutoRoute(
              path: DocumentsUploadWidget.path,
              page: DocumentsUploadRoute.page,
            ),
            AutoRoute(
              path: SuggestedCompanyWidget.path,
              page: SuggestedCompanyRoute.page,
            ),
            AutoRoute(
              path: ContactInfoWidget.path,
              page: ContactInfoRoute.page,
            ),
            AutoRoute(
              path: SuggestedBranchWidget.path,
              page: SuggestedBranchRoute.page,
            ),
            AutoRoute(
              path: FinalizeInfoWidget.path,
              page: FinalizeInfoRoute.page,
            ),
          ],
        ),
      ];

  @override
  RouteType get defaultRouteType => RouteType.custom(
        durationInMilliseconds: 200,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = 0.0;
          var end = 1.0;
          var tween = Tween<double>(begin: begin, end: end);
          var curvedAnimation = CurvedAnimation(
            parent: animation,
            reverseCurve: Curves.easeIn,
            curve: Curves.easeOut,
          );

          return FadeTransition(
            opacity: tween.animate(curvedAnimation),
            child: child,
          );
        },
      );
}
