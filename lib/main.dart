import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_theme/json_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeStr = await rootBundle.loadString('assets/theme.json');
  final themeJson = json.decode(themeStr);

  final theme = ThemeDecoder.decodeThemeData(
        themeJson,
        validate: true,
      ) ??
      ThemeData();

  runApp(MyApp(theme: theme));
}

class MyApp extends StatelessWidget {
  final ThemeData theme;

  MyApp({required this.theme});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: theme,
        home: Scaffold(
          appBar: AppBar(
            title: const Text('MomentAufnahme Dresden'),
          ),
        ));
  }

  test() {
    print('test');
  }
}
