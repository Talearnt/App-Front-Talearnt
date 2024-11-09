import 'package:flutter/material.dart';
import 'package:app_front_talearnt/common/theme.dart';

class PrimaryXs extends StatelessWidget {
  final String content;
  final VoidCallback? onPressed;
  const PrimaryXs({
    super.key,
    required this.content,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Palette.primary01,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
        elevation: 0,
      ),
      onPressed: onPressed ?? () {},
      child: Text(
        content,
        style: TextTypes.bodyMedium02(
          color: Palette.bgBackGround,
        ),
      ),
    );
  }
}

class PrimaryS extends StatelessWidget {
  final String type, content;
  final VoidCallback? onPressed;
  const PrimaryS({
    super.key,
    required this.type,
    required this.content,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final Map<String, Map<String, Color>> typeStyles = {
      "default": {
        "backgroundColor": Palette.primary01,
        "textColor": Palette.bgBackGround,
      },
      "hover": {
        "backgroundColor": Palette.primaryBG02,
        "textColor": Palette.bgBackGround,
      },
      "disabled": {
        "backgroundColor": Palette.bgUp02,
        "textColor": Palette.text04,
      },
    };

    final backgroundColor =
        typeStyles[type]?["backgroundColor"] ?? Palette.bgBackGround;
    final textColor = typeStyles[type]?["textColor"] ?? Palette.text01;

    return ElevatedButton(
      onPressed: () {
        if (type != "disabled") {
          onPressed ?? () {};
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      ),
      child: Text(
        content,
        style: TextTypes.bodyMedium01(color: textColor),
      ),
    );
  }
}

class PrimaryM extends StatelessWidget {
  final String type, content;
  final VoidCallback? onPressed;
  const PrimaryM({
    super.key,
    required this.type,
    required this.content,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final Map<String, Map<String, Color>> typeStyles = {
      "default": {
        "backgroundColor": Palette.primary01,
        "textColor": Palette.bgBackGround,
      },
      "hover": {
        "backgroundColor": Palette.primaryBG02,
        "textColor": Palette.bgBackGround,
      },
      "disabled": {
        "backgroundColor": Palette.bgUp02,
        "textColor": Palette.text04,
      },
    };

    final backgroundColor =
        typeStyles[type]?["backgroundColor"] ?? Palette.bgBackGround;
    final textColor = typeStyles[type]?["textColor"] ?? Palette.text01;

    return ElevatedButton(
      onPressed: () {
        if (type != "disabled") {
          onPressed ?? () {};
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 13.5, horizontal: 16),
      ),
      child: Text(
        content,
        style: TextTypes.bodyMedium01(color: textColor),
      ),
    );
  }
}

class SecondarySGray extends StatelessWidget {
  final String type, content;
  final VoidCallback? onPressed;
  const SecondarySGray({
    super.key,
    required this.type,
    required this.content,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final Map<String, Map<String, Color>> typeStyles = {
      "default": {
        "borderColor": Palette.icon02,
        "textColor": Palette.text02,
      },
      "hover": {
        "borderColor": Palette.icon02,
        "textColor": Palette.text02,
      },
      "disabled": {
        "borderColor": Palette.icon02,
        "textColor": Palette.text04,
      },
    };

    final borderColor =
        typeStyles[type]?["borderColor"] ?? Palette.bgBackGround;
    final textColor = typeStyles[type]?["textColor"] ?? Palette.text01;

    return ElevatedButton(
      onPressed: () {
        if (type != "disabled") {
          onPressed ?? () {};
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Palette.bgBackGround,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        side: BorderSide(
          color: borderColor,
          width: 1,
        ),
      ),
      child: Text(
        content,
        style: TextTypes.bodyMedium01(color: textColor),
      ),
    );
  }
}

class SecondaryMGray extends StatelessWidget {
  final String type, content;
  final VoidCallback? onPressed;
  const SecondaryMGray({
    super.key,
    required this.type,
    required this.content,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final Map<String, Map<String, Color>> typeStyles = {
      "default": {
        "borderColor": Palette.icon02,
        "textColor": Palette.text02,
      },
      "hover": {
        "borderColor": Palette.icon02,
        "textColor": Palette.text02,
      },
      "disabled": {
        "borderColor": Palette.icon02,
        "textColor": Palette.text04,
      },
    };

    final borderColor =
        typeStyles[type]?["borderColor"] ?? Palette.bgBackGround;
    final textColor = typeStyles[type]?["textColor"] ?? Palette.text01;

    return ElevatedButton(
      onPressed: () {
        if (type != "disabled") {
          onPressed ?? () {};
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Palette.bgBackGround,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 13.5, horizontal: 16),
        side: BorderSide(
          color: borderColor,
          width: 1,
        ),
      ),
      child: Text(
        content,
        style: TextTypes.bodyMedium01(color: textColor),
      ),
    );
  }
}

class SecondarySBlue extends StatelessWidget {
  final String type, content;
  final VoidCallback? onPressed;
  const SecondarySBlue({
    super.key,
    required this.type,
    required this.content,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final Map<String, Map<String, Color>> typeStyles = {
      "default": {
        "borderColor": Palette.primary01,
        "textColor": Palette.primary01,
      },
      "hover": {
        "borderColor": Palette.primary01,
        "textColor": Palette.primary01,
      },
      "disabled": {
        "borderColor": Palette.icon02,
        "textColor": Palette.text04,
      },
    };

    final borderColor =
        typeStyles[type]?["borderColor"] ?? Palette.bgBackGround;
    final textColor = typeStyles[type]?["textColor"] ?? Palette.text01;

    return ElevatedButton(
      onPressed: () {
        if (type != "disabled") {
          onPressed ?? () {};
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Palette.bgBackGround,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        side: BorderSide(
          color: borderColor,
          width: 1,
        ),
      ),
      child: Text(
        content,
        style: TextTypes.bodyMedium01(color: textColor),
      ),
    );
  }
}

class SecondaryMBlue extends StatelessWidget {
  final String type, content;
  final VoidCallback? onPressed;
  const SecondaryMBlue({
    super.key,
    required this.type,
    required this.content,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final Map<String, Map<String, Color>> typeStyles = {
      "default": {
        "borderColor": Palette.primary01,
        "textColor": Palette.primary01,
      },
      "hover": {
        "borderColor": Palette.primary01,
        "textColor": Palette.primary01,
      },
      "disabled": {
        "borderColor": Palette.icon02,
        "textColor": Palette.text04,
      },
    };

    final borderColor =
        typeStyles[type]?["borderColor"] ?? Palette.bgBackGround;
    final textColor = typeStyles[type]?["textColor"] ?? Palette.text01;

    return ElevatedButton(
      onPressed: () {
        if (type != "disabled") {
          onPressed ?? () {};
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Palette.bgBackGround,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 13.5, horizontal: 16),
        side: BorderSide(
          color: borderColor,
          width: 1,
        ),
      ),
      child: Text(
        content,
        style: TextTypes.bodyMedium01(color: textColor),
      ),
    );
  }
}

class TertiaryS extends StatelessWidget {
  final String type, content;
  final VoidCallback? onPressed;
  const TertiaryS({
    super.key,
    required this.type,
    required this.content,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final Map<String, Map<String, Color>> typeStyles = {
      "default": {
        "borderColor": Palette.icon02,
        "textColor": Palette.text02,
      },
      "hover": {
        "borderColor": Palette.icon02,
        "textColor": Palette.text02,
      },
      "disabled": {
        "borderColor": Palette.icon02,
        "textColor": Palette.text04,
      },
    };

    final borderColor =
        typeStyles[type]?["borderColor"] ?? Palette.bgBackGround;
    final textColor = typeStyles[type]?["textColor"] ?? Palette.text01;

    return ElevatedButton(
      onPressed: () {
        if (type != "disabled") {
          onPressed ?? () {};
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Palette.bgBackGround,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(999),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        side: BorderSide(
          color: borderColor,
          width: 1,
        ),
      ),
      child: Text(
        content,
        style: TextTypes.bodyMedium01(color: textColor),
      ),
    );
  }
}

class TertiaryM extends StatelessWidget {
  final String type, content;
  final VoidCallback? onPressed;
  const TertiaryM({
    super.key,
    required this.type,
    required this.content,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final Map<String, Map<String, Color>> typeStyles = {
      "default": {
        "borderColor": Palette.icon02,
        "textColor": Palette.text02,
      },
      "hover": {
        "borderColor": Palette.icon02,
        "textColor": Palette.text02,
      },
      "disabled": {
        "borderColor": Palette.icon02,
        "textColor": Palette.text04,
      },
    };

    final borderColor =
        typeStyles[type]?["borderColor"] ?? Palette.bgBackGround;
    final textColor = typeStyles[type]?["textColor"] ?? Palette.text01;

    return ElevatedButton(
      onPressed: () {
        if (type != "disabled") {
          onPressed ?? () {};
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Palette.bgBackGround,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(999),
        ),
        padding: const EdgeInsets.symmetric(vertical: 13.5, horizontal: 16),
        side: BorderSide(
          color: borderColor,
          width: 1,
        ),
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

  const TextBtnS({
    super.key,
    required this.content,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed ?? () {},
      style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(
        horizontal: 3,
      )),
      child: Text(
        content,
        style: TextTypes.caption01(
          color: Palette.text02,
        ),
      ),
    );
  }
}

class TextBtnM extends StatelessWidget {
  final String content;
  final VoidCallback? onPressed;
  const TextBtnM({
    super.key,
    required this.content,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed ?? () {},
      style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 4,
      )),
      child: Text(
        content,
        style: TextTypes.bodyMedium01(
          color: Palette.text02,
        ),
      ),
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
      child: Text(
        content,
        style: TextTypes.caption02(
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
  final IconData icon;
  final VoidCallback? onPressed;
  const TextWithIcon({
    super.key,
    required this.content,
    required this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed ?? () {},
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 20,
            color: Palette.icon01,
          ),
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
