import 'package:flutter/services.dart';

List<TextInputFormatter> get numberFormater {
  return <TextInputFormatter>[
    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
  ];
}
