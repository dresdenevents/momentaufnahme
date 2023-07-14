import 'package:flutter/material.dart';

Widget clickableCard({required String title, required void Function() onTapAction, String? subtitle, String? description, Icon? icon, Image? image, }) {
  return MouseRegion(
    cursor: SystemMouseCursors.click,
    child: GestureDetector(
      onTap: onTapAction,
      child: Card(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: icon,
                  title: Text(title),
                  subtitle: subtitle != null ? Text(subtitle) : null,
                ),
              ],
            ),
            if (description != null)
              HoverWidget(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: Colors.black.withOpacity(0.7),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        description,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    ),
  );
}

class HoverWidget extends StatefulWidget {
  final Widget child;

  HoverWidget({required this.child});

  @override
  _HoverWidgetState createState() => _HoverWidgetState();
}

class _HoverWidgetState extends State<HoverWidget> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: AnimatedOpacity(
        opacity: _isHovering ? 1.0 : 0.0,
        duration: Duration(milliseconds: 200),
        child: widget.child,
      ),
    );
  }
}


