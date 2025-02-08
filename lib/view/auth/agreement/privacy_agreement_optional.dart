import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/common/widget/bottom_btn.dart';
import 'package:app_front_talearnt/common/widget/top_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PrivacyAgreementOptional extends StatelessWidget {
  const PrivacyAgreementOptional({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.bgBackGround,
      appBar: TopAppBar(
        content: "서비스 이용약관",
        onPressed: () {
          context.pop();
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "마케팅 목적의 개인정보 수집 및 이용 동의",
                      style: TextTypes.bodySemi03(
                        color: Palette.text02,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "수집하는 개인정보 항목",
                      style: TextTypes.bodySemi03(
                        color: Palette.text02,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "· 이메일, 전화번호, 관심사",
                      style: TextTypes.bodyMedium03(
                        color: Palette.text03,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "마케팅 활동의 목적",
                      style: TextTypes.bodySemi03(
                        color: Palette.text02,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "· 신규 서비스 및 이벤트 안내\n\n· 맞춤형 광고 및 프로모션 제공",
                      style: TextTypes.bodyMedium03(
                        color: Palette.text03,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "개인정보의 보유 및 이용 기간",
                      style: TextTypes.bodySemi03(
                        color: Palette.text02,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "이용자가 마케팅 수신 동의를 철회할 때까지 보유 및 이용합니다. 이용자는 언제든지 마케팅 정보 수신을 거부할 수 있습니다.",
                      style: TextTypes.bodyMedium03(
                        color: Palette.text03,
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
          BottomBtn(
            mediaBottom: MediaQuery.of(context).viewInsets.bottom,
            content: "확인",
            isEnabled: true,
            onPressed: () {
              context.pop();
            },
          ),
        ],
      ),
    );
  }
}
