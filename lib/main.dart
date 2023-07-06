import 'package:academix/academix.dart';
import 'package:academix/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // This will remove the number sign (#) to the url
  setPathUrlStrategy();

  runApp(
    const ProviderScope(
      child: Academix(),
    ),
  );
}
