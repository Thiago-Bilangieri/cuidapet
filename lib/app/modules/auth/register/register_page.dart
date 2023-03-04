import 'package:cuida_pet/app/core/ui/extensions/size_screen_extension.dart';
import 'package:cuida_pet/app/core/ui/widgets/cuidapet_default_button.dart';
import 'package:cuida_pet/app/modules/auth/register/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/ui/widgets/cuidapet_text_form_field.dart';

part 'widgets/register_form.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    return GestureDetector(
      onTap: () {
        if (!currentFocus.hasPrimaryFocus) {
          return currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cadastrar Usuário'),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Image.asset(
                    "assets/images/logo.png",
                    width: 162.w,
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                _RegisterForm(
                  focusNodeScope: currentFocus,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
