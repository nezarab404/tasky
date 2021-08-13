import 'package:flutter/material.dart';
import 'package:tasky/utilities/globals.dart';
import 'package:tasky/models/radio_model.dart';

class RadioItem extends StatelessWidget {
  final RadioModel _item;
  RadioItem(this._item);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: _item.isSelected ? mainColor : mainColorLight,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          _item.text,
          style: TextStyle(
            fontSize: 15,
            color: _item.isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}

class RadioColorItem extends StatelessWidget {
  final RadioModel _item;
  RadioColorItem(this._item);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Container(
        width: 35,
        height: 35,
        // padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          //   
          gradient: LinearGradient(
            colors: [_item.color, Colors.white],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: _item.isSelected ? Colors.black : Colors.transparent,
              width: 4),
        ),
      ),
    );
  }
}
