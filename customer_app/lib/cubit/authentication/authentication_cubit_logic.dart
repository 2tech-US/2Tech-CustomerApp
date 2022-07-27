import 'package:customer_app/cubit/app_cubit.dart';
import 'package:customer_app/cubit/authentication/authentication_cubit.dart';
import 'package:customer_app/views/authenticate/login_page.dart';
import 'package:customer_app/views/authenticate/register_information_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationCubitLogic extends StatelessWidget {
  const AuthenticationCubitLogic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationCubit>(
        create: (context) => AuthenticationCubit(),
        child: BlocConsumer<AuthenticationCubit, CubitState>(
            listener: (context, state) {
          if (state is RegisterState) {
            // Navigator.of(context).push(MaterialPageRoute(
            //     // Wrap widget by BlocProvider as Navigator builds a new context
            //     builder: (_) => BlocProvider(
            //         create: (context) => AuthenticationCubit(),
            //         child: RegisterInformationPage())));
          }
          if (state is ForgotPasswordState) {
            // Navigator.of(context).push(MaterialPageRoute(
            //     builder: (_) => BlocProvider(
            //           create: (context) => AuthenticationCubit(),
            //           child: const ForgetPasswordPage(),
            //         )));
          }
        }, builder: (context, state) {
          return const LoginPage();
        }));
  }
}
