import 'package:academix/academix.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  // This will remove the number sign (#) to the url
  setPathUrlStrategy();
  runApp(
    const ProviderScope(
      child: Academix(),
    ),
  );
}
