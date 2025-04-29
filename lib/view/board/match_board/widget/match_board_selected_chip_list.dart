import 'package:flutter/material.dart';

import '../../../../common/theme.dart';

class MatchBoardSelectedChipList extends StatefulWidget {
  final List<String> keywordNames;

  const MatchBoardSelectedChipList({
    Key? key,
    required this.keywordNames,
  }) : super(key: key);

  @override
  _MatchBoardSelectedChipListState createState() =>
      _MatchBoardSelectedChipListState();
}

class _MatchBoardSelectedChipListState
    extends State<MatchBoardSelectedChipList> {
  final ScrollController _scrollController = ScrollController();
  bool _showLeftGradient = false;
  bool _showRightGradient = true;
  bool _isScrollable = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkScrollable();
    });
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    setState(() {
      _showLeftGradient = _scrollController.offset > 0;
      _showRightGradient =
          _scrollController.offset < _scrollController.position.maxScrollExtent;
    });
    _checkScrollable();
  }

  void _checkScrollable() {
    if (!mounted) return;

    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final containerWidth = renderBox.size.width;
    final contentWidth =
        _scrollController.position.maxScrollExtent + containerWidth;

    if (mounted) {
      setState(() {
        _isScrollable = contentWidth > containerWidth;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: widget.keywordNames.map((chip) {
              return Padding(
                padding: const EdgeInsets.only(right: 6.0),
                child: Chip(
                  label: Text(
                    chip,
                    style: TextTypes.bodyMedium03(
                      color: Palette.text02,
                    ),
                  ),
                  backgroundColor: Palette.bgUp02,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                    side: const BorderSide(
                      color: Palette.bgUp02,
                      width: 0,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        if (_showLeftGradient && _isScrollable)
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: 30,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [
                    Colors.white.withOpacity(0),
                    Colors.white,
                  ],
                ),
              ),
            ),
          ),
        if (_showRightGradient && _isScrollable)
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: 30,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.white.withOpacity(0),
                    Colors.white,
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
