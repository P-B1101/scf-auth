import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../registration/presentation/page/registration_page.dart';
import 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page|Screen|Widget,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/',
          page: LandingRoute.page,
        ),
        AutoRoute(
          path: '/${RegistrationPage.path}',
          page: RegistrationRoute.page,
          children: [
            RedirectRoute(path: '', redirectTo: 'company-introduction'),
            AutoRoute(
              path: 'company-introduction',
              page: CompanyIntroductionRoute.page,
            ),
            AutoRoute(
              path: 'management-introduction',
              page: ManagementIntroductionRoute.page,
            ),
            AutoRoute(
              path: 'documents-upload',
              page: DocumentsUploadRoute.page,
            ),
            AutoRoute(
              path: 'suggested-company',
              page: SuggestedCompanyRoute.page,
            ),
            AutoRoute(
              path: 'contact-info',
              page: ContactInfoRoute.page,
            ),
            AutoRoute(
              path: 'suggested-branch',
              page: SuggestedBranchRoute.page,
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
