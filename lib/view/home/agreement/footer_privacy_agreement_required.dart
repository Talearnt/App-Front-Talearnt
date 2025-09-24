import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/common/widget/bottom_btn.dart';
import 'package:app_front_talearnt/common/widget/top_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FooterPrivacyAgreementRequired extends StatelessWidget {
  const FooterPrivacyAgreementRequired({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.bgBackGround,
      appBar: TopAppBar(
        content: "개인정보처리방침",
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
                      "2025. 09. 14 (현재)",
                      style: TextTypes.body02(
                        color: Palette.text02,
                      ),
                    ),
                    const SizedBox(height: 56),
                    Text(
                      "제1조 (개인정보의 처리 목적)",
                      style: TextTypes.heading4(
                        color: Palette.text01,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Divider(
                      color: Palette.primary01, // 선 색상
                      thickness: 2.0, // 선 두께
                    ),
                    const SizedBox(height: 24),
                    Text.rich(
                      TextSpan(
                        text:
                            'Talearnt(이하 “회사”)는 다음의 목적을 위해 필요한 최소한의 개인정보를 처리하고 있습니다. 처리하고 있는 개인정보는 다음 목적 이외의 용도로는 이용되지 않으며, 이용 목적이 변경될 경우 별도의 동의를 받는 등 필요한 조치를 이행할 것입니다\n\n 1. ',
                        style: TextTypes.bodyMedium03(
                          color: Palette.text03,
                        ),
                        children: [
                          TextSpan(
                            text: '회원 가입 및 서비스 이용 관리',
                            style: TextTypes.bodyMedium03(
                              color: Palette.text02,
                            ),
                          ),
                          TextSpan(
                            text:
                                ': 회원 가입 의사 확인, 서비스 이용 및 관리, 이용자 식별, 본인 확인, 불량 회원의 부정 이용 방지 및 제재, 비인가 사용 방지, 가입 및 탈퇴 의사 확인 등\n\n2. ',
                            style: TextTypes.bodyMedium03(
                              color: Palette.text03,
                            ),
                          ),
                          TextSpan(
                            text: '서비스 제공 및 운영',
                            style: TextTypes.bodyMedium03(
                              color: Palette.text02,
                            ),
                          ),
                          TextSpan(
                            text:
                                ': 매칭 서비스 제공, 커뮤니티 활동 지원, 콘텐츠 등록/관리, 공지사항 전달, 문의사항 또는 불만 처리, 회원 관리 등\n\n3. ',
                            style: TextTypes.bodyMedium03(
                              color: Palette.text03,
                            ),
                          ),
                          TextSpan(
                            text: '마케팅 및 광고 활용',
                            style: TextTypes.bodyMedium03(
                              color: Palette.text02,
                            ),
                          ),
                          TextSpan(
                            text:
                                ': 신규 서비스 개발 및 맞춤형 서비스 제공, 이벤트 및 프로모션 참여 기회 제공, 접속 빈도 파악 또는 회원의 서비스 이용에 대한 통계 등',
                            style: TextTypes.bodyMedium03(
                              color: Palette.text03,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 72),
                    Text(
                      "제2조 (개인정보의 수집 항목 및 방법)",
                      style: TextTypes.heading4(
                        color: Palette.text01,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Divider(
                      color: Palette.primary01, // 선 색상
                      thickness: 2.0, // 선 두께
                    ),
                    const SizedBox(height: 24),
                    Text.rich(
                      TextSpan(
                        text: '회사는 다음과 같이 개인정보를 수집 및 이용합니다. ',
                        style: TextTypes.bodyMedium03(
                          color: Palette.text03,
                        ),
                        children: [
                          TextSpan(
                            text: '필수 항목',
                            style: TextTypes.bodyMedium03(
                              color: Palette.text02,
                            ),
                          ),
                          TextSpan(
                            text: '은 서비스 제공을 위해 반드시 필요한 정보이며, ',
                            style: TextTypes.bodyMedium03(
                              color: Palette.text03,
                            ),
                          ),
                          TextSpan(
                            text: '선택 항목',
                            style: TextTypes.bodyMedium03(
                              color: Palette.text02,
                            ),
                          ),
                          TextSpan(
                            text:
                                '은 더 나은 서비스 제공을 위해 추가로 수집하는 정보입니다. 이용자는 선택 항목의 수집에 동의하지 않아도 서비스 이용에 제한을 받지 않습니다.\n\n',
                            style: TextTypes.bodyMedium03(
                              color: Palette.text03,
                            ),
                          ),
                          TextSpan(
                            text: ' 1. 회원가입 시 수집 항목\n',
                            style: TextTypes.bodyMedium03(
                              color: Palette.text02,
                            ),
                          ),
                          TextSpan(
                            text: ' · ',
                            style: TextTypes.bodyMedium03(
                              color: Palette.text03,
                            ),
                          ),
                          TextSpan(
                            text: '필수 항목',
                            style: TextTypes.bodyMedium03(
                              color: Palette.text02,
                            ),
                          ),
                          TextSpan(
                            text: ': 이메일 주소, 비밀번호, 닉네임, 이름, 성별, 휴대폰 번호\n',
                            style: TextTypes.bodyMedium03(
                              color: Palette.text03,
                            ),
                          ),
                          TextSpan(
                            text: ' · ',
                            style: TextTypes.bodyMedium03(
                              color: Palette.text03,
                            ),
                          ),
                          TextSpan(
                            text: '선택 항목',
                            style: TextTypes.bodyMedium03(
                              color: Palette.text02,
                            ),
                          ),
                          TextSpan(
                            text: ': 프로필 이미지, 관심사, 직업 등\n',
                            style: TextTypes.bodyMedium03(
                              color: Palette.text03,
                            ),
                          ),
                          TextSpan(
                            text: ' · ',
                            style: TextTypes.bodyMedium03(
                              color: Palette.text03,
                            ),
                          ),
                          TextSpan(
                            text: '소셜 로그인 시',
                            style: TextTypes.bodyMedium03(
                              color: Palette.text02,
                            ),
                          ),
                          TextSpan(
                            text: ': 소셜 계정의 고유 식별 정보\n\n',
                            style: TextTypes.bodyMedium03(
                              color: Palette.text03,
                            ),
                          ),
                          TextSpan(
                            text: ' 2. 서비스 이용 과정에서 자동 수집 항목\n',
                            style: TextTypes.bodyMedium03(
                              color: Palette.text02,
                            ),
                          ),
                          TextSpan(
                            text:
                                ' · 서비스 이용 기록, 접속 일시, IP Address, 기기 정보(OS, UDID), 쿠키, 불량 이용 기록\n\n',
                            style: TextTypes.bodyMedium03(
                              color: Palette.text03,
                            ),
                          ),
                          TextSpan(
                            text: ' 3. 고객 문의 시 수집 항목\n',
                            style: TextTypes.bodyMedium03(
                              color: Palette.text02,
                            ),
                          ),
                          TextSpan(
                            text: ' · 문의 내용에 포함된 정보(이메일 주소, 이름, 휴대폰 번호 등)\n\n',
                            style: TextTypes.bodyMedium03(
                              color: Palette.text03,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 72),
                    Text(
                      "제3조 (개인정보의 제3자 제공)",
                      style: TextTypes.heading4(
                        color: Palette.text01,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Divider(
                      color: Palette.primary01, // 선 색상
                      thickness: 2.0, // 선 두께
                    ),
                    const SizedBox(height: 24),
                    Text.rich(
                      TextSpan(
                        text: '회사는 이용자의 개인정보를 ',
                        style: TextTypes.bodyMedium03(
                          color: Palette.text03,
                        ),
                        children: [
                          TextSpan(
                            text: '원칙적으로 제3자에게 제공하지 않으며, ',
                            style: TextTypes.bodyMedium03(
                              color: Palette.text02,
                            ),
                          ),
                          TextSpan(
                            text: '다음의 경우에만 예외적으로 제공할 수 있습니다.\n',
                            style: TextTypes.bodyMedium03(
                              color: Palette.text03,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ' 1. ',
                          style: TextTypes.bodyMedium03(
                            color: Palette.text03,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "이용자가 사전에 동의한 경우\n",
                            style: TextTypes.bodyMedium03(
                              color: Palette.text03,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ' 2. ',
                          style: TextTypes.bodyMedium03(
                            color: Palette.text03,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "법률에 특별한 규정이 있는 경우\n",
                            style: TextTypes.bodyMedium03(
                              color: Palette.text03,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ' 3. ',
                          style: TextTypes.bodyMedium03(
                            color: Palette.text03,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "수사 목적으로 법령에 따른 적법한 절차와 방법에 따라 수사기관의 요청이 있는 경우",
                            style: TextTypes.bodyMedium03(
                              color: Palette.text03,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 72),
                    Text(
                      "제4조 (개인정보 처리 위탁 및 국외 이전)",
                      style: TextTypes.heading4(
                        color: Palette.text01,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Divider(
                      color: Palette.primary01, // 선 색상
                      thickness: 2.0, // 선 두께
                    ),
                    const SizedBox(height: 24),
                    Text(
                      '회사는 원활한 개인정보 업무처리를 위해 개인정보 처리 업무를 위탁하고 있습니다. 위탁 계약 시 개인정보보호 관련 법규의 준수, 개인정보에 관한 비밀유지, 제3자 제공 금지 및 사고 발생 시 책임 부담 등을 명확히 규정하고, 해당 계약 내용을 서면 또는 전자적으로 보관하고 있습니다.',
                      style: TextTypes.bodyMedium03(
                        color: Palette.text03,
                      ),
                    ),
                    Text(
                      '· 개인정보 처리 위탁',
                      style: TextTypes.bodyMedium03(
                        color: Palette.text03,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '      · ',
                          style: TextTypes.bodyMedium03(
                            color: Palette.text03,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "수탁업체: [개발팀 확인 후 기재: 예) 문자 발송업체, 고객 상담 솔루션 제공업체]",
                            style: TextTypes.bodyMedium03(
                              color: Palette.text03,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '      · ',
                          style: TextTypes.bodyMedium03(
                            color: Palette.text03,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "위탁업무 내용: [개발팀 확인 후 기재: 예) 본인 인증, 고객 문의 응대, 마케팅 문자 발송 등]",
                            style: TextTypes.bodyMedium03(
                              color: Palette.text03,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '· 개인정보 국외 이전',
                      style: TextTypes.bodyMedium03(
                        color: Palette.text03,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '      · ',
                          style: TextTypes.bodyMedium03(
                            color: Palette.text03,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "이전되는 국가: [개발팀 확인 필요]",
                            style: TextTypes.bodyMedium03(
                              color: Palette.text03,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '      · ',
                          style: TextTypes.bodyMedium03(
                            color: Palette.text03,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "이전받는 자: 개발팀 확인 필요]",
                            style: TextTypes.bodyMedium03(
                              color: Palette.text03,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '      · ',
                          style: TextTypes.bodyMedium03(
                            color: Palette.text03,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "이전 목적: 클라우드 인프라 운영 및 관리",
                            style: TextTypes.bodyMedium03(
                              color: Palette.text03,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '      · ',
                          style: TextTypes.bodyMedium03(
                            color: Palette.text03,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "이전 항목: 개인정보 처리방침 상에 명시된 모든 개인정보]",
                            style: TextTypes.bodyMedium03(
                              color: Palette.text03,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '      · ',
                          style: TextTypes.bodyMedium03(
                            color: Palette.text03,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "보유 및 이용 기간: 회원 탈퇴 시까지",
                            style: TextTypes.bodyMedium03(
                              color: Palette.text03,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 72),
                    Text(
                      "제5조 (개인정보의 파기)",
                      style: TextTypes.heading4(
                        color: Palette.text01,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Divider(
                      color: Palette.primary01, // 선 색상
                      thickness: 2.0, // 선 두께
                    ),
                    const SizedBox(height: 24),
                    Text(
                      '회사는 개인정보 수집 및 이용 목적이 달성된 후에는 해당 정보를 지체 없이 파기합니다. 단, 관계 법령에 따라 보존해야 하는 정보는 법령이 정한 기간 동안 보관 후 파기합니다.\n\n',
                      style: TextTypes.bodyMedium03(
                        color: Palette.text03,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '1. ',
                          style: TextTypes.bodyMedium03(
                            color: Palette.text03,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '파기 절차 및 방법: 파기 사유가 발생한 개인정보를 선정하고, 개인정보 보호 책임자의 승인을 받아 파기합니다. 전자적 파일 형태의 정보는 기록을 재생할 수 없는 기술적 방법을 사용하여 파기하며, 종이 문서에 기록된 개인정보는 분쇄기로 분쇄하거나 소각하여 파기합니다.\n\n',
                            style: TextTypes.bodyMedium03(
                              color: Palette.text03,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '2. 법령 및 내부 방침에 따른 보존:',
                      style: TextTypes.bodyMedium03(
                        color: Palette.text03,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '      · ',
                          style: TextTypes.bodyMedium03(
                            color: Palette.text03,
                          ),
                        ),
                        Expanded(
                          child: Text.rich(
                            TextSpan(
                              text: '개인 식별 정보(이름, 닉네임, 프로필 사진 등): ',
                              style: TextTypes.bodyMedium03(
                                color: Palette.text03,
                              ),
                              children: [
                                TextSpan(
                                  text: '회원 탈퇴 7일 후 파기',
                                  style: TextTypes.bodyMedium03(
                                    color: Palette.text02,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '      · ',
                          style: TextTypes.bodyMedium03(
                            color: Palette.text03,
                          ),
                        ),
                        Expanded(
                          child: Text.rich(TextSpan(
                            text: "서비스 이용 기록(IP 주소, 접속 기록 등): 「통신비밀보호법」에 따라 ",
                            style: TextTypes.bodyMedium03(
                              color: Palette.text03,
                            ),
                            children: [
                              TextSpan(
                                text: '3개월 보존',
                                style: TextTypes.bodyMedium03(
                                  color: Palette.text02,
                                ),
                              ),
                            ],
                          )),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '      · ',
                          style: TextTypes.bodyMedium03(
                            color: Palette.text03,
                          ),
                        ),
                        Expanded(
                          child: Text.rich(TextSpan(
                            text:
                                "부정 이용 기록: 부정 이용 방지 및 서비스 운영의 일관성 유지를 위해, 부정 이용자 기록은 ",
                            style: TextTypes.bodyMedium03(
                              color: Palette.text03,
                            ),
                            children: [
                              TextSpan(
                                text:
                                    '해당 이용자가 서비스 이용 제한 조치를 받은 날로부터 서비스 운영 종료 까지 보관될 수 있습니다.',
                                style: TextTypes.bodyMedium03(
                                  color: Palette.text02,
                                ),
                              ),
                            ],
                          )),
                        ),
                      ],
                    ),
                    const SizedBox(height: 72),
                    Text(
                      "제6조 (이용자의 권리와 그 행사 방법)",
                      style: TextTypes.heading4(
                        color: Palette.text01,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Divider(
                      color: Palette.primary01, // 선 색상
                      thickness: 2.0, // 선 두께
                    ),
                    const SizedBox(height: 24),
                    Text(
                      '이용자는 언제든지 등록되어 있는 자신의 개인정보를 조회하거나 수정할 수 있으며, 회원 탈퇴를 요청할 수도 있습니다.\n\n',
                      style: TextTypes.bodyMedium03(
                        color: Palette.text03,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '1. ',
                          style: TextTypes.bodyMedium03(
                            color: Palette.text03,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "개인정보 열람, 정정, 삭제, 처리 정지 요청: 서비스 내 '마이페이지’ 메뉴를 통해 직접 가능하며, 어려운 경우 서면, 전화, 이메일 등을 통해 회사에 요청할 수 있습니다.\n\n",
                            style: TextTypes.bodyMedium03(
                              color: Palette.text03,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '2. ',
                          style: TextTypes.bodyMedium03(
                            color: Palette.text03,
                          ),
                        ),
                        Expanded(
                          child: Text.rich(
                            TextSpan(
                              text:
                                  '대리인을 통한 권리 행사: 이용자의 법정대리인이나 위임을 받은 자가 권리를 행사할 수 있으며, 이 경우 ',
                              style: TextTypes.bodyMedium03(
                                color: Palette.text03,
                              ),
                              children: [
                                TextSpan(
                                  text: ' 「개인정보보호법 시행규칙」에 따른 위임장',
                                  style: TextTypes.bodyMedium03(
                                    color: Palette.text02,
                                  ),
                                ),
                                TextSpan(
                                  text: '을 제출해야 합니다.',
                                  style: TextTypes.bodyMedium03(
                                    color: Palette.text03,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 72),
                    Text(
                      "제7조 (개인정보 안전성 확보 조치)",
                      style: TextTypes.heading4(
                        color: Palette.text01,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Divider(
                      color: Palette.primary01, // 선 색상
                      thickness: 2.0, // 선 두께
                    ),
                    const SizedBox(height: 24),
                    Text(
                      '회사는 개인정보의 안전성 확보를 위해 다음과 같은 조치를 취하고 있습니다.\n\n',
                      style: TextTypes.bodyMedium03(
                        color: Palette.text03,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '1. ',
                          style: TextTypes.bodyMedium03(
                            color: Palette.text03,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "관리적 조치: 개인정보 처리 최소화, 정기적인 임직원 교육, 내부 관리계획 수립 및 시행 등\n\n",
                            style: TextTypes.bodyMedium03(
                              color: Palette.text03,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '2. ',
                          style: TextTypes.bodyMedium03(
                            color: Palette.text03,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "기술적 조치: 개인정보 암호화, 접근 통제 시스템 구축, 보안 프로그램 설치 및 갱신, 백업 시스템 운영 등",
                            style: TextTypes.bodyMedium03(
                              color: Palette.text03,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 72),
                    Text(
                      "제8조 (쿠키 및 유사 기술의 사용)",
                      style: TextTypes.heading4(
                        color: Palette.text01,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Divider(
                      color: Palette.primary01, // 선 색상
                      thickness: 2.0, // 선 두께
                    ),
                    const SizedBox(height: 24),
                    Text(
                      '회사는 이용자에게 맞춤형 서비스를 제공하기 위해 쿠키(Cookie)를 사용합니다. 이용자는 웹 브라우저의 옵션을 설정하여 모든 쿠키를 허용하거나, 거부할 수 있습니다. 단, 쿠키 저장을 거부할 경우 일부 서비스 이용에 어려움이 있을 수 있습니다.',
                      style: TextTypes.bodyMedium03(
                        color: Palette.text03,
                      ),
                    ),
                    const SizedBox(height: 72),
                    Text(
                      "제9조 (개인정보 보호 책임자 및 고충처리 부서)",
                      style: TextTypes.heading4(
                        color: Palette.text01,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Divider(
                      color: Palette.primary01, // 선 색상
                      thickness: 2.0, // 선 두께
                    ),
                    const SizedBox(height: 24),
                    Text(
                      '회사는 개인정보 처리에 관한 업무를 총괄해서 책임지고, 개인정보 처리와 관련한 이용자의 불만 처리 및 피해 구제 등을 위해 아래와 같이 개인정보 보호 책임자를 지정하고 있습니다.\n\n'
                      ' · 개인정보 보호 책임자\n'
                      '      · 성명: 정운만\n'
                      '      · 소속/직위: 대표\n'
                      '      · 연락처: 010-2908-9421\n\n'
                      ' · 고충처리 담당 부서\n'
                      '      · 부서명: Talearnt\n'
                      '      · 연락처: 010-2908-9421',
                      style: TextTypes.bodyMedium03(
                        color: Palette.text03,
                      ),
                    ),
                    const SizedBox(height: 72),
                    Text(
                      "제10조 (권익침해 구제 방법)",
                      style: TextTypes.heading4(
                        color: Palette.text01,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Divider(
                      color: Palette.primary01, // 선 색상
                      thickness: 2.0, // 선 두께
                    ),
                    const SizedBox(height: 24),
                    Text(
                      '이용자는 개인정보 침해에 대한 피해 구제, 상담 등을 아래 기관에 문의할 수 있습니다.\n\n',
                      style: TextTypes.bodyMedium03(
                        color: Palette.text03,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '1. ',
                          style: TextTypes.bodyMedium03(
                            color: Palette.text03,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "개인정보 침해신고센터: (국번없이) 118 (privacy.kisa.or.kr)\n\n",
                            style: TextTypes.bodyMedium03(
                              color: Palette.text03,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '2. ',
                          style: TextTypes.bodyMedium03(
                            color: Palette.text03,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "개인정보 분쟁조정위원회: (국번없이) 1833-6972 (kopico.go.kr)",
                            style: TextTypes.bodyMedium03(
                              color: Palette.text03,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '3. ',
                          style: TextTypes.bodyMedium03(
                            color: Palette.text03,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "대검찰청 사이버수사과: (국번없이) 1301 (spo.go.kr)",
                            style: TextTypes.bodyMedium03(
                              color: Palette.text03,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '4. ',
                          style: TextTypes.bodyMedium03(
                            color: Palette.text03,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "경찰청 사이버안전국: (국번없이) 182 (cyberbureau.police.go.k",
                            style: TextTypes.bodyMedium03(
                              color: Palette.text03,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 72),
                    Text(
                      "제11조 (개인정보 처리방침 변경)",
                      style: TextTypes.heading4(
                        color: Palette.text01,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Divider(
                      color: Palette.primary01, // 선 색상
                      thickness: 2.0, // 선 두께
                    ),
                    const SizedBox(height: 24),
                    Text(
                      '이 방침은 법령 및 회사 정책의 변경에 따라 변경될 수 있으며, 변경 시 최소 7일 전 홈페이지를 통해 공지합니다. 단, 중요한 변경 사항이 발생할 경우 최소 30일 전에 공지합니다.',
                      style: TextTypes.bodyMedium03(
                        color: Palette.text03,
                      ),
                    ),
                    const SizedBox(height: 72),
                    Text(
                      "부칙",
                      style: TextTypes.heading4(
                        color: Palette.text01,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Divider(
                      color: Palette.primary01, // 선 색상
                      thickness: 2.0, // 선 두께
                    ),
                    const SizedBox(height: 24),
                    Text(
                      '본 방침은 2025.09.01부터 적용됩니다.',
                      style: TextTypes.bodyMedium03(
                        color: Palette.text03,
                      ),
                    ),
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
