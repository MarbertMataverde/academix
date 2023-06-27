import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhoneView extends ConsumerWidget {
  const PhoneView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Phone View',
          style: TextStyle(
            fontFamily: 'Gilroy',
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}
