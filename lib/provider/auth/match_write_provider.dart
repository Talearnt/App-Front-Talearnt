import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_svg/svg.dart';

import '../clear_text.dart';

class MatchWriteProvider extends ChangeNotifier with ClearText {
  final TextEditingController _titlerController = TextEditingController();
  final FocusNode _titleFocusNode = FocusNode();

  final QuillController _contentController = QuillController.basic();
  final FocusNode _contentFocusNode = FocusNode();

  TextEditingController get titlerController => _titlerController;
  QuillController get contentController => _contentController;

  FocusNode get titleFocusNode => _titleFocusNode;
  FocusNode get contentFocusNode => _contentFocusNode;

  bool _onToolBar = false;

  bool _isBold = false;
  bool _isItalic = false;
  bool _isUnderline = false;

  bool get onToolBar => _onToolBar;

  bool get isBold => _isBold;
  bool get isItalic => _isItalic;
  bool get isUnderline => _isUnderline;

  MatchWriteProvider() {
    _contentController.addListener(notifyListeners);
  }

  void clearProvider() {
    _titlerController.clear();
    _contentController.clear();

    _titleFocusNode.unfocus();
    _contentFocusNode.unfocus();

    notifyListeners();
  }

  @override
  void clearText(TextEditingController controller) {
    controller.clear();
    notifyListeners();
  }

  void toggleButton(type) {
    if (type == "bold") {
      _isBold = !_isBold;
    }
    if (type == "italic") {
      _isItalic = !_isItalic;
    }
    if (type == "underline") {
      _isUnderline = !_isUnderline;
    }
    notifyListeners();
  }

  void setToolbar(bool) {
    _onToolBar = bool;
    notifyListeners();
  }
}
