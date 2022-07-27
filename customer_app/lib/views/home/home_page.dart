import 'package:customer_app/cubit/app_cubit.dart';
import 'package:customer_app/widgets/custom_button/custom_button.dart';
import 'package:customer_app/widgets/template_page/common_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonPage(
      content: Center(
        child: Column(
          children: [
            Text('Home Page'),
            CustomButton.common(
              onTap: () {
                BlocProvider.of<AppCubit>(context).logout();
              },
              content: 'Đăng xuất',
            ),
          ],
        ),
      ),
    );
  }
}
