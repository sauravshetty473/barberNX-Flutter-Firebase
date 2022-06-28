

import 'package:flutter/material.dart';

class FontSize{
  static const TextStyle title = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 50
  );
  static const TextStyle subtitle = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 30
  );
  static TextStyle text = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 20,
      color: Colors.black.withOpacity(0.55)
  );
}

const EdgeInsets mainPadding = EdgeInsets.symmetric(horizontal: 30);