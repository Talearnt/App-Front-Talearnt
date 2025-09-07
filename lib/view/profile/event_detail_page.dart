import 'package:app_front_talearnt/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../common/widget/top_app_bar.dart';
import '../../provider/profile/profile_provider.dart';

class EventDetailPage extends StatelessWidget {
  const EventDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (!didPop) {
          if (context.mounted) {
            context.pop();
          }
        }
      },
      child: Scaffold(
        backgroundColor: Palette.bgBackGround,
        appBar: const TopAppBar(
          content: '이벤트',
          leftIcon: true,
        ),
        body: Image.network(
          profileProvider.eventDetail.bannerUrl,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => const SizedBox(
            child: Center(child: Icon(Icons.broken_image)),
          ),
        ),
      ),
    );
  }
}
