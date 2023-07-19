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
    return MaterialApp(theme: theme, home: Home());
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isScreenSmall = MediaQuery.of(context).size.width < 960;

    return Scaffold(
      appBar:
          isScreenSmall ? AppBar(title: const Text('MomentAufnahme')) : null,
      drawer: isScreenSmall
          ? null
          : Drawer(
              child: Container(
              child: Text("Test"),
            )),
      body: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(children: <Widget>[header(), mainContent()])),
    );
  }

  Widget header() {
    return clickableCard(
        title: "MomentAufnahme - Technik für deine besonderen Momente",
        subtitle:
            "Eine breite Palette an technischem Equipment für Veranstaltungen aller Art.",
        onTapAction: () => print('Card wurde angeklickt'),
        description:
            'MomentAufnahme, Ihr verlässlicher Technikverleih aus Dresden, bietet eine beeindruckende Auswahl an '
            'technischem Equipment für Ihre Veranstaltung. Ob für eine Party, ein Firmenevent oder eine '
            'Konferenz, wir haben genau das, was Sie brauchen, um Ihr Event unvergesslich zu machen. '
            'Entdecken Sie die Vielfalt unserer Angebote, vom Fotostation-Service über Karaokestationen '
            'bis hin zu umfassender Licht- und Soundtechnik.',
        descriptionCTA: 'Mehr erfahren');
  }

  Widget mainContent() {
    return Expanded(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final children = getServiceCards();

          if (constraints.maxWidth < 800) {
            // Use one column for small screens
            return GridView.count(
                crossAxisCount: 1,
                children: children,
            );
          } else if (constraints.maxWidth < 1200) {
            // Use two columns for medium screens
            return GridView.count(
                crossAxisCount: 2,
                children: children
            );
          } else {
            // Use Row layout for large screens
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 150),
              child: Row(
                children: children.map((child) => Expanded(child: child)).toList(),
              ),
            );
          }
        },
      ),
    );
  }


  List<Widget> getServiceCards() {
    return [
      clickableCard(
          title: "Fotostation-Service",
          subtitle: "Fangen Sie unvergessliche Momente ein.",
          onTapAction: () => print('Card wurde angeklickt'),
          description:
              'Unsere Fotostation erstellt individuell gestaltete Bilder, die Sie direkt herunterladen oder auf einem Stick mitnehmen können. Wählen Sie unsere Premiumvariante, um Ihre Fotos sofort ausdrucken zu können. Perfekt für Hochzeiten, Geburtstage und andere besondere Anlässe.',
          descriptionCTA: 'Fotobox mieten',
        image: 'assets/images/fotobox.png'
      ),
      clickableCard(
          title: "Karaokestationen zum Mieten",
          subtitle: "Bringen Sie die Party in Schwung.",
          onTapAction: () => print('Card wurde angeklickt'),
          description:
              'Mit unseren Karaokestationen wird Ihre Party garantiert ein Hit. Leicht zu bedienen und mit einer großen Auswahl an Liedern ausgestattet, bringen sie Schwung in jede Veranstaltung.',
          descriptionCTA: 'Karaokestation mieten'),
      clickableCard(
          title: "Hochwertige Licht- und Soundtechnik",
          subtitle: "Erzeugen Sie die perfekte Atmosphäre für Ihr Event.",
          onTapAction: () => print('Card wurde angeklickt'),
          description:
              'Wir bieten eine Auswahl an technischen Geräten, darunter Lichttechnik, Soundtechnik, Boxen, Verstärker und Mikrofone. Alles, was Sie brauchen, um die richtige Stimmung zu erzeugen und Ihr Publikum zu begeistern.',
          descriptionCTA: 'Technik mieten'),
      clickableCard(
          title: "Zukünftige Dienste: Laserdruckservice",
          subtitle: "Bald verfügbar bei MomentAufnahme.",
          onTapAction: () => print('Card wurde angeklickt'),
          description:
              'Wir planen, einen Laserdruckservice für Holz und Leder vor Ort anzubieten. Bleiben Sie gespannt auf weitere Updates zu diesem aufregenden neuen Service!')
    ];
  }
}
