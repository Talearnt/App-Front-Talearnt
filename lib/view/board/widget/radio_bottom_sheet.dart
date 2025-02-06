import 'package:app_front_talearnt/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RadioBottomSheet extends StatelessWidget {
  final String sheetTitle;
  final List<Map<String, String>> bottomSheetContent;
  final String selectedCode;
  final Function changedFunction;

  const RadioBottomSheet(
      {super.key,
      required this.sheetTitle,
      required this.bottomSheetContent,
      required this.selectedCode,
      required this.changedFunction});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, top: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                sheetTitle,
                style: TextTypes.bodySemi01(color: Palette.text01),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: bottomSheetContent.map((option) {
                      final isSelected = option['code'] == selectedCode;
                      return InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        onTap: () {
                          changedFunction(option['code']!);
                          context.pop();
                        },
                        child: SizedBox(
                          height: 56,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                option['value']!,
                                style: TextTypes.bodySemi02(
                                  color: isSelected
                                      ? Palette.text02
                                      : Palette.text04,
                                ),
                              ),
                              Radio(
                                value: option['code'],
                                groupValue: selectedCode,
                                onChanged: (value) {
                                  changedFunction(value!);
                                  context.pop();
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
