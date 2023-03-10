part of "../login_page.dart";

class _LoginRegisterButtons extends StatelessWidget {
  const _LoginRegisterButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      direction: Axis.horizontal,
      alignment: WrapAlignment.center,
      children: [
        RoundedButton(
            onTap: () {},
            width: .42.sw,
            color: const Color(0xff4267b3),
            icon: CuidapetIcons.facebook,
            text: "Facebook"),
        RoundedButton(
            onTap: () {},
            width: .42.sw,
            color: const Color(0xffe15031),
            icon: CuidapetIcons.google,
            text: "Google"),
        RoundedButton(
            onTap: () => Navigator.pushNamed(context, "/auth/register/"),
            width: .42.sw,
            color: context.primaryColorDark,
            icon: Icons.mail,
            text: "Cadastre-se")
      ],
    );
  }
}
