// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:fic_bloc_re_learn/data/model/register/request/register_request_model.dart';
import 'package:fic_bloc_re_learn/module/auth/login/view/login_view.dart';
import 'package:fic_bloc_re_learn/module/auth/register/bloc/register_bloc.dart';
import 'package:fic_bloc_re_learn/module/auth/register/widget/rg_text_link.dart';
import 'package:fic_bloc_re_learn/shared/widgets/Buttons/main_button.dart';
import 'package:flutter/material.dart';
import 'package:fic_bloc_re_learn/shared/widgets/InputField/password_field/password_input.dart';
import 'package:fic_bloc_re_learn/shared/widgets/InputField/text_input/text_input.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/state_util.dart';

class RgInputArea extends StatelessWidget {
  final TextEditingController? nameController;
  final TextEditingController? emailController;
  final TextEditingController? passwordController;
  const RgInputArea({
    Key? key,
    this.nameController,
    this.emailController,
    this.passwordController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RegisterBloc>();
    return Container(
      alignment: Alignment.center,
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Register',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 16.0),
          TextInput(
            controller: nameController,
            label: 'Name',
            hintText: 'Enter your name',
          ),
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
          BlocConsumer<RegisterBloc, RegisterState>(
            builder: (context, state) {
              if (state is RegisterLoading) {
                log('Loading State');
                return const Center(child: CircularProgressIndicator());
              } else if (state is RegisterLoaded) {
                log('Loaded State');
              } else if (state is RegisterError) {
                log('Error State');
              }

              return MainButton(
                label: "Register",
                onTap: () {
                  final registerModel = RegisterRequestModel(
                    name: nameController!.text,
                    email: emailController!.text,
                    password: passwordController!.text,
                  );

                  bloc.add(DoRegisterEvent(model: registerModel));
                },
              );
            },
            listener: (context, state) {
              if (state is RegisterLoaded) {
                //show success dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content:
                        Text("Register Success with id: ${state.model.id}"),
                    backgroundColor: Colors.indigoAccent,
                  ),
                );
                //navigate to login page
                Get.offAll(const LoginView());
              }

              if (state is RegisterError) {
                //show failed dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.redAccent,
                  ),
                );
              }
            },
          ),
          const SizedBox(height: 10),
          const RgTextLink(),
        ],
      ),
    );
  }
}
