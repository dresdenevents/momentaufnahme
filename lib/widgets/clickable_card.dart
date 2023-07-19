import 'package:flutter/material.dart';

Widget clickableCard(
    {required String title,
    required void Function() onTapAction,
    String? subtitle,
    String? description,
    Icon? icon,
    String? image,
    String? descriptionCTA,
    String? backgroundImage}) {
  const minWidth = 300.0;
  const minHeight = 200.0;
  const maxHeight = 400.0;

  return Container(
    constraints: const BoxConstraints(
      minWidth: minWidth,
      minHeight: minHeight,
      maxHeight: maxHeight,
    ),
    child: MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
          onTap: onTapAction,
          child: HoverTextCard(
            title: title,
            subtitle: subtitle,
            hoverText: description,
            image: image,
            descriptionCTA: descriptionCTA,
            onTabAction: onTapAction,
            backgroundImage: backgroundImage,
          )),
    ),
  );
}

Widget getNormalCard(String? image, Icon? icon, String title, String? subtitle,
    String? backgroundImage, Color defaultColor) {
  return Card(
      child: Stack(children: [
    if (backgroundImage != null)
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(backgroundImage),
              // oder NetworkImage für ein Bild aus dem Internet
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    if (backgroundImage != null)
      ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(color: Colors.black.withOpacity(0.7))),
    Column(
      mainAxisAlignment:
          image != null ? MainAxisAlignment.start : MainAxisAlignment.center,
      children: [
        if (image != null) getImage(image),
        getText(title, subtitle, defaultColor, backgroundImage != null)
      ],
    ),
  ]));
}

Widget getText(String title, String? subtitle, Color? defaultColor, backgroundImageSet) {
  return Container(
      constraints: const BoxConstraints(
        minHeight: 100,
      ),
      child: ListTile(
        title: Text(title,
            style: TextStyle(
                color: backgroundImageSet
                    ? Colors.white
                    : defaultColor)),
        subtitle: Text(subtitle ?? '',
            style: TextStyle(
                color: backgroundImageSet
                    ? Colors.white
                    : defaultColor)),
      )
  );
}

Widget getHoverCard(String? image, Icon? icon, String? hoverText,
    String? descriptionCTA, onTabAction) {
  return Card(
    color: Colors.blueAccent.withOpacity(0.9),
    child: Column(
      mainAxisAlignment:
          image != null ? MainAxisAlignment.start : MainAxisAlignment.center,
      children: [
        if (image != null) getImage(image),
        if (hoverText != null || descriptionCTA != null)
          getDescription(hoverText!, descriptionCTA, onTabAction, image != null)
        //todo use title if description is null
      ],
    ),
  );
}

Widget getImage(String image) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: SizedBox(
      height: 250,
      width: double.infinity,
      child: Image.asset(image, fit: BoxFit.cover),
    ),
  );
}

Widget getDescription(
    String description, String? descriptionCTA, onTabAction, bool hasImage) {
  return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        color: Colors.blueAccent.withOpacity(0.9),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    description,
                    maxLines: hasImage ? 3 : 9,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white),
                  ),
                  if (descriptionCTA != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                        onPressed: onTabAction,
                        child: Text(descriptionCTA),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ));
}

class HoverTextCard extends StatefulWidget {
  final String title;
  final String? subtitle;
  final String? hoverText;
  final String? image;
  final String? descriptionCTA;
  final Icon? icon;
  final Function onTabAction;
  final String? backgroundImage;

  HoverTextCard(
      {required this.title,
      this.subtitle,
      this.hoverText,
      this.image,
      this.descriptionCTA,
      this.icon,
      required this.onTabAction,
      this.backgroundImage});

  @override
  _HoverTextCardState createState() => _HoverTextCardState();
}

class _HoverTextCardState extends State<HoverTextCard> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final defaultColor = Theme.of(context).textTheme.bodyText2!.color;

    return MouseRegion(
        onHover: (_) => setState(() => _isHovering = true),
        onExit: (_) => setState(() => _isHovering = false),
        child: _isHovering
            ? getHoverCard(widget.image, widget.icon, widget.hoverText,
                widget.descriptionCTA, widget.onTabAction)
            : getNormalCard(widget.image, widget.icon, widget.title,
                widget.subtitle, widget.backgroundImage, defaultColor!));
  }
}
