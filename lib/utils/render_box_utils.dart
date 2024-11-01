import 'package:flutter/material.dart';

class RenderBoxUtils {
  // Method to get position and size of a widget
  static Map<String, dynamic> getRenderBoxInfo(BuildContext context) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Offset position = box.localToGlobal(Offset.zero);
    final Size size = box.size;

    return {
      'position': position,
      'size': size,
    };
  }
}
