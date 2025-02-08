import 'package:app_front_talearnt/common/theme.dart';
import 'package:flutter/material.dart';

enum ChipType { choice, filter, disabled }

class ChipList extends StatefulWidget {
  final List<String> chipLabels;
  final ChipType type;
  final TextStyle? selectedTextStyle;
  final TextStyle? unselectedTextStyle;
  final TextStyle? disabledTextStyle;

  final BoxDecoration? selectedDecoration;
  final BoxDecoration? unselectedDecoration;
  final BoxDecoration? disabledDecoration;
  final BoxDecoration? selectedOnPressDecoration;
  final BoxDecoration? unselectedOnPressDecoration;

  const ChipList({
    Key? key,
    required this.chipLabels,
    required this.type,
    this.selectedTextStyle,
    this.unselectedTextStyle,
    this.disabledTextStyle,
    this.selectedDecoration,
    this.unselectedDecoration,
    this.disabledDecoration,
    this.selectedOnPressDecoration,
    this.unselectedOnPressDecoration,
  }) : super(key: key);

  @override
  State<ChipList> createState() => _CustomChipListState();
}

class _CustomChipListState extends State<ChipList> {
  int _selectedChipIndex = -1; // 선택된 Chip
  final Set<int> _selectedChipIndexes = {}; // Filter 방식에서 선택된 Chip들
  List<bool> _isPressedList = []; // 각 칩에 대한 눌림 상태

  @override
  void initState() {
    super.initState();
    // 초기화: 모든 칩에 대해 눌림 상태를 false로 설정
    _isPressedList = List.generate(widget.chipLabels.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      children: List.generate(widget.chipLabels.length, (index) {
        final isSelected = widget.type == ChipType.choice
            ? _selectedChipIndex == index
            : _selectedChipIndexes.contains(index);
        final isDisabled = widget.type == ChipType.disabled;

        // 눌렀을 때 스타일을 적용
        final decoration = _isPressedList[index]
            ? (isSelected
                ? widget.selectedOnPressDecoration ??
                    BoxDecoration(
                      border: Border.all(
                        color: Palette.primary01,
                        width: 1.0,
                      ),
                      color: Palette.primaryBG01, // 눌렀을 때 선택된 칩 색상
                      borderRadius: BorderRadius.circular(8.0),
                    )
                : widget.unselectedOnPressDecoration ??
                    BoxDecoration(
                      border: Border.all(
                        color: Palette.line01,
                        width: 1.0,
                      ),
                      color: Palette.primaryBG01, // 눌렀을 때 비선택된 칩 색상
                      borderRadius: BorderRadius.circular(8.0),
                    ))
            : (isSelected
                ? widget.selectedDecoration ??
                    BoxDecoration(
                      border: Border.all(
                        color: Palette.primary01,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    )
                : widget.unselectedDecoration ??
                    BoxDecoration(
                      border: Border.all(
                        color: Palette.line01,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ));

        return GestureDetector(
          onTapDown: (_) {
            setState(() {
              _isPressedList[index] = true; // 해당 칩이 눌렸을 때 상태 변경
            });
          },
          onTapUp: (_) {
            setState(() {
              _isPressedList[index] = false; // 칩에서 손을 뗄 때 상태 변경
            });
          },
          onTapCancel: () {
            setState(() {
              _isPressedList[index] = false; // 칩이 눌렸을 때 취소된 경우
            });
          },
          onTap: isDisabled
              ? null
              : () {
                  setState(() {
                    if (widget.type == ChipType.choice) {
                      _selectedChipIndex = index;
                    } else if (widget.type == ChipType.filter) {
                      if (_selectedChipIndexes.contains(index)) {
                        _selectedChipIndexes.remove(index);
                      } else {
                        _selectedChipIndexes.add(index);
                      }
                    }
                  });
                },
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            decoration: isDisabled
                ? widget.disabledDecoration ??
                    BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.grey[400]!),
                    )
                : decoration,
            child: Text(
              widget.chipLabels[index],
              style: isDisabled
                  ? widget.disabledTextStyle ?? TextTypes.body02()
                  : isSelected
                      ? widget.selectedTextStyle ??
                          TextTypes.body02(
                            color: Palette.primary01,
                          )
                      : widget.unselectedTextStyle ??
                          TextTypes.body02(
                            color: Palette.text04,
                          ),
            ),
          ),
        );
      }),
    );
  }
}
