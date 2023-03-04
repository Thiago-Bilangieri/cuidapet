import 'package:cuida_pet/app/core/ui/extensions/size_screen_extension.dart';
import 'package:cuida_pet/app/core/ui/extensions/theme_extension.dart';
import 'package:cuida_pet/app/core/ui/icons/cuidapet_icons_icons.dart';
import 'package:cuida_pet/app/core/ui/widgets/cuidapet_default_button.dart';
import 'package:cuida_pet/app/core/ui/widgets/cuidapet_text_form_field.dart';
import 'package:cuida_pet/app/core/ui/widgets/rounded_button.dart';
import 'package:cuida_pet/app/modules/auth/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:validatorless/validatorless.dart';

part 'widgets/login_form.dart';
part 'widgets/login_register_buttons.dart';

class LoginPage extends StatelessWidget {
  final testeEC = TextEditingController();
  final formKey = GlobalKey<FormState>();
  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FocusScopeNode focus = FocusScope.of(context);

    return GestureDetector(
      onTap: () {
        if (!focus.hasPrimaryFocus) {
          focus.unfocus();
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                SizedBox(
                  height: 50.h,
                ),
                Center(
                  child: Image.asset(
                    "assets/images/logo.png",
                    width: 162.w,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                _LoginForm(focusNodeScope: focus),
                const SizedBox(
                  height: 8,
                ),
                const _OrSeparator(),
                const _LoginRegisterButtons()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OrSeparator extends StatelessWidget {
  const _OrSeparator();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            thickness: 2,
            color: context.primaryColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            " OU ",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
                color: context.primaryColor),
          ),
        ),
        Expanded(
          child: Divider(
            thickness: 2,
            color: context.primaryColor,
          ),
        )
      ],
    );
  }
}
