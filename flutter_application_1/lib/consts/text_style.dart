import 'package:flutter/material.dart';
import 'package:flutter_application_1/consts/colors.dart';

const bold = "bold";
const regular = "regular";

ourStyle({family = regular, double? size = 14, color = whiteColor}) {
  return TextStyle(
    fontSize: size,
    color: color,
    fontFamily: family == bold ? "JosefinSans-Bold" : "JosefinSans-Regular",
  );
}