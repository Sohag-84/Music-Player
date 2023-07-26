import 'package:flutter/material.dart';
import 'colors.dart';

ourStyle({fontWeight = FontWeight.normal,double size = 14,color = whiteColor}){
  return TextStyle(
    fontSize: size,
    color: color,
    fontWeight: fontWeight,
  );
}