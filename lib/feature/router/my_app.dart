import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:scf_auth/feature/language/manager/localizatios.dart';
import 'package:scf_auth/feature/timer/presentation/widget/timer_widget_wrapper.dart';

import '../../core/components/container/keyboard_dismissable_widget.dart';
import '../../core/utils/assets.dart';
import '../../core/utils/extensions.dart';
import 'app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();
    return MaterialApp.router(
      routerConfig: appRouter.config(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: MColors.primaryColor,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: Fonts.yekan,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: MColors.primaryColor,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        fontFamily: Fonts.yekan,
      ),
      onGenerateTitle: (context) => Strings.of(context).app_name,
      themeMode: ThemeMode.light,
      builder: (context, child) {
        final MediaQueryData data = MediaQuery.of(context);
        final scaleFactor = data.size.width.scaleFactor;
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: Theme.of(context).brightness == Brightness.light
              ? SystemUiOverlayStyle.dark.copyWith(
                  statusBarColor: Colors.transparent,
                )
              : SystemUiOverlayStyle.light.copyWith(
                  statusBarColor: Colors.transparent,
                ),
          child: KeyboardDismissableWidget(
            child: TimerWidgetWrapper(
              child: MediaQuery(
                data: data.copyWith(
                  textScaleFactor: scaleFactor,
                  boldText: false,
                ),
                child: child!,
              ),
            ),
          ),
        );
      },
      locale: const Locale('fa'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      localeResolutionCallback: (locale, supportedLocales) {
        Intl.defaultLocale = 'fa';
        return const Locale('fa');
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
