import 'package:flutter/material.dart';
import 'package:oprnize/constant.dart';

class SectionTitle extends StatelessWidget {
  SectionTitle({@required this.title});

  final title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Container(
        child: Text(
          title,
          style: TextStyle(
              color: KPrimaryColor,
              fontSize: 20.0,
              fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}
