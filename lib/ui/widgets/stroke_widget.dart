import 'package:flutter/material.dart';

class StrokeWidget extends StatelessWidget {

  final String text;
  Color color;
  FontWeight fontWeight;
  double fontSize;
  final double strokeWidth;
  final double strokeRadius;

  StrokeWidget(this.text,{this.color,this.fontWeight,
    this.fontSize,this.strokeWidth = 1.0,this.strokeRadius = 5.0,});

  @override
  Widget build(BuildContext context) {
    this.color = this.color??Theme.of(context).primaryColor;
    this.fontWeight = this.fontWeight??FontWeight.w400;
    this.fontSize = this.fontSize??10.0;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(strokeRadius),
        border: Border.all(color: color,width: strokeWidth),
      ),
      padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 0.0),
      child: Text(text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight
        ),
      ),
    );
  }
}
