import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';

import 'feature/router/my_app.dart';
import 'injectable_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  Paint.enableDithering = true;
  await configureDependencies();
  runApp(const MyApp());
}
