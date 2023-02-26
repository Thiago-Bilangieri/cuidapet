part of '../login_page.dart';

class _LoginForm extends StatefulWidget {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          CuidapetTextFormField(label: "Login"),
          const SizedBox(
            height: 20,
          ),
          CuidapetTextFormField(
            label: "Senha",
            obscure: true,
          ),
          const SizedBox(
            height: 20,
          ),
          CuidapetDefaultButton(
            label: "Entrar",
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
