import 'package:customer_app/cubit/app_cubit.dart';
import 'package:customer_app/cubit/authentication/authentication_cubit_logic.dart';
import 'package:customer_app/views/home/home_page.dart';
import 'package:customer_app/views/introduction/introduction_page.dart';
import 'package:customer_app/widgets/template_page/app_loading_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubitLogic extends StatefulWidget {
  const AppCubitLogic({Key? key}) : super(key: key);

  @override
  State<AppCubitLogic> createState() => _AppCubitLogicState();
}

class _AppCubitLogicState extends State<AppCubitLogic> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, CubitState>(
      listener: (context, state) {
        if (state is TimedOutState) {
          BlocProvider.of<AppCubit>(context).warnUser(context);
        }
      },
      builder: (context, state) {
        if (state is AuthenticatedState) {
          return const HomePage();
        }
        if (state is UnauthenticatedState) {
          return const AuthenticationCubitLogic();
        }
        if (state is FirstOpenState) {
          return const IntroductionPage();
        }
        return const AppLoadingPage();
      },
    );
  }
}
