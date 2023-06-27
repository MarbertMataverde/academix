import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabletView extends ConsumerWidget {
  const TabletView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Tablet View',
          style: TextStyle(
            fontFamily: 'Gilroy',
            fontSize: 50,
          ),
        ),
      ),
    );
  }
}
