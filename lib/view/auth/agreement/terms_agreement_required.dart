import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/common/widget/bottom_btn.dart';
import 'package:app_front_talearnt/common/widget/top_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TermsAgreementRequired extends StatelessWidget {
  const TermsAgreementRequired({super.key});

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
                      "이용약관 동의",
                      style: TextTypes.bodySemi02(
                        color: Palette.text02,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "제 1 조 (목적)",
                      style: TextTypes.bodySemi02(
                        color: Palette.text02,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "이 약관은 Talearnt(이하 '회사')가 제공하는 온라인 재능 및 전문성 교환 플랫폼 서비스(이하 '서비스')의 이용과 관련하여 회사와 이용자 간의 권리, 의무 및 책임 사항, 기타 필요한 사항을 규정함을 목적으로 합니다.",
                      style: TextTypes.bodyMedium02(
                        color: Palette.text03,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "제 2 조 (정의)",
                      style: TextTypes.bodySemi02(
                        color: Palette.text02,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "1. '서비스'란 회사가 제공하는 온라인 플랫폼을 통해 이용자 간의 재능 및 전문성 교환을 중개하는 서비스를 의미합니다.\n\n2. '이용자'란 회사의 플랫폼에 접속하여 본 약관에 따라 회사가 제공하는 서비스를 이용하는 자를 말합니다.\n\n3. '회원'이란 회사에 개인정보를 제공하여 회원 등록을 한 자로서, 회사가 제공하는 정보를 지속적으로 제공받으며 서비스를 이용할 수 있는 자를 말합니다.\n\n4. '비회원'이란 회원으로 가입하지 않고 회사가 제공하는 서비스를 이용하는 자를 말합니다.",
                      style: TextTypes.bodyMedium02(
                        color: Palette.text03,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "제 3 조 (약관의 명시, 효력 및 개정)",
                      style: TextTypes.bodySemi02(
                        color: Palette.text02,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "1. 회사는 본 약관을 이용자가 알 수 있도록 서비스 초기 화면 또는 연결 화면에 게시합니다.\n\n2. 회사는 필요 시 약관을 개정할 수 있으며, 개정된 약관은 적용일자 및 개정사유를 명시하여 적용일자 7일 전부터 서비스 내 또는 공지사항을 통해 게시합니다. 다만, 이용자에게 불리한 약관 개정의 경우 30일의 사전 유예 기간을 두고 공지합니다.\n\n3. 이용자는 변경된 약관에 동의하지 않을 권리가 있으며, 동의하지 않는 경우 서비스 이용을 중단하고 탈퇴할 수 있습니다.",
                      style: TextTypes.bodyMedium02(
                        color: Palette.text03,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "제 4 조 (서비스의 제공 및 변경)",
                      style: TextTypes.bodySemi02(
                        color: Palette.text02,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "1. 회사는 다음과 같은 서비스를 제공합니다:\n\n· 재능 및 전문성 교환을 위한 매칭 서비스\n\n· 재능 인증 및 평가 시스템\n\n· 기타 회사가 정하는 서비스\n\n2. 회사는 서비스의 내용 및 제공 방법을 변경할 수 있으며, 변경 사항은 사전에 공지합니다.\n\n3. 회사는 무료로 제공되는 서비스의 일부 또는 전부를 회사의 정책 및 운영의 필요에 따라 수정, 중단할 수 있으며, 이에 대해 관련 법령에 특별한 규정이 없는 한 별도의 보상을 하지 않습니다.",
                      style: TextTypes.bodyMedium02(
                        color: Palette.text03,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "제 5 조 (서비스 이용 및 제한)",
                      style: TextTypes.bodySemi02(
                        color: Palette.text02,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "1. 회원은 회사가 정한 절차에 따라 서비스 이용을 신청하고, 회사가 이를 승낙한 경우에 서비스를 이용할 수 있습니다.\n\n2. 회사는 다음의 경우 서비스 제공을 거부할 수 있습니다:\n\n· 허위 정보를 제공하거나, 타인의 정보를 도용한 경우\n\n· 서비스 이용 요건을 충족하지 못한 경우\n\n· 기타 회사의 정책에 따라 승낙이 불가능한 경우",
                      style: TextTypes.bodyMedium02(
                        color: Palette.text03,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "제 6 조 (서비스의 중단)",
                      style: TextTypes.bodySemi02(
                        color: Palette.text02,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "1. 회사는 다음과 같은 사유가 발생한 경우 서비스의 전부 또는 일부를 제한하거나 중단할 수 있습니다:\n\n· 시스템 점검, 유지보수 또는 교체 등의 사유\n\n· 정전, 통신망 장애, 기타 불가항력적인 사유가 발생한 경우\n\n2. 회사는 본 조에 따라 서비스를 중단하게 되는 경우 사전에 공지하며, 긴급하거나 불가피한 경우 사후에 공지할 수 있습니다.",
                      style: TextTypes.bodyMedium02(
                        color: Palette.text03,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "제 7 조 (회원의 의무)",
                      style: TextTypes.bodySemi02(
                        color: Palette.text02,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "1. 회원은 다음 행위를 하여서는 안 됩니다:\n\n· 타인의 정보 도용\n\n· 회사의 서비스 운영을 방해하는 행위\n\n· 회사의 명예를 훼손하거나 불이익을 주는 행위\n\n2. 회원은 본 약관 및 관련 법령을 준수해야 하며, 이를 위반할 경우 서비스 이용이 제한될 수 있습니다.",
                      style: TextTypes.bodyMedium02(
                        color: Palette.text03,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "제 8 조 (회사의 의무)",
                      style: TextTypes.bodySemi02(
                        color: Palette.text02,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "1. 회사는 관련 법령을 준수하며, 서비스 제공을 위해 지속적으로 노력합니다.\n\n2. 회사는 이용자가 안전하게 서비스를 이용할 수 있도록 개인정보 보호를 위한 보안 시스템을 구축합니다.",
                      style: TextTypes.bodyMedium02(
                        color: Palette.text03,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "제 9 조 (계약 해지 및 이용 제한)",
                      style: TextTypes.bodySemi02(
                        color: Palette.text02,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "1. 회원은 언제든지 서비스 탈퇴를 요청할 수 있으며, 회사는 즉시 회원 탈퇴를 처리합니다.\n\n2. 회사는 회원이 본 약관을 위반하거나 법령에 위반되는 행위를 한 경우, 사전 통지 후 서비스 이용을 제한하거나 계약을 해지할 수 있습니다.",
                      style: TextTypes.bodyMedium02(
                        color: Palette.text03,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "제 10 조 (손해배상 및 면책)",
                      style: TextTypes.bodySemi02(
                        color: Palette.text02,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "1. 회사는 무료로 제공되는 서비스와 관련하여 발생한 손해에 대해 법적 책임을 지지 않습니다.\n\n2. 회사는 천재지변, 전쟁, 테러, 통신 장애 등 불가항력적 사유로 인해 발생한 손해에 대해서는 책임을 지지 않습니다.",
                      style: TextTypes.bodyMedium02(
                        color: Palette.text03,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "제 11 조 (분쟁 해결)",
                      style: TextTypes.bodySemi02(
                        color: Palette.text02,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "1. 회사와 이용자 간에 발생한 분쟁과 관련하여 양 당사자는 성실히 협의하여 해결해야 합니다.\n\n2. 본 약관과 관련된 소송은 대한민국 법을 따르며, 관할 법원은 회사의 본사 소재지를 관할하는 법원으로 합니다.",
                      style: TextTypes.bodyMedium02(
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
