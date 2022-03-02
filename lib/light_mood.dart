import 'package:flutter/material.dart';


class LightMode extends StatefulWidget {
  const LightMode({
    Key key,
    @required this.sub,
    @required this.font,
    @required this.light,
    @required this.night,
  }) : super(key: key);

  final Color sub, font;
  final Function light, night;
  @override
  _LightModeState createState() => _LightModeState();
}

class _LightModeState extends State<LightMode> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 7),
      alignment: Alignment.center,
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: widget.sub, 
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Colors.black.withOpacity(.23)
          )
        ],
      ),
      width: 90,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: widget.light,
            icon: Icon(Icons.wb_sunny_outlined),
            color: widget.font,
            highlightColor: Colors.white.withOpacity(0),
            splashColor: Colors.white.withOpacity(0),
            padding: EdgeInsets.fromLTRB(5, 5, 2, 5),
            tooltip: "Light Mood",
            constraints: BoxConstraints(minHeight: 0, minWidth: 0),
            iconSize: 30,
          ),
          IconButton(
            onPressed: widget.night, 
            icon: Icon(Icons.nightlight_outlined),
            iconSize: 30,
            color: widget.font,
            highlightColor: Colors.white.withOpacity(0),
            splashColor: Colors.white.withOpacity(0),
            padding: EdgeInsets.fromLTRB(2, 5, 5, 5),
            tooltip: "Light Mood",
            constraints: BoxConstraints(minHeight: 0, minWidth: 0),

          ),
        ],
      ),
    );
  }
}

