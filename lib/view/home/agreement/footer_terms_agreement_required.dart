import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/common/widget/bottom_btn.dart';
import 'package:app_front_talearnt/common/widget/top_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FooterTermsAgreementRequired extends StatelessWidget {
  const FooterTermsAgreementRequired({super.key});

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
                      "2025. 09. 14 (현재)",
                      style: TextTypes.body02(
                        color: Palette.text02,
                      ),
                    ),
                    const SizedBox(height: 56),
                    Text(
                      "제1장 총칙",
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
                      "제 1 조 (목적)",
                      style: TextTypes.bodySemi03(
                        color: Palette.text01,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '1.1 본 약관은 Talearnt(이하 “서비스"라 함)가 제공하는 재능 교환 매칭 서비스 및 커뮤니티 이용에 관한 기본적인 사항을 규정함을 목적으로 합니다',
                      style: TextTypes.bodyMedium03(
                        color: Palette.text03,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "제2조 (용어의 정의)",
                      style: TextTypes.bodySemi03(
                        color: Palette.text01,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '2.1 본 약관에서 사용하는 주요 용어의 정의는 다음과 같습니다:\n"서비스"란 재능 교환을 원하는 사람들을 연결하는 중개 플랫폼을 말합니다.\n"이용자"란 서비스에 접속하여 본 약관에 따라 서비스를 이용하는 회원 및 비회원을 말합니다.\n"매칭"이란 서비스 내에서 서로의 니즈가 부합하는 이용자 간의 연결을 의미합니다.\n"커뮤니티"란 서비스 내에서 이용자들이 의견을 공유할 수 있는 게시판을 말합니다.\n"콘텐츠"란 이용자가 서비스에 게시한 글, 이미지, 영상, 음성 등 정보통신망에서 사용되는 부호, 문자, 음향, 이미지 또는 영상 등의 정보를 의미합니다.',
                      style: TextTypes.bodyMedium03(
                        color: Palette.text03,
                      ),
                    ),
                    const SizedBox(height: 72),
                    Text(
                      "제2장 서비스 이용 계약",
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
                      "제3조 (이용 계약의 성립)",
                      style: TextTypes.bodySemi03(
                        color: Palette.text01,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '3.1 본 서비스에 대한 이용계약은 이용자가 본 약관에 동의하고, Talearnt가 정한 절차에 따라 회원가입을 신청한 후, 회사가 이를 승낙함으로써 성립됩니다. 단, Talearnt가 별도의 확인 절차를 진행하는 경우, 해당 절차가 완료되어 Talearnt가 가입 승인을 통지한 시점에 계약이 성립된 것으로 간주합니다.\n\n3.2 회사는 이용자의 신청에 대해 서비스 이용을 승낙함을 원칙으로 하나, 다음 각 호에 해당하는 경우 승낙을 유보하거나 거절할 수 있습니다.\n · 타인의 명의 또는 정보를 도용한 경우\n · 허위 정보를 기재한 경우\n · 미성년자가 법정대리인의 동의 없이 신청한 경우\n · 기타 회사의 내부 기준에 따라 승낙이 부적절하다고 판단되는 경우\n\n3.3 이용계약은 회원 단위로 체결되며, 하나의 계정은 당사자 본인만 이용할 수 있습니다. 회원은 본인의 계정 정보를 제3자에게 양도하거나 공유할 수 없습니다.\n\n3.4 만 19세 미만의 미성년자는 법정대리인의 동의를 받은 경우에만 회원가입 및 서비스 이용이 가능합니다.\n회사는 가입자의 연령 또는 동의 여부를 별도로 확인하지 않으며, 이를 이유로 발생한 문제에 대해서는 책임을 지지 않습니다. 단, 미성년자가 법정대리인의 동의 없이 가입한 경우, 회사는 해당 이용계약을 취소하거나 제한할 수 있습니다',
                      style: TextTypes.bodyMedium03(
                        color: Palette.text03,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "제4조 (이용자의 의무)",
                      style: TextTypes.bodySemi03(
                        color: Palette.text01,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '4.1 이용자는 다음 각 호의 의무를 성실히 준수하여야 합니다.\n · 본인의 정보를 정확하고 최신 상태로 등록할 것\n · 타인의 권리를 침해하거나 불법적인 내용을 게시하지 않을 것\n · 서비스 운영을 방해하지 않을 것\n\n4.2 이용자는 서비스에 게시하는 콘텐츠가 타인의 명예를 훼손하거나, 저작권 등 타인의 지식재산권을 침해하는 내용을 포함하지 않도록 주의해야 합니다. 이로 인해 발생하는 모든 법적 책임은 해당 콘텐츠를 게시한 이용자가 부담하며, 회사는 책임을 지지 않습니다.',
                      style: TextTypes.bodyMedium03(
                        color: Palette.text03,
                      ),
                    ),
                    const SizedBox(height: 72),
                    Text(
                      "제3장 서비스 이용",
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
                      "제5조 (서비스의 내용)",
                      style: TextTypes.bodySemi03(
                        color: Palette.text01,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '5.1 Talearnt는 다음과 같은 서비스를 제공합니다.\n · 재능 교환 니즈가 부합하는 이용자 간의 매칭 중개\n · 이용자 간의 의견 공유를 위한 커뮤니티 제공\n\n5.2 이용자가 서비스 내에 게시한 콘텐츠에 대한 저작권은 해당 콘텐츠의 저작자에게 있습니다. 단, 이용자는 서비스 내 게시물을 Talearnt가 서비스 운영 및 마케팅, 홍보, 서비스 개선, 뉴스 콘텐츠 인용 등 필요한 범위 내에서 수정, 복제, 배포, 전시하는 것에 동의합니다. 회사는 이와 같은 사실을 이용자에게 사전에 통지해야 하며, 이용자는 언제든지 고객센터를 통해 해당 게시물에 대해 삭제, 비공개 등의 조치를 요청할 수 있습니다.\n\n5.3 Talearnt는 시스템 점검, 증설, 교체 등 운영상 필요한 경우 서비스의 전부 또는 일부를 일시적으로 중단할 수 있습니다. 이 경우 회사는 사전에 서비스 화면이나 공지사항을 통해 이용자에게 이를 고지하며, 부득이한 사유로 인해 사전 고지가 어려운 경우에는 사후에라도 이를 고지합니다. 단, 천재지변 등 불가항력적인 사유로 인한 서비스 중단에는 고지 의무가 면제됩니다.',
                      style: TextTypes.bodyMedium03(
                        color: Palette.text03,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "제6조 (서비스 이용 제한)",
                      style: TextTypes.bodySemi03(
                        color: Palette.text01,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '6.1 Talearnt는 다음 각 호에 해당하는 경우 서비스 이용을 제한할 수 있습니다.\n · 허위 정보 등록\n · 타인의 개인정보 또는 계정 도용\n · 범죄, 자금세탁, 허위거래 유도 등 불법 목적의 이용\n · 서비스 운영을 방해하거나, 저작권 등 회사 및 제3자의 지식재산권을 침해하는 행위\n · 외설적이거나 폭력적인 메시지, 기타 공서양속에 반하는 정보를 공개·게시하는 행위\n · 스크래핑, 복제 등 영리 목적으로 서비스를 무단 활용하는 행위\n · 서비스 내에서 서로 연락처를 교환하거나 직접 만남을 유도하는 행위\n\n6.2 회사는 제6조 1항에 해당하는 행위가 발생한 경우, 해당 이용자에 대해 서비스 이용을 일시 정지하거나 영구적으로 이용 계약을 해지할 수 있습니다. 서비스 이용 제한 및 해지 결정 시 회사는 해당 이용자에게 그 사유를 통지합니다.\n\n6.3 회사는 이용자가 허위 정보를 기재하여 이용 계약을 체결했거나, 타인의 정보를 도용하여 서비스를 이용한 사실이 확인될 경우, 사전 통보 없이 해당 이용자의 계정을 영구적으로 정지하거나 이용 계약을 해지할 수 있습니다.',
                      style: TextTypes.bodyMedium03(
                        color: Palette.text03,
                      ),
                    ),
                    const SizedBox(height: 72),
                    Text(
                      "제4장 개인정보 보호",
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
                      "제7조 (개인정보 보호)",
                      style: TextTypes.bodySemi03(
                        color: Palette.text01,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '7.1 Talearnt는 「개인정보 보호법」, 「정보통신망 이용촉진 및 정보보호 등에 관한 법률」 등 관계 법령을 준수하며, 이용자의 개인정보를 안전하게 보호하기 위하여 최선을 다합니다.\n\n7.2 회사는 개인정보처리방침을 수립하여 이용자가 언제든지 열람할 수 있도록 서비스 내에 게시하며, 이를 통해 개인정보의 수집 항목, 이용 목적, 보유 및 이용 기간, 제3자 제공, 위탁 처리 여부 등에 대해 명확히 안내합니다.\n\n7.3 회사는 서비스 제공을 위하여 필요한 범위 내에서 최소한의 개인정보를 수집하며, 이용자의 동의 없이 개인정보를 수집하거나 외부에 제공하지 않습니다. 단, 다음의 경우는 예외로 합니다.\n · 법령에 특별한 규정이 있는 경우\n · 수사기관, 법원 등의 요청이 있는 경우\n · 이용자가 사전에 공개에 동의한 경우\n\n7.4 Talearnt는 수집된 개인정보를 사전 동의 없이 목적 외로 이용하거나 제3자에게 제공하지 않으며, 외부 업체에 개인정보 처리를 위탁하는 경우에는 위탁업체 및 위탁 범위에 대해 이용자에게 사전 고지하고 필요한 동의를 받습니다.\n\n7.5 이용자는 언제든지 자신의 개인정보에 대해 열람, 정정, 삭제, 처리정지 등을 요청할 수 있으며, 회사는 이에 대해 법령이 정한 바에 따라 지체 없이 조치합니다.\n\n7.6 개인정보의 보호 및 안전한 처리를 위하여 암호화, 접근 통제 등의 기술적·관리적 보호조치를 시행하고 있습니다.\n\n7.7 개인정보 보호와 관련된 상세한 사항은 회사의 개인정보처리방침에 따르며, 본 약관과 상충하는 경우에는 개인정보처리방침이 우선합니다.',
                      style: TextTypes.bodyMedium03(
                        color: Palette.text03,
                      ),
                    ),
                    const SizedBox(height: 72),
                    Text(
                      "제5장 책임과 면책",
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
                      "제8조 (서비스의 책임)",
                      style: TextTypes.bodySemi03(
                        color: Palette.text01,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '8.1 Talearnt는 단순 중개 플랫폼으로서 아래 사항에 대해 법적 책임을 지지 않습니다.\n · 매칭 당사자 간 계약 체결, 이행, 불이행, 분쟁 및 손해 발생 등 결과\n · 이용자가 제공한 정보의 정확성, 진위, 완전성\n · 매칭 과정 또는 커뮤니티 활동 중 발생하는 분쟁\n\n8.2 Talearnt는 관련 분쟁 발생 시, 관계기관의 요청이 있을 경우 보유 정보를 제공할 수 있습니다. 단, Talearnt는 중개자에 불과하며 분쟁의 직접 당사자가 아니므로, 분쟁 해결 또는 이에 대한 법적 책임은 부담하지 않습니다.\n\n8.3 Talearnt가 서비스를 종료하고자 할 경우, 종료 예정일로부터 최소 1개월 전에 이용자에게 해당 사실을 고지합니다. 서비스 종료에 대한 고지는 서비스 내 공지사항 게시 또는 전자우편 발송 등의 방법으로 이루어질 수 있습니다.',
                      style: TextTypes.bodyMedium03(
                        color: Palette.text03,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "제9조 (면책)",
                      style: TextTypes.bodySemi03(
                        color: Palette.text01,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '9.1 이용자는 매칭 또는 커뮤니티 활동과 관련된 모든 행위에 대한 책임을 스스로 부담하며, 이에 따른 분쟁 또는 손해에 대해 Talearnt는 책임을 지지 않습니다.\n\n9.2 천재지변, 전쟁, 정책 변경, 기타 불가항력적 사유로 인한 서비스 장애에 대해 Talearnt는 책임을 지지 않습니다.\n\n9.3 이용자의 고의 또는 과실로 인한 서비스 이용 장애에 대해서도 책임을 지지 않습니다.\n\n9.4 회사는 이용자가 서비스 내에 게시한 링크를 통해 접속하게 되는 외부 웹사이트의 신뢰성, 안전성, 내용의 적법성 등에 대해 보증하지 않으며, 이로 인해 발생한 손해에 대해서는 책임을 지지 않습니다.\n\n9.5 이용자가 본 약관의 규정을 위반하여 회사에 손해가 발생한 경우, 해당 이용자는 회사에 발생한 손해를 배상할 책임이 있습니다.',
                      style: TextTypes.bodyMedium03(
                        color: Palette.text03,
                      ),
                    ),
                    const SizedBox(height: 72),
                    Text(
                      "제6장 분쟁 해결",
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
                      "제10조 (분쟁 해결)",
                      style: TextTypes.bodySemi03(
                        color: Palette.text01,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '10.1 회사와 이용자 간 서비스 이용과 관련하여 발생한 분쟁은 당사자 간 성실한 협의를 통해 원만히 해결하도록 노력합니다.\n\n10.2 제1항에 따른 협의가 이루어지지 않을 경우, 분쟁의 해결은 관련 법령에 따라 진행하며, 민사소송법에 따른 관할 법원을 제1심 관할 법원으로 합니다. 단, 회사의 주소지를 관할하는 법원을 관할 법원으로 지정하는 데 이용자는 이에 동의한 것으로 간주합니다.\n\n10.3 Talearnt는 이용자 간 분쟁이 발생했을 경우, 원만한 문제 해결을 위해 개입하거나 필요한 조치를 취할 수 있습니다. 또한 분쟁 해결을 위한 요청이 있는 경우, 관련 법령에 따라 상대방의 정보를 제공할 수 있습니다.\n\n10.4 이용자 간 분쟁이 자체적으로 해결되지 않을 경우, 회사는 분쟁 조정 위원회 등 외부 기관에 이관을 안내하고 관련 정보를 제공할 수 있으며, 이관 이후부터는 해당 기관의 결정을 신뢰합니다.\n\n10.5 회사는 본 서비스를 통하여 이용자 간 또는 이용자와 제3자 간에 발생한 거래, 연락, 분쟁 등에 대하여 어떠한 책임도 부담하지 않으며, 관련된 법적 책임은 해당 당사자 간에 직접 해결해야 합니다.\n\n10.6 회사는 이용자의 귀책사유로 인해 발생한 문제에 대해 어떠한 책임도 지지 않으며, 회사의 고의 또는 중대한 과실이 없는 한 서비스 제공과 관련하여 발생한 손해에 대해서도 책임을 지지 않습니다.\n\n10.7 회사는 전자상거래 등에서의 소비자 보호에 관한 법률, 콘텐츠산업 진흥법 등 관계 법령에서 요구하는 최소한의 소비자 보호 의무를 이행하며, 필요한 경우 관계기관의 분쟁 조정 절차에 따라 협조할 수 있습니다. 그러나 해당 절차는 회사의 법적 책임을 의미하지는 않습니다.',
                      style: TextTypes.bodyMedium03(
                        color: Palette.text03,
                      ),
                    ),
                    const SizedBox(height: 72),
                    Text(
                      "제7장 회원 탈퇴",
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
                      "제11조 (회원 탈퇴)",
                      style: TextTypes.bodySemi03(
                        color: Palette.text01,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '11.1 회원 탈퇴 시 다음의 개인정보 항목은 파기됩니다: 이름, 성별, 전화번호, 이메일, 비밀번호, 닉네임, [프로필 사진, 관심 키워드, 찜 정보 등 수집 항목에 따라 추가].\n\n11.2 회원 탈퇴 신청은 개인정보 파기에 대한 동의로 간주되며, 신청일로부터 7일간 보관 후 완전 삭제됩니다.\n\n11.3 ‘통신비밀보호법’에 따라 이용기록[ 로그인 이력, IP주소 등 기술적인 로그 정보는 탈퇴 후 최대 3개월간 별도 저장될 수 있으며, 부정 이용 기록을 위한 목적으로도 보관 될 수 있습니다.\n\n11.4 부정 이용 방지를 위해 탈퇴 후 7일간 재가입이 제한됩니다.\n\n11.5 회원이 작성한 게시물, 댓글 등은 탈퇴 후에도 삭제되지 않으며, 작성자 정보를 익명화 처리하거나 닉네임을 "탈퇴회원"으로 변경할 수 있습니다.\n\n11.6 이용자가 서비스의 이용을 더 이상 원하지 않을 경우 언제든지 이용계약의 해지 신청을 할 수 있으며, 회사는 관련 법령이 정하는 바에 따라 이를 신속히 처리합니다. 다만, 다음 각 호의 어느 하나에 해당하는 경우에는 해당 사유가 해소될 때까지 이용계약의 해지가 제한될 수 있습니다.\n1) 이용자가 관련 법령을 위반하여 수사기관이나 사법기관으로부터 해당 계정에 대한 조사나 압수, 수색 등의 요청이 있는 경우\n2) 회사와 이용자 간에 서비스 이용과 관련하여 분쟁 조정, 소송 등의 절차가 진행 중이며, 해당 이용자의 계정 정보가 분쟁 해결을 위해 필요한 경우\n\n11.7 본 조에 따라 해지를 한 회원은 본 약관이 정하는 회원가입 절차와 관련 조항에 따라 회원으로 다시 가입할 수 있습니다. 다만 회원이 중복 참여가 제한된 이벤트 중복 참여 등 부정한 목적으로 회원 탈퇴 후 재가입 신청하는 경우 회사는 재가입을 일정 기간 동안 제한할 수 있습니다.\n\n11.8 회사는 서비스 운영의 일관성 및 재발 방지, 법적 분쟁 대비 등을 위해 영구 이용 제한 조치를 받은 이용자의 개인정보 및 관련 기록을 별도로 서비스 운영기간 동안 보관할 수 있습니다. 보관되는 정보는 위반 행위의 구체적인 사유, 발생 시점, IP 주소 등이며, 해당 정보는 재가입 방지 및 소송 등에 필요한 최소한의 범위 내에서만 이용됩니다.',
                      style: TextTypes.bodyMedium03(
                        color: Palette.text03,
                      ),
                    ),
                    const SizedBox(height: 72),
                    Text(
                      "제8장 기타",
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
                      "제12조 (약관 변경)",
                      style: TextTypes.bodySemi03(
                        color: Palette.text01,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '12.1 Talearnt는 필요한 경우 본 약관을 변경할 수 있으며, 변경사항은 시행일자 7일 전부터 서비스 내 공지사항을 통해 고지합니다.\n\n12.2 이용자에게 불리한 내용으로 약관을 변경할 경우에는 최소 30일 전에 서비스 내 공지사항 및 기타 통지 수단(전자우편 등)을 통해 개별적으로 고지합니다. 회사는 위 공지 또는 통지를 하면서 이용자가 거부 의사를 표시하지 않으면 변경된 약관에 동의한 것으로 간주한다는 뜻을 명확하게 고지합니다.\n\n12.3 이용자는 변경된 약관에 동의하지 않을 권리가 있으며, 동의하지 않을 경우 서비스 이용을 중단하고 탈퇴를 요청할 수 있습니다.',
                      style: TextTypes.bodyMedium03(
                        color: Palette.text03,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "제13조 (준거법 및 기타 조항)",
                      style: TextTypes.bodySemi03(
                        color: Palette.text01,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '13.1 본 약관에 명시되지 않은 사항은 관련 법령에 따릅니다.',
                      style: TextTypes.bodyMedium03(
                        color: Palette.text03,
                      ),
                    ),
                    const SizedBox(height: 72),
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
