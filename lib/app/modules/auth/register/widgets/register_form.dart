// ignore_for_file: public_member_api_docs, sort_constructors_first
part of "../register_page.dart";

class _RegisterForm extends StatefulWidget {
  FocusScopeNode? focusNodeScope;
  _RegisterForm({
    Key? key,
    this.focusNodeScope,
  }) : super(key: key);

  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {
  final controller = Modular.get<RegisterController>();
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
            label: "Login",
            inputType: TextInputType.emailAddress,
            controller: _loginEC,
            validator: Validatorless.multiple([
              Validatorless.required("Campo Obrigátorio"),
              Validatorless.email("Digite um Email válido")
            ]),
          ),
          const SizedBox(
            height: 20,
          ),
          CuidapetTextFormField(
            controller: _passwordEC,
            validator: Validatorless.multiple([
              Validatorless.required("Senha Obrigatoria"),
              Validatorless.min(6, "Senha precisar ter ao menos 6 Caracteres")
            ]),
            label: "Senha",
            obscure: true,
          ),
          const SizedBox(
            height: 20,
          ),
          CuidapetTextFormField(
            validator: Validatorless.multiple([
              Validatorless.compare(_passwordEC, "Nao confere com a senha"),
              Validatorless.required("Campo Obrigatório")
            ]),
            label: "Confirmar Senha",
            obscure: true,
          ),
          const SizedBox(
            height: 20,
          ),
          CuidapetDefaultButton(
            label: "Cadastrar",
            onPressed: () {
              final formValidate = _formKey.currentState?.validate();
              if (formValidate!) {
                if (widget.focusNodeScope != null) {
                  widget.focusNodeScope!.hasPrimaryFocus
                      ? null
                      : widget.focusNodeScope!.unfocus();
                }
                controller.register(
                    email: _loginEC.text, password: _passwordEC.text);
                Navigator.pop(context);
              }
            },
          )
        ],
      ),
    );
  }
}
