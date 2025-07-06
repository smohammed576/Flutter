import 'package:flutter/material.dart';

class AppColors {
  static const Map<String, Color> appColors = {
    'green': Color(0xFF01a01d),
    'purple': Color(0xFF8647c9),
    'blue': Color(0xFF324aa8),
    'red': Color(0xFFdb4d4d),
    'orange': Color(0xFFcf641d),
    'pink': Color(0xFFa64790),
    'pretty': Color(0xFF226599),
    'black': Color.fromARGB(255, 0, 0, 0),
  };
}

class LightColors {
  static const Map<String, Color> lightColors = {
    'green': Color(0xFFe2f0e1),
    'purple': Color(0xFFd5b8ff),
    'blue': Color.from(alpha: 0.4, red: 0.196, green: 0.29, blue: 0.659),
    'red': Color(0xFFfac3c3),
    'orange': Color(0xFFf5be9a),
    'pink': Color(0xFFffbdf0),
    'pretty': Color(0xFFbfdcf2),
    'black': Color.fromARGB(74, 0, 0, 0),
  };
}

class BlendColors {
  static const Map<String, Color> blendColors = {
    'green': Color(0xFFe2f0e1),
    'purple': Color.from(alpha: 0.8, red: 0.525, green: 0.278, blue: 0.788),
    'blue': Color.from(alpha: 0.8, red: 0.196, green: 0.29, blue: 0.659),
    'red': Color.from(alpha: 0.8, red: 0.859, green: 0.302, blue: 0.302),
    'orange': Color.from(alpha: 0.8, red: 0.961, green: 0.745, blue: 0.604),
    'pink': Color.from(alpha: 0.8, red: 0.651, green: 0.278, blue: 0.565),
    'pretty': Color.from(alpha: 0.8, red: 0.133, green: 0.396, blue: 0.6),
    'black': Color.from(alpha: 0.8, red: 0, green: 0, blue: 0),
  };
}
