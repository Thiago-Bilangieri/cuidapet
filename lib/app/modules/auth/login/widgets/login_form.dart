// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../login_page.dart';

class _LoginForm extends StatefulWidget {
  FocusScopeNode? focusNodeScope;

  _LoginForm({
    Key? key,
    this.focusNodeScope,
  }) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final controller = Modular.get<LoginController>();
  final _formKey = GlobalKey<FormState>();
  final _loginEC = TextEditingController();
  final _passwordEC = TextEditingController();

  @override
  void dispose() {
    _loginEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CuidapetTextFormField(
            inputType: TextInputType.emailAddress,
            label: "Login",
            controller: _loginEC,
            validator: Validatorless.multiple([
              Validatorless.required("Login é obrigatorio"),
              Validatorless.email("Digite um email valido"),
            ]),
          ),
          const SizedBox(
            height: 20,
          ),
          CuidapetTextFormField(
            controller: _passwordEC,
            validator: Validatorless.required("Senha Obrigatoria."),
            label: "Senha",
            obscure: true,
          ),
          const SizedBox(
            height: 20,
          ),
          CuidapetDefaultButton(
            label: "Entrar",
            onPressed: () async {
              if (_formKey.currentState?.validate() ?? false) {
                if (widget.focusNodeScope != null) {
                  widget.focusNodeScope!.hasPrimaryFocus
                      ? null
                      : widget.focusNodeScope!.unfocus();
                }
                await controller.login(_loginEC.text, _passwordEC.text);
              }
            },
          )
        ],
      ),
    );
  }
}
