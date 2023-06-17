import 'dart:developer';

import 'package:fic_bloc_re_learn/data/data_sources/local_data_sources.dart';
import 'package:fic_bloc_re_learn/module/auth/login/widget/lg_input_area.dart';
import 'package:fic_bloc_re_learn/module/home/view/home_view.dart';
import 'package:flutter/material.dart';

import '../../../../shared/state_util.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController? emailController;
  TextEditingController? passwordController;

  void checkAuth() async {
    try {
      final localToken = await LocalDataSources().getToken();
      if (localToken.isNotEmpty) {
        log("Login Token Detected, Navigate To Home View");
        Get.offAll(const HomeView());
      }
    } catch (error) {
      log('Error: $error');
    }
  }

  @override
  void initState() {
    checkAuth();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController!.dispose();
    passwordController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 25),
        child: ListView(
          children: [
            LgInputArea(
              emailController: emailController,
              passwordController: passwordController,
            ),
          ],
        ),
      ),
    );
  }
}
