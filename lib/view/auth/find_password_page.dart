import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/common/widget/bottom_btn.dart';
import 'package:app_front_talearnt/common/widget/default_text_field.dart';
import 'package:app_front_talearnt/common/widget/top_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:app_front_talearnt/view/auth/find_password_success_page.dart';
import 'package:app_front_talearnt/provider/auth/find_password_provider.dart';
import 'package:provider/provider.dart';

class FindPasswordPage extends StatelessWidget {
  FindPasswordPage({super.key});

  final _phoneNumberFormKey = GlobalKey<FormState>();
  final _userEmailFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final findPasswordProvider = Provider.of<FindPasswordProvider>(context);
    return Scaffold(
      appBar: TopAppBar(
        content: "아이디 찾기",
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      backgroundColor: Palette.bgBackGround,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "본인 확인을 통해",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Text(
                  "비밀번호를 재설정할 수 있어요",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  '휴대폰 번호',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Form(
                  key: _phoneNumberFormKey,
                  child: DefaultTextField(
                    type: 'default',
                    hint: '01012345678 형식으로 입력해주세요',
                    textEditingController:
                        findPasswordProvider.phoneNumberController,
                    keyboardType: "num",
                    validType: 'phone',
                    maxTextLength: 11,
                    onChanged: (value) {
                      findPasswordProvider.updateController();
                    },
                    provider: findPasswordProvider,
                    focusNode: findPasswordProvider.phoneNumberFocusNode,
                    validMessage: findPasswordProvider.phoneNumberValidMessage,
                    isValid: findPasswordProvider.phoneNumberValid,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  '이메일',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Form(
                  key: _userEmailFormKey,
                  child: DefaultTextField(
                    type: "email",
                    hint: "이메일을 입력해 주세요",
                    textEditingController:
                        findPasswordProvider.userEmailController,
                    provider: findPasswordProvider,
                    onChanged: (value) {
                      findPasswordProvider.updateController();
                    },
                    focusNode: findPasswordProvider.userEmailFocusNode,
                    validMessage: findPasswordProvider.userEmailMessage,
                    isValid: findPasswordProvider.userEmailValid,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          BottomBtn(
            mediaBottom: MediaQuery.of(context).viewInsets.bottom,
            content: '비밀번호 찾기',
            isEnabled: findPasswordProvider.isValidAllInput,
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FindPasswordSuccessPage(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
