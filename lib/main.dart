import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_theme/json_theme.dart';
import 'package:moment_aufnahme_webseite/widgets/clickable_card.dart';

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
        home: Home()
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isScreenSmall = MediaQuery.of(context).size.width < 960;

    return Scaffold(
      appBar: isScreenSmall ? AppBar(title: const Text('MomentAufnahme')) : null,
      drawer: isScreenSmall ? null : Drawer(/* Ihr Drawer-Inhalt hier */),
      body: Center(
        child: clickableCard(
            title: "MomentAufnahme - Technik für deine besonderen Momente",
            subtitle: "Eine breite Palette an technischem Equipment für Veranstaltungen aller Art.",
            onTapAction: () => print('Card wurde angeklickt'),
          description: 'MomentAufnahme, Ihr verlässlicher Technikverleih aus Dresden, bietet eine beeindruckende Auswahl an technischem Equipment für Ihre Veranstaltung. Ob für eine Party, ein Firmenevent oder eine Konferenz, wir haben genau das, was Sie brauchen, um Ihr Event unvergesslich zu machen. Entdecken Sie die Vielfalt unserer Angebote, vom Fotostation-Service über Karaokestationen bis hin zu umfassender Licht- und Soundtechnik.'
        ),
      ),
    );
  }
}