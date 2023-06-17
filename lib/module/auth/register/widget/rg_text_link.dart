import 'package:fic_bloc_re_learn/module/auth/login/view/login_view.dart';
import 'package:fic_bloc_re_learn/shared/widgets/TextLink/text_link.dart';
import 'package:flutter/material.dart';

import '../../../../shared/state_util.dart';

class RgTextLink extends StatelessWidget {
  const RgTextLink({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextLink(
      onTap: () => Get.offAll(const LoginView()),
      label: "Sudah Punya Akun? ",
      linkText: "Login",
    );
  }
}
