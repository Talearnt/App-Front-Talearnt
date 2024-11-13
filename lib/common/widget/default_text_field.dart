import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/common/widget/time_set.dart';
import 'package:app_front_talearnt/provider/clear_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class DefaultTextField extends StatelessWidget {
  final String type;
  final String keyboardType;
  final String hint;
  final TextEditingController textEditingController;
  final ClearText provider;
  final Function(String) onChanged;
  final bool isEnabled;
  final bool isSendAuth;

  const DefaultTextField({
    super.key,
    required this.type,
    this.keyboardType = 'default',
    required this.hint,
    required this.textEditingController,
    required this.provider,
    required this.onChanged,
    this.isEnabled = true,
    this.isSendAuth = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      onChanged: onChanged,
      keyboardType:
          keyboardType == 'num' ? TextInputType.number : TextInputType.text,
      inputFormatters:
          keyboardType == 'num' ? [FilteringTextInputFormatter.digitsOnly] : [],
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
        suffixIcon: _getSuffixIcon(),
      ),
    );
  }

  Widget? _getSuffixIcon() {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      if (textEditingController.text.isNotEmpty)
        SizedBox(
          width: 24,
          height: 24,
          child: GestureDetector(
            onTap: () {
              provider.clearText(textEditingController);
            },
            child: SvgPicture.asset("assets/icons/text_delete.svg"),
          ),
        ),
      if (type == "cert")
        Visibility(
          visible: isSendAuth ? true : false,
          child: const Row(
            children: [TimeSet(), SizedBox(width: 8)],
          ),
        )
    ]);
  }
}
