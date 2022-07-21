import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MTD {
  static jumpScreen(context, VoidCallback) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => VoidCallback));
  }
}
