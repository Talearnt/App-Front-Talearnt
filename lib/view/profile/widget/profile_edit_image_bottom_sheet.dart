import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../common/theme.dart';
import '../../../provider/profile/profile_provider.dart';

class ProfileImageBottomSheet extends StatelessWidget {
  const ProfileImageBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 44, top: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 50,
              width: double.infinity,
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () {
                  profileProvider
                      .pickImage(ImageSource.gallery, context)
                      .then((_) {
                    if (context.mounted) {
                      context.push('/user-image-preview');
                    }
                  });
                },
                child: Center(
                  child: Text(
                    '갤러리에서 사진 등록',
                    style: TextTypes.bodyMedium01(
                      color: Palette.text01,
                    ),
                  ),
                ),
              ),
            ),
            const Divider(
              color: Palette.line02,
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () {
                  profileProvider
                      .pickImage(ImageSource.camera, context)
                      .then((_) {
                    if (context.mounted) {
                      context.push('/user-image-preview');
                    }
                  });
                },
                child: Center(
                  child: Text(
                    '사진 찍기',
                    style: TextTypes.bodyMedium01(
                      color: Palette.text01,
                    ),
                  ),
                ),
              ),
            ),
            const Divider(
              color: Palette.line02,
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () {
                  context.pop();
                  profileProvider.resetImage();
                },
                child: Center(
                  child: Text(
                    '기본 프로필 설정',
                    style: TextTypes.bodyMedium01(
                      color: Palette.text01,
                    ),
                  ),
                ),
              ),
            ),
            const Divider(
              color: Palette.line02,
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () {
                  context.pop();
                },
                child: Center(
                  child: Text(
                    '취소',
                    style: TextTypes.bodyMedium01(
                      color: Palette.text04,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
