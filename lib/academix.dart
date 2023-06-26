import 'package:academix/configs/layout/responsive_layout.dart';
import 'package:academix/configs/themes/provider/theme_data.dart';
import 'package:academix/configs/themes/provider/theme_provider.dart';
import 'package:academix/features/authentication/view/desktop_view.dart';
import 'package:academix/features/authentication/view/phone_view.dart';
import 'package:academix/features/authentication/view/tablet_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// The main entry point of the Academix application.
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData(ref),
      home: const ResponsiveLayout(
        phone: PhoneView(),
        tablet: TabletView(),
        desktop: DesktopView(),
      ),
    );
  }
}
