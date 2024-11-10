import 'package:app_front_talearnt/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ObscureTextField extends StatelessWidget {
  final String hint;
  final TextEditingController textEditingController;
  final Function(String) textOnChanged;
  final bool isEnabled;
  final ValueNotifier<bool> obscureNotifier;

  const ObscureTextField(
      {super.key,
      required this.hint,
      required this.textEditingController,
      required this.textOnChanged,
      this.isEnabled = true,
      required this.obscureNotifier});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: obscureNotifier,
        builder: (context, isObscure, child) {
          return TextField(
            obscureText: isObscure,
            controller: textEditingController,
            onChanged: textOnChanged,
            style: TextTypes.bodyMedium02(color: Palette.text02),
            enabled: isEnabled,
            decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(color: Palette.text04),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Palette.line01),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Palette.line01),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Palette.primary01),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Palette.error02),
                ),
                fillColor: isEnabled ? Colors.transparent : Palette.bgUp02,
                contentPadding: const EdgeInsets.fromLTRB(16, 13, 8, 13),
                suffixIcon: _getSuffixIcon(obscureNotifier)),
          );
        });
  }

  Widget? _getSuffixIcon(obscureNotifier) {
    if (textEditingController.text.isNotEmpty) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              obscureNotifier.value = !obscureNotifier.value;
            },
            child: obscureNotifier.value
                ? SvgPicture.asset('assets/icons/eye_close.svg')
                : SvgPicture.asset('assets/icons/eye_open.svg'),
          ),
        ],
      );
    }
    return null; // 텍스트가 비어있으면 아무것도 표시하지 않음
  }
}
