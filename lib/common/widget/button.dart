import 'package:app_front_talearnt/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PrimaryXs extends StatelessWidget {
  final String content;
  final VoidCallback? onPressed;
  final String type;

  const PrimaryXs({
    super.key,
    required this.content,
    this.onPressed,
    this.type = "A",
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Palette.primary01,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        padding: type == "A"
            ? const EdgeInsets.symmetric(vertical: 5, horizontal: 16)
            : const EdgeInsets.symmetric(vertical: 9, horizontal: 14),
        minimumSize: Size.zero,
      ).copyWith(
        elevation: WidgetStateProperty.resolveWith<double>((states) {
          return 0;
        }),
      ),
      onPressed: onPressed ?? () {},
      child: Text(
        content,
        style: type == "A"
            ? TextTypes.body02(
                color: Palette.bgBackGround,
              )
            : TextTypes.bodySemi03(
                color: Palette.bgBackGround,
              ),
      ),
    );
  }
}

class PrimaryS extends StatelessWidget {
  final String content;
  final VoidCallback? onPressed;
  final bool isEnabled;

  const PrimaryS({
    super.key,
    required this.content,
    this.onPressed,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor =
        isEnabled ? Palette.primary01 : Palette.bgUp02;
    final Color textColor = isEnabled ? Palette.bgBackGround : Palette.text04;

    return ElevatedButton(
      onPressed: () {
        if (isEnabled && onPressed != null) {
          onPressed!();
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8.5, horizontal: 16),
        minimumSize: Size.zero,
      ).copyWith(
        overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (isEnabled && states.contains(WidgetState.pressed)) {
            return Palette.primaryBG02;
          }
          return Colors.transparent;
        }),
        elevation: WidgetStateProperty.resolveWith<double>((states) {
          return 0;
        }),
      ),
      child: Text(
        content,
        style: TextTypes.bodyMedium01(color: textColor),
      ),
    );
  }
}

class PrimaryM extends StatelessWidget {
  final String content;
  final VoidCallback? onPressed;
  final bool isEnabled;

  const PrimaryM({
    super.key,
    required this.content,
    this.onPressed,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor =
        isEnabled ? Palette.primary01 : Palette.bgUp02;
    final Color textColor = isEnabled ? Palette.bgBackGround : Palette.text04;

    return ElevatedButton(
      onPressed: () {
        if (isEnabled && onPressed != null) {
          onPressed!();
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 13.5, horizontal: 16),
      ).copyWith(
        overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (isEnabled && states.contains(WidgetState.pressed)) {
            return Palette.primaryBG02;
          }
          return Colors.transparent;
        }),
        elevation: WidgetStateProperty.resolveWith<double>((states) {
          return 0;
        }),
      ),
      child: Text(
        content,
        style: TextTypes.bodyMedium01(color: textColor),
      ),
    );
  }
}

class SecondarySGray extends StatelessWidget {
  final String content;
  final VoidCallback? onPressed;
  final bool isEnabled;

  const SecondarySGray({
    super.key,
    required this.content,
    this.onPressed,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final Color borderColor = isEnabled ? Palette.icon02 : Palette.icon02;
    final Color textColor = isEnabled ? Palette.text02 : Palette.text04;

    return ElevatedButton(
      onPressed: () {
        if (isEnabled && onPressed != null) {
          onPressed!();
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Palette.bgBackGround,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8.5, horizontal: 16),
        minimumSize: Size.zero,
        side: BorderSide(
          color: borderColor,
          width: 1,
        ),
      ).copyWith(
        overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (isEnabled && states.contains(WidgetState.pressed)) {
            return Palette.bgBackGround;
          }
          return Colors.transparent;
        }),
        elevation: WidgetStateProperty.resolveWith<double>((states) {
          return 0;
        }),
      ),
      child: Text(
        content,
        style: TextTypes.bodyMedium01(color: textColor),
      ),
    );
  }
}

class SecondaryMGray extends StatelessWidget {
  final String content;
  final VoidCallback? onPressed;
  final bool isEnabled;

  const SecondaryMGray({
    super.key,
    required this.content,
    this.onPressed,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final Color borderColor = isEnabled ? Palette.icon02 : Palette.icon02;
    final Color textColor = isEnabled ? Palette.text02 : Palette.text04;

    return ElevatedButton(
      onPressed: () {
        if (isEnabled && onPressed != null) {
          onPressed!();
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Palette.bgBackGround,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 13.5, horizontal: 16),
        side: BorderSide(
          color: borderColor,
          width: 1,
        ),
      ).copyWith(
        overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (isEnabled && states.contains(WidgetState.pressed)) {
            return Palette.bgBackGround;
          }
          return Colors.transparent;
        }),
        elevation: WidgetStateProperty.resolveWith<double>((states) {
          return 0;
        }),
      ),
      child: Text(
        content,
        style: TextTypes.bodyMedium01(color: textColor),
      ),
    );
  }
}

class SecondarySBlue extends StatelessWidget {
  final String content;
  final VoidCallback? onPressed;
  final bool isEnabled;

  const SecondarySBlue({
    super.key,
    required this.content,
    this.onPressed,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final Color borderColor = isEnabled ? Palette.primary01 : Palette.icon02;
    final Color textColor = isEnabled ? Palette.primary01 : Palette.text04;

    return ElevatedButton(
      onPressed: () {
        if (isEnabled && onPressed != null) {
          onPressed!();
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Palette.bgBackGround,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8.5, horizontal: 16),
        minimumSize: Size.zero,
        side: BorderSide(
          color: borderColor,
          width: 1,
        ),
      ).copyWith(
        overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (isEnabled && states.contains(WidgetState.pressed)) {
            return Palette.bgBackGround;
          }
          return Colors.transparent;
        }),
        elevation: WidgetStateProperty.resolveWith<double>((states) {
          return 0;
        }),
      ),
      child: Text(
        content,
        style: TextTypes.bodyMedium01(color: textColor),
      ),
    );
  }
}

class SecondaryMBlue extends StatelessWidget {
  final String content;
  final VoidCallback? onPressed;
  final bool isEnabled;

  const SecondaryMBlue({
    super.key,
    required this.content,
    this.onPressed,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final Color borderColor = isEnabled ? Palette.primary01 : Palette.icon02;
    final Color textColor = isEnabled ? Palette.primary01 : Palette.text04;

    return ElevatedButton(
      onPressed: () {
        if (isEnabled && onPressed != null) {
          onPressed!();
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Palette.bgBackGround,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 13.5, horizontal: 16),
        side: BorderSide(
          color: borderColor,
          width: 1,
        ),
      ).copyWith(
        overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (isEnabled && states.contains(WidgetState.pressed)) {
            return Palette.bgBackGround;
          }
          return Colors.transparent;
        }),
        elevation: WidgetStateProperty.resolveWith<double>((states) {
          return 0;
        }),
      ),
      child: Text(
        content,
        style: TextTypes.bodyMedium01(color: textColor),
      ),
    );
  }
}

class TertiaryS extends StatelessWidget {
  final String content;
  final VoidCallback? onPressed;
  final bool isEnabled;

  const TertiaryS({
    super.key,
    required this.content,
    this.onPressed,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final Color borderColor = isEnabled ? Palette.icon02 : Palette.icon02;
    final Color textColor = isEnabled ? Palette.text02 : Palette.text04;

    return ElevatedButton(
      onPressed: () {
        if (isEnabled && onPressed != null) {
          onPressed!();
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Palette.bgBackGround,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(999),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8.5, horizontal: 16),
        minimumSize: Size.zero,
        side: BorderSide(
          color: borderColor,
          width: 1,
        ),
      ).copyWith(
        overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (isEnabled && states.contains(WidgetState.pressed)) {
            return Palette.bgBackGround;
          }
          return Colors.transparent;
        }),
        elevation: WidgetStateProperty.resolveWith<double>((states) {
          return 0;
        }),
      ),
      child: Text(
        content,
        style: TextTypes.bodyMedium01(color: textColor),
      ),
    );
  }
}

class TertiaryM extends StatelessWidget {
  final String content;
  final VoidCallback? onPressed;
  final bool isEnabled;

  const TertiaryM({
    super.key,
    required this.content,
    this.onPressed,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final Color borderColor = isEnabled ? Palette.icon02 : Palette.icon02;
    final Color textColor = isEnabled ? Palette.text02 : Palette.text04;

    return ElevatedButton(
      onPressed: () {
        if (isEnabled && onPressed != null) {
          onPressed!();
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Palette.bgBackGround,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(999),
        ),
        padding: const EdgeInsets.symmetric(vertical: 13.5, horizontal: 16),
        side: BorderSide(
          color: borderColor,
          width: 1,
        ),
      ).copyWith(
        overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (isEnabled && states.contains(WidgetState.pressed)) {
            return Palette.bgBackGround;
          }
          return Colors.transparent;
        }),
        elevation: WidgetStateProperty.resolveWith<double>((states) {
          return 0;
        }),
      ),
      child: Text(
        content,
        style: TextTypes.bodyMedium01(color: textColor),
      ),
    );
  }
}

class TextBtnXs extends StatelessWidget {
  final String content;
  final VoidCallback? onPressed;

  const TextBtnXs({
    super.key,
    required this.content,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed ?? () {},
      child: Text(
        content,
        style: TextTypes.caption01(
          color: Palette.text03,
        ),
      ),
    );
  }
}

class TextBtnS extends StatelessWidget {
  final String content;
  final VoidCallback? onPressed;
  final TextStyle? btnStyle;

  TextBtnS({
    super.key,
    required this.content,
    this.onPressed,
    TextStyle? btnStyle,
  }) : btnStyle = btnStyle ?? TextTypes.caption01(color: Palette.text02);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed ?? () {},
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        minimumSize: Size.zero,
      ),
      child:  Text(content, style: btnStyle),
    );
  }
}

class TextBtnM extends StatelessWidget {
  final String content;
  final VoidCallback? onPressed;
  final TextStyle? btnStyle;

  TextBtnM({
    super.key,
    required this.content,
    this.onPressed,
    TextStyle? btnStyle,
  }) : btnStyle = btnStyle ?? TextTypes.bodyMedium01(color: Palette.text02);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed ?? () {},
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 4,
        ),
        minimumSize: Size.zero,
      ),
      child: Text(content, style: btnStyle),
    );
  }
}

class TextLineXs extends StatelessWidget {
  final String content;
  final VoidCallback? onPressed;

  const TextLineXs({
    super.key,
    required this.content,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed ?? () {},
      style: ButtonStyle(
        overlayColor: WidgetStateProperty.all(Colors.transparent),
      ),
      child: Text(
        content,
        style: TextTypes.captionSemi02(
          color: Palette.text03,
        ).copyWith(
          decoration: TextDecoration.underline,
          decorationColor: Palette.text03,
          decorationThickness: 1,
        ),
      ),
    );
  }
}

class TextLineS extends StatelessWidget {
  final String content;
  final VoidCallback? onPressed;

  const TextLineS({
    super.key,
    required this.content,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed ?? () {},
      style: ButtonStyle(
        overlayColor: WidgetStateProperty.all(Colors.transparent),
      ),
      child: Text(
        content,
        style: TextTypes.caption01(
          color: Palette.text03,
        ).copyWith(
          decoration: TextDecoration.underline,
          decorationColor: Palette.text03,
          decorationThickness: 1,
        ),
      ),
    );
  }
}

class TextWithIcon extends StatelessWidget {
  final String content;
  final SvgPicture svgPicture;
  final Function()? onPressed;

  const TextWithIcon({
    super.key,
    required this.content,
    required this.svgPicture,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed ?? () {},
      style: ButtonStyle(
        padding: WidgetStateProperty.all(EdgeInsets.zero), // 패딩 제거
        overlayColor: WidgetStateProperty.all(Colors.transparent),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          svgPicture,
          const SizedBox(width: 3),
          Text(content,
              style: TextTypes.caption01(
                color: Palette.text02,
              )),
          const SizedBox(width: 3),
        ],
      ),
    );
  }
}
