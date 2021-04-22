import 'package:flutter/material.dart';
import 'package:oprnize/constant.dart';

class CustomCheckbox extends StatelessWidget {
  CustomCheckbox(
      {@required this.label,
      @required this.value,
      @required this.isActive,
      @required this.onTap});
  final label;
  final value;
  final bool isActive;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.only(
        right: 10,
        bottom: 10,
      ),
      // width: 130.0,
      decoration: BoxDecoration(
        color: isActive ? KPrimaryColor : Color(0xFFF3F3F3),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(15),
        ),
      ),
      child: GestureDetector(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.add,
              color: isActive ? Colors.white : Colors.black38,
            ),
            Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.white : Colors.black38,
              ),
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
