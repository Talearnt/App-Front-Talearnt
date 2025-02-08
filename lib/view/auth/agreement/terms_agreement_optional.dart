import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/common/widget/bottom_btn.dart';
import 'package:app_front_talearnt/common/widget/top_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TermsAgreementOptional extends StatelessWidget {
  const TermsAgreementOptional({super.key});

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
                      "광고성 정보 수신 동의",
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
                      "· 이메일, 전화번호",
                      style: TextTypes.bodyMedium03(
                        color: Palette.text03,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "광고성 정보의 발송 목적",
                      style: TextTypes.bodySemi03(
                        color: Palette.text02,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "· 이벤트, 할인 정보 등 서비스와 관련된 광고성 정보 제공",
                      style: TextTypes.bodyMedium03(
                        color: Palette.text03,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "광고성 정보 수신 동의 철회",
                      style: TextTypes.bodySemi03(
                        color: Palette.text02,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "이용자는 언제든지 광고성 정보 수신 동의를 철회할 수 있으며, 철회 시 관련 정보 발송이 중단됩니다.",
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
