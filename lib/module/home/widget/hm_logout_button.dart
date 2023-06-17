import 'dart:developer';

import 'package:fic_bloc_re_learn/data/data_sources/local_data_sources.dart';
import 'package:fic_bloc_re_learn/module/auth/login/view/login_view.dart';
import 'package:flutter/material.dart';

import '../../../shared/state_util.dart';

class HmLogoutButton extends StatelessWidget {
  const HmLogoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: IconButton(
        onPressed: () async {
          log("LogOut.....");
          //when logout remove the local login token
          await LocalDataSources().removeToke();
          log("Removing Login Token in Local Storage");
          //navigate to login page
          log("Navigate To Login Page");
          Get.offAll(const LoginView());
        },
        icon: const Icon(Icons.logout),
        iconSize: 20,
      ),
    );
  }
}
