import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/common/widget/bottom_btn.dart';
import 'package:app_front_talearnt/common/widget/top_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PrivacyAgreementRequired extends StatelessWidget {
  const PrivacyAgreementRequired({super.key});

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
                      "개인정보 수집 및 이용 동의",
                      style: TextTypes.bodySemi03(
                        color: Palette.text02,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "1. 수집하는 개인정보 항목",
                      style: TextTypes.bodySemi03(
                        color: Palette.text02,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "회사는 서비스 제공을 위해 다음과 같은 개인정보를 수집합니다:\n\n· 필수 항목: 이메일, 비밀번호, 전화번호, 성별, 관심사, 인증 서류\n\n· 선택 항목: 프로필 사진, 추가적인 관심사 정보",
                      style: TextTypes.bodyMedium03(
                        color: Palette.text03,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "2. 개인정보의 수집 및 이용 목적",
                      style: TextTypes.bodySemi03(
                        color: Palette.text02,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "회사는 다음의 목적을 위해 개인정보를 수집하고 이용합니다:\n\n· 회원 가입 및 관리\n\n· 재능 및 전문성 매칭 서비스 제공\n\n· 사용자 식별 및 인증\n\n· 서비스 관련 공지사항 전달\n\n· 이용자의 요청 및 문의 사항 처리\n\n· 사용자 맞춤형 서비스 제공 및 광고",
                      style: TextTypes.bodyMedium03(
                        color: Palette.text03,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "3. 개인정보의 보유 및 이용 기간",
                      style: TextTypes.bodySemi03(
                        color: Palette.text02,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "회사는 원칙적으로 이용자의 개인정보를 회원 탈퇴 시 즉시 파기합니다. 다만, 다음의 정보는 아래의 이유로 명시한 기간 동안 보관됩니다:\n\n· 관련 법령에 따라 보존이 필요한 경우: 해당 법령에서 정한 기간\n\n· 회원 탈퇴 후 재가입 방지를 위한 정보: 1개월간 보관 후 삭제",
                      style: TextTypes.bodyMedium03(
                        color: Palette.text03,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "4. 개인정보의 제3자 제공",
                      style: TextTypes.bodySemi03(
                        color: Palette.text02,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "회사는 원칙적으로 이용자의 개인정보를 제3자에게 제공하지 않으나, 다음의 경우 예외적으로 제공할 수 있습니다:\n\n· 이용자가 사전에 동의한 경우\n\n· 법령에 의해 요구되는 경우",
                      style: TextTypes.bodyMedium03(
                        color: Palette.text03,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "5. 개인정보 처리 위탁",
                      style: TextTypes.bodySemi03(
                        color: Palette.text02,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "회사는 서비스 운영을 위해 외부 업체에 개인정보 처리를 위탁할 수 있으며, 이 경우 이용자에게 사전에 고지하고 동의를 받습니다.",
                      style: TextTypes.bodyMedium03(
                        color: Palette.text03,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "6. 이용자의 권리",
                      style: TextTypes.bodySemi03(
                        color: Palette.text02,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "이용자는 언제든지 자신의 개인정보에 대해 열람, 정정, 삭제, 처리 정지를 요청할 수 있으며, 회사는 이에 대해 지체 없이 필요한 조치를 취합니다.",
                      style: TextTypes.bodyMedium03(
                        color: Palette.text03,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "7. 개인정보의 파기 절차 및 방법",
                      style: TextTypes.bodySemi03(
                        color: Palette.text02,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "회사는 개인정보의 보유 기간이 만료되거나 처리 목적이 달성된 경우 해당 정보를 지체 없이 파기합니다. 파기 절차는 내부 정책에 따라 안전하게 이루어집니다.",
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
