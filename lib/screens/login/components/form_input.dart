import "package:flutter/material.dart";
import "../../../constants.dart";

class FormInput extends StatelessWidget {
  FormInput({
    Key key,
    @required this.obscure,
    @required this.label,
    @required this.hintText,
    @required this.icon,
    @required this.press,
  }) : super(key: key);

  final bool obscure;
  final String label;
  final String hintText;
  final IconData icon;
  final Function press;
  final OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(28),
    borderSide: BorderSide(color: kTextColor),
    gapPadding: 10,
  );

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscure,
      keyboardType: obscure ? TextInputType.text : TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        border: outlineInputBorder,
        suffixIcon: Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 30, 20),
          child: Icon(icon),
        ),
      ),
      onChanged: press,
    );
  }
}
