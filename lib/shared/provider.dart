import 'package:fic_bloc_re_learn/data/data_sources/auth_data_sources.dart';
import 'package:fic_bloc_re_learn/data/data_sources/product_data_sources.dart';
import 'package:fic_bloc_re_learn/module/home/bloc/add_product/add_product_bloc.dart';
import 'package:fic_bloc_re_learn/module/home/bloc/get_product/get_product_bloc.dart';
import 'package:fic_bloc_re_learn/module/home/bloc/update_product/update_product_bloc.dart';
import 'package:fic_bloc_re_learn/shared/widgets/InputField/password_field/cubit/password_visibility_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core.dart';

class SimpleBlocProvider extends StatelessWidget {
  final Widget child;
  const SimpleBlocProvider({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) =>
              GetProductBloc(ProductDataSources()),
        ),
        BlocProvider(
          create: (BuildContext context) =>
              AddProductBloc(ProductDataSources()),
        ),
        BlocProvider(
          create: (BuildContext context) =>
              UpdateProductBloc(ProductDataSources()),
        ),
        BlocProvider(
          create: (BuildContext context) => LoginBloc(AuthDataSources()),
        ),
        BlocProvider(
          create: (BuildContext context) => RegisterBloc(AuthDataSources()),
        ),
        BlocProvider(
          create: (BuildContext context) => PasswordVisibilityCubit(),
        ),
      ],
      child: child,
    );
  }
}
