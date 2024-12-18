import 'package:app_front_talearnt/common/widget/button.dart';
import 'package:app_front_talearnt/common/widget/top_app_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class MatchWrite2Page extends StatelessWidget {
  const MatchWrite2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(
        onPressed: () {
          context.pop();
        },
        second: const TextBtnM(content: '미리보기'),
        first: const PrimaryS(content: '등록'),
      ),
      body: const Column(
        children: [],
      ),
    );
  }
}
