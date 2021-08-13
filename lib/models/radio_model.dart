import 'package:flutter/material.dart';

class RadioModel {
  bool isSelected;
  String text;
  int number;
  Color color;
  RadioModel(this.isSelected, this.text);
  RadioModel.whithNumber(this.isSelected, this.text, this.number);
  RadioModel.withColor(this.isSelected,this.color);
}
