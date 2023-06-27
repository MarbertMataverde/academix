import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DesktopView extends ConsumerWidget {
  const DesktopView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Desktop View',
          style: TextStyle(
            fontFamily: 'Sacramento',
            fontSize: 70,
          ),
        ),
      ),
    );
  }
}
