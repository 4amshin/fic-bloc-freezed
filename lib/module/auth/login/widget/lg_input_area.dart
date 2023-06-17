// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:fic_bloc_re_learn/core.dart';
import 'package:fic_bloc_re_learn/data/data_sources/local_data_sources.dart';
import 'package:fic_bloc_re_learn/data/model/login/request/login_request_model.dart';
import 'package:fic_bloc_re_learn/shared/widgets/TextLink/text_link.dart';
import 'package:flutter/material.dart';

import 'package:fic_bloc_re_learn/shared/widgets/Buttons/main_button.dart';
import 'package:fic_bloc_re_learn/shared/widgets/InputField/password_field/password_input.dart';
import 'package:fic_bloc_re_learn/shared/widgets/InputField/text_input/text_input.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LgInputArea extends StatelessWidget {
  final TextEditingController? emailController;
  final TextEditingController? passwordController;
  const LgInputArea({
    Key? key,
    this.emailController,
    this.passwordController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LoginBloc>();

    return Container(
      alignment: Alignment.center,
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Login',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 16.0),
          TextInput(
            controller: emailController,
            label: 'Email',
            hintText: 'Enter your email',
          ),
          const SizedBox(height: 16.0),
          PasswordInput(
            controller: passwordController,
            label: 'Password',
            hintText: 'Enter your password',
          ),
          const SizedBox(height: 25),
          BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginLoaded) {
                //saved login token we get from api
                LocalDataSources().saveToken(state.model.accessToken!);
                //show success dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Login Success",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    backgroundColor: Colors.greenAccent,
                  ),
                );
                //navigate to home page
                Get.offAll(const HomeView());
              }

              if (state is LoginError) {
                //show success dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.message,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    backgroundColor: Colors.redAccent,
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is LoginLoading) {
                log('Loading State');
                return const Center(child: CircularProgressIndicator());
              } else if (state is LoginLoaded) {
                log('Loaded State');
              } else if (state is LoginError) {
                log('Error State');
              }
              return MainButton(
                label: "Login",
                onTap: () {
                  final loginModel = LoginRequestModel(
                    email: emailController!.text,
                    password: passwordController!.text,
                  );
                  bloc.add(DoLoginEvent(model: loginModel));
                },
              );
            },
          ),
          const SizedBox(height: 10),
          TextLink(
            onTap: () => Get.offAll(const RegisterView()),
            label: "Belum Punya Akun? ",
            linkText: "Register",
          ),
        ],
      ),
    );
  }
}
