//theme 예시 이후에 변경 할
import 'package:flutter/material.dart';

class AppTheme {
  // static ThemeData lightTheme = ThemeData(
  //   primaryColor: Colors.blue,
  //   brightness: Brightness.light,
  //   appBarTheme: const AppBarTheme(
  //     color: Colors.blue,
  //     iconTheme: IconThemeData(color: Colors.white),
  //     titleTextStyle:TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
  //     ),
  //   textTheme: const TextTheme(),
  //   buttonTheme: const ButtonThemeData()
  //   );
}

class TextTypes {
  static TextStyle heading2({Color color = Palette.textStrong}) {
    return TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      height: 1.3,
      color: color,
    );
  }

  static TextStyle heading4({Color color = Palette.textStrong}) {
    return TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      height: 1.3,
      color: color,
    );
  }

  static TextStyle bodySemi01({Color color = Palette.textStrong}) {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      height: 1.3,
      color: color,
    );
  }

  static TextStyle bodyMedium01({Color color = Palette.textStrong}) {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      height: 1.3,
      color: color,
    );
  }

  static TextStyle body02({Color color = Palette.textStrong}) {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 1.5,
      color: color,
    );
  }

  static TextStyle bodyMedium03({Color color = Palette.textStrong}) {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 1.3,
      color: color,
    );
  }

  static TextStyle bodySemi03({Color color = Palette.textStrong}) {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      height: 1.3,
      color: color,
    );
  }

  static TextStyle caption01({Color color = Palette.textStrong}) {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 1.3,
      color: color,
    );
  }

  static TextStyle captionMedium02({Color color = Palette.textStrong}) {
    return TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      height: 1.3,
      color: color,
    );
  }

  static TextStyle captionSemi02({Color color = Palette.textStrong}) {
    return TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      height: 1.3,
      color: color,
    );
  }

  static TextStyle label01({Color color = Palette.textStrong}) {
    return TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w500,
      height: 1.3,
      color: color,
    );
  }
}

class Palette {
  static const Color bgBackGround = Color(0xFFFFFFFF);
  static Color bgToast01 = const Color(0xFF000000).withOpacity(0.7);
  static Color bgToast02 = const Color(0xFF000000).withOpacity(0.8);
  static const Color onToast = Color(0xFFFFFFFF);
  static const Color primary01 = Color(0xFF1B76FF);
  static const Color primaryBG01 = Color(0xFFE5F0FF);
  static const Color primaryBG02 = Color(0xFF4D94FF);
  static const Color primaryBG04 = Color(0xFFF0F6FF);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color error01 = Color(0xFFFF2727);
  static const Color error02 = Color(0xFFF50000);
  static const Color error03 = Color(0xFFFF5C5C);
  static const Color errorBG01 = Color(0xFFFFF0F0);
  static const Color textStrong = Color(0xFF000000);
  static const Color text01 = Color(0xFF1E2224);
  static const Color text02 = Color(0xFF414A4E);
  static const Color text03 = Color(0xFF98A3A9);
  static const Color text04 = Color(0xFFA6B0B5);
  static const Color icon01 = Color(0xFF414A4E);
  static const Color icon02 = Color(0xFFA6B0B5);
  static const Color icon03 = Color(0xFFC1C8CC);
  static const Color icon04 = Color(0xFFDEE1E3);
  static const Color line01 = Color(0xFFD0D5D8);
  static const Color line02 = Color(0xFFECEEEF);
  static const Color bgUp01 = Color(0xFFF7F8F8);
  static const Color bgUp02 = Color(0xFFECEEEF);
  static const Color bgUp03 = Color(0xFFDEE1E3);
}
