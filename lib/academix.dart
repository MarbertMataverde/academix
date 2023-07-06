import 'package:academix/configs/routes/routes_config.dart';
import 'package:academix/configs/themes/provider/theme_data.dart';
import 'package:academix/configs/themes/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The main entry point of the Academix application.
///
/// The `Academix` widget serves as the root widget of the application. It initializes the application's theme and sets up the router for navigation.
class Academix extends ConsumerStatefulWidget {
  const Academix({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AcademixState();
}

class _AcademixState extends ConsumerState<Academix> {
  @override
  void initState() {
    super.initState();
    getUserTheme(ref);
  }

  @override
  Widget build(BuildContext context) {
    // Initialize the application's theme using the theme provider
    final theme = themeData(ref);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: theme,
      // Configure the router for navigation
      routeInformationParser: academixRouter.routeInformationParser,
      routeInformationProvider: academixRouter.routeInformationProvider,
      routerDelegate: academixRouter.routerDelegate,
    );
  }
}
