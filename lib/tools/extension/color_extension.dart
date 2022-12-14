import 'package:flutter/material.dart';

extension ColorExtension on Color {
  //线条颜色
  static const Color bgColor = Color.fromRGBO(240, 240, 240, 1);
  static const Color lineColor = Color.fromRGBO(233, 233, 233, 0.5);
  static MaterialColor primarySwatch = mapMaterialColor(Colors.white);

  // String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color hex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  //根据color创建 MaterialColor
  static MaterialColor mapMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
}